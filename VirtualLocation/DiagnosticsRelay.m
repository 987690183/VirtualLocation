//
//  DiagnosticsRelay.m
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/25.
//  Copyright © 2019 luolei. All rights reserved.
//

#import "DiagnosticsRelay.h"
#include <libimobiledevice/libimobiledevice.h>
#include <libimobiledevice/lockdown.h>
#include <libimobiledevice/diagnostics_relay.h>

@implementation DiagnosticsRelay

+ (BOOL)restartDevice:(NSString *)udid
{
    BOOL result = NO;;

    idevice_t device = NULL;
    lockdownd_client_t lockdown_client = NULL;
    diagnostics_relay_client_t diagnostics_client = NULL;
    lockdownd_error_t ret = LOCKDOWN_E_UNKNOWN_ERROR;
    lockdownd_service_descriptor_t service = NULL;

    if (IDEVICE_E_SUCCESS != idevice_new(&device, [udid UTF8String])) {
        return result;
    }
    if (LOCKDOWN_E_SUCCESS != (ret = lockdownd_client_new_with_handshake(device, &lockdown_client, "idevicediagnostics"))) {
        idevice_free(device);
        return result;
    }
    ret = lockdownd_start_service(lockdown_client, "com.apple.mobile.diagnostics_relay", &service);
    if (ret != LOCKDOWN_E_SUCCESS) {
        /*  attempt to use older diagnostics service */
        ret = lockdownd_start_service(lockdown_client, "com.apple.iosdiagnostics.relay", &service);
    }
    if ((ret == LOCKDOWN_E_SUCCESS) && service && (service->port > 0)) {
        if (diagnostics_relay_client_new(device, service, &diagnostics_client) != DIAGNOSTICS_RELAY_E_SUCCESS) {
            printf("Could not connect to diagnostics_relay!\n");
        }else{
            if (diagnostics_relay_restart(diagnostics_client, DIAGNOSTICS_RELAY_ACTION_FLAG_DISPLAY_PASS) == DIAGNOSTICS_RELAY_E_SUCCESS) {
                printf("Restarting device.\n");
                result = YES;
            } else {
                printf("Failed to restart device.\n");
            }
            diagnostics_relay_goodbye(diagnostics_client);
            diagnostics_relay_client_free(diagnostics_client);
        }
    }
    if (lockdown_client) {
        lockdownd_client_free(lockdown_client);
    }
    if (service) {
        lockdownd_service_descriptor_free(service);
        service = NULL;
    }
    idevice_free(device);
    return result;
}
@end
