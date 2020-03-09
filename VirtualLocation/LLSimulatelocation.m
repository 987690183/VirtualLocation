//
//  LLSimulatelocation.m
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/9.
//  Copyright © 2019 luolei. All rights reserved.
//

#import "LLSimulatelocation.h"
#include <libimobiledevice/libimobiledevice.h>
#include <libimobiledevice/lockdown.h>
#include <libimobiledevice/service.h>

@implementation LLSimulatelocation

+ (BOOL)simulateLocation:(NSString *)latStr lng:(NSString *)lngStr udid:(NSString *)udid
{
    BOOL result = NO;
    idevice_t phone = NULL;
    lockdownd_client_t client = NULL;
    service_client_t service_client = NULL;
    lockdownd_service_descriptor_t service = NULL;
    if (IDEVICE_E_SUCCESS != idevice_new(&phone, [udid UTF8String])) {
        return result;
    }
    if (
        LOCKDOWN_E_SUCCESS !=
        lockdownd_client_new_with_handshake(phone, &client, "lldevicelocation")
        ) {
       
    }
    if ((lockdownd_start_service(client, "com.apple.dt.simulatelocation",  &service) != LOCKDOWN_E_SUCCESS) || !service) {
    }
   
    service_error_t se = service_client_new(phone, service, &service_client);
    if (se) {
        //需要安装developerdiskimage
        NSLog(@"Could not crate Service Client.\n");
    } else {
        char *lat = (char *)[latStr UTF8String];
        char *lng = (char *)[lngStr UTF8String];
        service_error_t e;
        uint32_t sent = 0;
        
        do {
            uint32_t startMessage = htonl(0);
            uint32_t lat_len = htonl(strlen(lat));
            uint32_t lng_len = htonl(strlen(lng));
            
            // start
            //debug_info("Sending start.");
            e = service_send(service_client, (void*)&startMessage, sizeof(startMessage), &sent);
            if (e) {
                break;
            }
            // lat
            //debug_info("Sending latitude.");
            e = service_send(service_client, (void*)&lat_len, sizeof(lat_len), &sent);
            e = service_send(service_client, lat, (uint32_t)strlen(lat), &sent);
            if (e) {
                break;
            }
            // lng
            //debug_info("Sending longitude.");
            e = service_send(service_client, (void*)&lng_len, sizeof(lng_len), &sent);
            e = service_send(service_client, lng, (uint32_t)strlen(lng), &sent);
            if (e) {
                break;
            }
            result = YES;
            break;
        } while (true);
    }
    
    if (service_client) {
        service_client_free(service_client);
    }
    service_client = NULL;
    if (service) {
        lockdownd_service_descriptor_free(service);
    }
    service = NULL;
    
    if (client) {
        lockdownd_client_free(client);
    }
    if (phone) {
        idevice_free(phone);
    }
    return result;
}

+ (BOOL)restoreLocation:(NSString *)udid;
{
    BOOL result = NO;
    idevice_t phone = NULL;
    lockdownd_client_t client = NULL;
    service_client_t service_client = NULL;
    lockdownd_service_descriptor_t service = NULL;
    
    if (IDEVICE_E_SUCCESS != idevice_new(&phone, [udid UTF8String])) {
        return result;
    }
    if (
        LOCKDOWN_E_SUCCESS !=
        lockdownd_client_new_with_handshake(phone, &client, "lldevicelocation")
        ) {
        
    }
    if ((lockdownd_start_service(client, "com.apple.dt.simulatelocation",  &service) != LOCKDOWN_E_SUCCESS) || !service) {
    }
    service_error_t se = service_client_new(phone, service, &service_client);
    if (se) {
        NSLog(@"Could not crate Service Client.\n");
    } else {
        service_error_t e;
        uint32_t sent = 0;
        uint32_t stopMessage = htonl(1);
        e = service_send(service_client, (void*)&stopMessage, sizeof(stopMessage), &sent);
        if (e) {
            printf("Could not send data to Service Client.\n");
        }
        result = YES;
    }
    
    if (service_client) {
        service_client_free(service_client);
    }
    service_client = NULL;
    if (service) {
        lockdownd_service_descriptor_free(service);
    }
    service = NULL;
    
    if (client) {
        lockdownd_client_free(client);
    }
    if (phone) {
        idevice_free(phone);
    }
    return result;
}

@end
