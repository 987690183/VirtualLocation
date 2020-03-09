//
//  Deviceimagemounter.m
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/31.
//  Copyright © 2019 luolei. All rights reserved.
//

#import "Deviceimagemounter.h"
#include <libimobiledevice/libimobiledevice.h>
#include <libimobiledevice/lockdown.h>
#include <libimobiledevice/service.h>
#include <libimobiledevice/mobile_image_mounter.h>
#include <libimobiledevice/afc.h>

static const char PKG_PATH[] = "PublicStaging";
static const char PATH_PREFIX[] = "/private/var/mobile/Media";
static char *imagetype = NULL;

typedef enum {
    DISK_IMAGE_UPLOAD_TYPE_AFC,
    DISK_IMAGE_UPLOAD_TYPE_UPLOAD_IMAGE
} disk_image_upload_type_t;


@implementation Deviceimagemounter

static ssize_t mim_upload_cb(void* buf, size_t size, void* userdata)
{
    return fread(buf, 1, size, (FILE*)userdata);
}

+(BOOL)mountImage:(NSString *)imagePath signPath:(NSString *)signPath udid:(NSString *)udid
{
    BOOL rresult = NO;
    idevice_t device = NULL;
    lockdownd_client_t lckd = NULL;
    lockdownd_error_t ldret = LOCKDOWN_E_UNKNOWN_ERROR;
    mobile_image_mounter_client_t mim = NULL;
    afc_client_t afc = NULL;
    lockdownd_service_descriptor_t service = NULL;
    const char *image_path = NULL;
    size_t image_size = 0;
    const char *image_sig_path = NULL;
    
    
    image_path = [imagePath UTF8String];
    image_sig_path = [signPath UTF8String];
    
    if (IDEVICE_E_SUCCESS != idevice_new(&device, [udid UTF8String])) {
        
    }
    if (LOCKDOWN_E_SUCCESS != (ldret = lockdownd_client_new_with_handshake(device, &lckd, "ideviceimagemounter"))) {
        
    }
    plist_t pver = NULL;
    char *product_version = NULL;
    lockdownd_get_value(lckd, NULL, "ProductVersion", &pver);
    if (pver && plist_get_node_type(pver) == PLIST_STRING) {
        plist_get_string_val(pver, &product_version);
    }
    disk_image_upload_type_t disk_image_upload_type = DISK_IMAGE_UPLOAD_TYPE_AFC;
    int product_version_major = 0;
    int product_version_minor = 0;
    if (product_version) {
        if (sscanf(product_version, "%d.%d.%*d", &product_version_major, &product_version_minor) == 2) {
            if (product_version_major >= 7)
                disk_image_upload_type = DISK_IMAGE_UPLOAD_TYPE_UPLOAD_IMAGE;
        }
    }
    lockdownd_start_service(lckd, "com.apple.mobile.mobile_image_mounter", &service);
    
    if (mobile_image_mounter_new(device, service, &mim) != MOBILE_IMAGE_MOUNTER_E_SUCCESS) {
        printf("ERROR: Could not connect to mobile_image_mounter!\n");
    }
    
    if (service) {
        lockdownd_service_descriptor_free(service);
        service = NULL;
    }
    struct stat fst;
    if (disk_image_upload_type == DISK_IMAGE_UPLOAD_TYPE_AFC) {
        if ((lockdownd_start_service(lckd, "com.apple.afc", &service) !=
             LOCKDOWN_E_SUCCESS) || !service || !service->port) {
            fprintf(stderr, "Could not start com.apple.afc!\n");
        }
        if (afc_client_new(device, service, &afc) != AFC_E_SUCCESS) {
            fprintf(stderr, "Could not connect to AFC!\n");
        }
        if (service) {
            lockdownd_service_descriptor_free(service);
            service = NULL;
        }
    }
    if (stat(image_path, &fst) != 0) {
        fprintf(stderr, "ERROR: stat: %s: %s\n", image_path, strerror(errno));
    }
    image_size = fst.st_size;
    if (stat(image_sig_path, &fst) != 0) {
        fprintf(stderr, "ERROR: stat: %s: %s\n", image_sig_path, strerror(errno));
    }
    
    mobile_image_mounter_error_t err;
    plist_t result = NULL;
    
    char sig[8192];
    size_t sig_length = 0;
    FILE *f = fopen(image_sig_path, "rb");
    if (!f) {
        fprintf(stderr, "Error opening signature file '%s': %s\n", image_sig_path, strerror(errno));
    }
    sig_length = fread(sig, 1, sizeof(sig), f);
    fclose(f);
    if (sig_length == 0) {
        fprintf(stderr, "Could not read signature from file '%s'\n", image_sig_path);
    }
    
    f = fopen(image_path, "rb");
    if (!f) {
        fprintf(stderr, "Error opening image file '%s': %s\n", image_path, strerror(errno));
    }
    
    char *targetname = NULL;
    if (asprintf(&targetname, "%s/%s", PKG_PATH, "staging.dimage") < 0) {
        fprintf(stderr, "Out of memory!?\n");
    }
    char *mountname = NULL;
    if (asprintf(&mountname, "%s/%s", PATH_PREFIX, targetname) < 0) {
        fprintf(stderr, "Out of memory!?\n");
    }

    if (!imagetype) {
        imagetype = strdup("Developer");
    }
    
    switch(disk_image_upload_type) {
        case DISK_IMAGE_UPLOAD_TYPE_UPLOAD_IMAGE:
            printf("Uploading %s\n", image_path);
            err = mobile_image_mounter_upload_image(mim, imagetype, image_size, sig, sig_length, mim_upload_cb, f);
            break;
        case DISK_IMAGE_UPLOAD_TYPE_AFC:
        default:
            printf("Uploading %s --> afc:///%s\n", image_path, targetname);
            char **strs = NULL;
            if (afc_get_file_info(afc, PKG_PATH, &strs) != AFC_E_SUCCESS) {
                if (afc_make_directory(afc, PKG_PATH) != AFC_E_SUCCESS) {
                    fprintf(stderr, "WARNING: Could not create directory '%s' on device!\n", PKG_PATH);
                }
            }
            if (strs) {
                int i = 0;
                while (strs[i]) {
                    free(strs[i]);
                    i++;
                }
                free(strs);
            }
            
            uint64_t af = 0;
            if ((afc_file_open(afc, targetname, AFC_FOPEN_WRONLY, &af) !=
                 AFC_E_SUCCESS) || !af) {
                fclose(f);
                fprintf(stderr, "afc_file_open on '%s' failed!\n", targetname);
            }
            
            char buf[8192];
            size_t amount = 0;
            do {
                amount = fread(buf, 1, sizeof(buf), f);
                if (amount > 0) {
                    uint32_t written, total = 0;
                    while (total < amount) {
                        written = 0;
                        if (afc_file_write(afc, af, buf, amount, &written) !=
                            AFC_E_SUCCESS) {
                            fprintf(stderr, "AFC Write error!\n");
                            break;
                        }
                        total += written;
                    }
                    if (total != amount) {
                        fprintf(stderr, "Error: wrote only %d of %d\n", total,
                                (unsigned int)amount);
                        afc_file_close(afc, af);
                        fclose(f);
                    }
                }
            }
            while (amount > 0);
            afc_file_close(afc, af);
            break;
    }
    fclose(f);
    printf("done.\n");
    printf("Mounting...\n");
    err = mobile_image_mounter_mount_image(mim, mountname, sig, sig_length, imagetype, &result);
    free(imagetype);
    if (err == MOBILE_IMAGE_MOUNTER_E_SUCCESS) {
        if (result) {
            plist_t node = plist_dict_get_item(result, "Status");
            if (node) {
                char *status = NULL;
                plist_get_string_val(node, &status);
                if (status) {
                    if (!strcmp(status, "Complete")) {
                        printf("Done.\n");
                        rresult = YES;
                    } else {
                        printf("unexpected status value:\n");
                    }
                    free(status);
                } else {
                }
            }
            node = plist_dict_get_item(result, "Error");
            if (node) {
                char *error = NULL;
                plist_get_string_val(node, &error);
                if (error) {
                    printf("Error: %s\n", error);
                    free(error);
                } else {
                    printf("unexpected result:\n");
                }
            } else {
            }
        }
    
    }else{
        NSLog(@"faild");
    }
    if (result) {
        plist_free(result);
    }
    if (mim) {
        mobile_image_mounter_hangup(mim);
        mobile_image_mounter_free(mim);
    }
    if (afc) {
        afc_client_free(afc);
    }
    if (lckd) {
        lockdownd_client_free(lckd);
    }
    if (device) {
        idevice_free(device);
    }
    return rresult;
}

@end
