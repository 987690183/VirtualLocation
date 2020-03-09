//
//  LLDevicePool.m
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/24.
//  Copyright © 2019 luolei. All rights reserved.
//

#import "LLDevicePool.h"
#include <libimobiledevice/libimobiledevice.h>
#include <libimobiledevice/lockdown.h>
@implementation LLDevicePool

void newidevice_event_cb_t(const idevice_event_t *event, void *user_data){
    
    switch(event->event) {
        case IDEVICE_DEVICE_ADD:{
            [(__bridge LLDevicePool *)user_data notifyDeviceConnection:event->udid];
            NSLog(@"add device %s", event->udid);
        }
            break;
        case IDEVICE_DEVICE_REMOVE:{
            [(__bridge LLDevicePool *)user_data notifyDeviceDisConnection:event->udid];

            NSLog(@"remove device %s", event->udid);
        }
            break;
        case IDEVICE_DEVICE_PAIRED:{
            NSLog(@"paired device %s", event->udid);
        }
            break;
        default: {
            
        }break;
    }
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _devicePool = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)startLisen
{
    idevice_error_t error = idevice_event_subscribe(newidevice_event_cb_t, (__bridge void *)(self));
    if (error == IDEVICE_E_SUCCESS) {
    }
}
#pragma mark - DeviceConnection
- (void)notifyDeviceConnection:(const char*)udid
{
    idevice_t phone = NULL;
    lockdownd_client_t client = NULL;
    
    if (IDEVICE_E_SUCCESS != idevice_new(&phone, udid)) {
        return ;
    }
    lockdownd_error_t error = lockdownd_client_new_with_handshake(phone, &client, "idevicepair");
    if (error == LOCKDOWN_E_INVALID_CONF) {
        idevice_free(phone);
        usleep(1000*1000);
        [self notifyDeviceConnection:udid];
        return;
    }else if (error == LOCKDOWN_E_SUCCESS){
        
        LLDevice *device = [[LLDevice alloc] init];
        device.deviceName = [LLDevicePool getLockDownStringValue:nil key:@"DeviceName" client:client];
        device.serialNumber = [LLDevicePool getLockDownStringValue:nil key:@"SerialNumber" client:client];
        device.productType = [LLDevicePool getLockDownStringValue:nil key:@"ProductType" client:client];
        device.udid = [LLDevicePool getLockDownStringValue:nil key:@"UniqueDeviceID" client:client];
        device.iOSVersion = [LLDevicePool getLockDownStringValue:nil key:@"ProductVersion" client:client];
        if (![self getDevice:device.udid]) {
            [self addDevice:device];
            if ([self.delegate respondsToSelector:@selector(notifyDeviceConnection:)]) {
                [self.delegate notifyDeviceConnection:device.udid];
            }
        }
    }else{
        idevice_free(phone);
        return;
    }
    lockdownd_client_free(client);
    idevice_free(phone);
}

#pragma mark - DeviceDisConnection
- (void)notifyDeviceDisConnection:(const char*)udid
{
    [self removeDevice:[NSString stringWithUTF8String:udid]];
    if ([self.delegate respondsToSelector:@selector(notifyDeviceDisConnection:)]) {
        [self.delegate notifyDeviceDisConnection:[NSString stringWithUTF8String:udid]];
    }
}

#pragma mark - add and remove device
- (void)addDevice:(LLDevice *)device
{
    [_devicePool setObject:device forKey:device.udid];
}
- (void)removeDevice:(NSString *)udid;
{
    [_devicePool removeObjectForKey:udid];
}

- (LLDevice *)getDevice:(NSString *)udid{
    return [_devicePool objectForKey:udid];
}

- (long)deviceCount
{
    return [[_devicePool allKeys] count];
}

+ (NSString *)getLockDownStringValue:(NSString *)domain key:(NSString *)key client:(lockdownd_client_t)client
{
    plist_t value = NULL;
    lockdownd_error_t ret = LOCKDOWN_E_UNKNOWN_ERROR;
    char *reslut = NULL;
    
    ret = lockdownd_get_value(client, [domain UTF8String], [key UTF8String], &value);
    if (ret != LOCKDOWN_E_SUCCESS) {
        return nil;
    }
    plist_get_string_val(value, &reslut);
    plist_free(value);
    value = NULL;
    NSString *valueStr = [NSString stringWithUTF8String:reslut];
    if (reslut != NULL) {
        free(reslut);
    }
    return valueStr;
}
@end
