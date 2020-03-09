//
//  LLDevice.m
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/24.
//  Copyright © 2019 luolei. All rights reserved.
//

#import "LLDevice.h"

@implementation LLDevice

- (NSString *)getDeviceFamilyString {
    NSString *familyTypeStr = nil;
    switch (_deviceType) {
        case LL_iPod_Unknown: {
            familyTypeStr = @"iPod_Unknown";
            break;
        }
        case LL_iPod_Gen1_Gen2: {
            familyTypeStr = @"iPod Gen1 Gen2";
            break;
        }
        case LL_iPod_Gen3: {
            familyTypeStr = @"iPod Gen3";
            break;
        }
        case LL_iPod_Mini: {
            familyTypeStr = @"iPod Mini";
            break;
        }
        case LL_iPod_Gen4: {
            familyTypeStr = @"iPod Gen4";
            break;
        }
        case LL_iPod_Gen4_2: {
            familyTypeStr = @"iPod Gen4 2";
            break;
        }
        case LL_iPod_Gen5: {
            familyTypeStr = @"iPod Gen5";
            break;
        }
        case LL_iPod_Nano_Gen1: {
            familyTypeStr = @"iPod Nano Gen1";
            break;
        }
        case LL_iPod_Nano_Gen2: {
            familyTypeStr = @"iPod Nano Gen2";
            break;
        }
        case LL_iPod_Classic: {
            familyTypeStr = @"iPod Classic";
            break;
        }
        case LL_iPod_Nano_Gen3: {
            familyTypeStr = @"iPod Nano Gen3";
            break;
        }
        case LL_iPod_Nano_Gen4: {
            familyTypeStr = @"iPod Nano Gen4";
            break;
        }
        case LL_iPod_Nano_Gen5: {
            familyTypeStr = @"iPod Nano Gen5";
            break;
        }
        case LL_iPod_Nano_Gen6: {
            familyTypeStr = @"iPod Nano Gen6";
            break;
        }
        case LL_iPod_Nano_Gen7: {
            familyTypeStr = @"iPod Nano Gen7";
            break;
        }
        case LL_iPod_Shuffle_Gen1: {
            familyTypeStr = @"iPod Shuffle Gen1";
            break;
        }
        case LL_iPod_Shuffle_Gen2: {
            familyTypeStr = @"iPod Shuffle Gen2";
            break;
        }
        case LL_iPod_Shuffle_Gen3: {
            familyTypeStr = @"iPod Shuffle Gen3";
            break;
        }
        case LL_iPod_Shuffle_Gen4: {
            familyTypeStr = @"iPod Shuffle Gen4";
            break;
        }
        case LL_iOS_Device: {
            familyTypeStr = @"iOS_Device";
            break;
        }
        case LL_iPod_Touch_1: {
            familyTypeStr = @"iPod Touch 1";
            break;
        }
        case LL_iPod_Touch_2: {
            familyTypeStr = @"iPod Touch 2";
            break;
        }
        case LL_iPod_Touch_3: {
            familyTypeStr = @"iPod Touch 3";
            break;
        }
        case LL_iPod_Touch_4: {
            familyTypeStr = @"iPod Touch 4";
            break;
        }
        case LL_iPod_Touch_5: {
            familyTypeStr = @"iPod Touch 5";
            break;
        }
        case LL_iPhone: {
            familyTypeStr = @"iPhone";
            break;
        }
        case LL_iPhone_3G: {
            familyTypeStr = @"iPhone 3G";
            break;
        }
        case LL_iPhone_3GS: {
            familyTypeStr = @"iPhone 3GS";
            break;
        }
        case LL_iPhone_4: {
            familyTypeStr = @"iPhone 4";
            break;
        }
        case LL_iPhone_4S: {
            familyTypeStr = @"iPhone 4S";
            break;
        }
        case LL_iPhone_5: {
            familyTypeStr = @"iPhone 5";
            break;
        }
        case LL_iPhone_5S: {
            familyTypeStr = @"iPhone 5S";
            break;
        }
        case LL_iPhone_5C: {
            familyTypeStr = @"iPhone 5C";
            break;
        }
        case LL_iPhone_6:{
            familyTypeStr = @"iPhone 6";
            break;
        }
        case LL_iPhone_6_Plus:{
            familyTypeStr = @"iPhone 6 Plus";
            break;
        }
        case LL_iPhone_6S:{
            familyTypeStr = @"iPhone 6S";
            break;
        }
        case LL_iPhone_6S_Plus:{
            familyTypeStr = @"iPhone 6S Plus";
            break;
        }
        case LL_iPhone_SE:{
            familyTypeStr = @"iPhone SE";
            break;
        }
        case LL_iPhone_7:{
            familyTypeStr = @"iPhone 7";
            break;
        }
        case LL_iPhone_7_Plus:{
            familyTypeStr = @"iPhone 7 Plus";
            break;
        }
        case LL_iPhone_8:{
            familyTypeStr = @"iPhone 8";
            break;
        }
        case LL_iPhone_8_Plus:{
            familyTypeStr = @"iPhone 8 Plus";
            break;
        }
        case LL_iPhone_X:{
            familyTypeStr = @"iPhone X";
            break;
        }
        case LL_iPhone_XR:{
            familyTypeStr = @"iPhone XR";
            break;
        }
        case LL_iPhone_XS:{
            familyTypeStr = @"iPhone XS";
            break;
        }
        case LL_iPhone_XS_Max:{
            familyTypeStr = @"iPhone XS Max";
            break;
        }
        case LL_iPhone_11:
            familyTypeStr = @"iPhone 11";
            break;
        case LL_iPhone_11_Pro:
            familyTypeStr = @"iPhone 11 Pro";
            break;
        case LL_iPhone_11_Pro_Max:
            familyTypeStr = @"iPhone 11 Pro Max";
            break;
        case LL_iPad_1: {
            familyTypeStr = @"iPad 1";
            break;
        }
        case LL_iPad_2: {
            familyTypeStr = @"iPad 2";
            break;
        }
        case LL_The_New_iPad: {
            familyTypeStr = @"The_New_iPad";
            break;
        }
        case LL_iPad_4: {
            familyTypeStr = @"iPad 4";
            break;
        }
        case LL_iPad_Air: {
            familyTypeStr = @"iPad Air";
            break;
        }
        case LL_iPad_Air2: {
            familyTypeStr = @"iPad Air2";
            break;
        }
        case LL_iPad_2017:{
            familyTypeStr = @"iPad 2017";
            break;
        }
        case LL_iPad_2018:{
            familyTypeStr = @"iPad 2018";
            break;
        }
        case LL_iPad_2019:{
            familyTypeStr = @"iPad 2019";
            break;
        }
        case LL_iPad_Air_2019:{
            familyTypeStr = @"iPad Air 2019";
            break;
        }
        case LL_iPad_mini: {
            familyTypeStr = @"iPad mini";
            break;
        }
        case LL_iPad_mini_2: {
            familyTypeStr = @"iPad mini 2";
            break;
        }
        case LL_iPad_mini_3: {
            familyTypeStr = @"iPad mini 3";
            break;
        }
        case LL_iPad_mini_4: {
            familyTypeStr =  @"iPad mini 4";
            break;
        }
        case LL_iPad_mini_2019:{
            familyTypeStr = @"iPad mini 2019";
            break;
        }
        case LL_iPad_Pro_12_9_GEN1:{
            familyTypeStr = @"iPad_Pro_12_9_GEN1";
            break;
        }
        case LL_iPad_Pro_9_7_GEN1:{
            familyTypeStr = @"iPad_Pro_9_7_GEN1";
            break;
        }
        case LL_iPad_Pro_12_9_GEN2:{
            familyTypeStr = @"iPad_Pro_12_9_GEN2";
            break;
        }
        case LL_iPad_Pro_10_5_GEN2:{
            familyTypeStr = @"iPad_Pro_10_5_GEN2";
            break;
        }
        case LL_iPad_Pro_12_9_GEN3:{
            familyTypeStr = @"iPad_Pro_12_9_GEN3";
            break;
        }
        case LL_iPad_Pro_11_GEN3:{
            familyTypeStr = @"iPad_Pro_11_GEN3";
            break;
        }
        default: {
            familyTypeStr = @"Unknown";
            break;
        }
            
    }
    return familyTypeStr;
}


- (void)setProductType:(NSString *)productType
{
    _productType = productType;
    [self setDeviceType:0];
    _productName = [self getDeviceFamilyString];
}

- (void)setDeviceType:(DeviceFamilyEnum)newdeviceType
{
    if ([_productType isEqualToString:@"iPod1,1"]) {
        _deviceType = LL_iPod_Touch_1;
    } else if ([_productType isEqualToString:@"iPod2,1"]) {
        _deviceType = LL_iPod_Touch_2;
    } else if ([_productType isEqualToString:@"iPod3,1"]) {
        _deviceType = LL_iPod_Touch_3;
    } else if ([_productType isEqualToString:@"iPod4,1"]) {
        _deviceType = LL_iPod_Touch_4;
    } else if ([_productType isEqualToString:@"iPod5,1"]) {
        _deviceType = LL_iPod_Touch_5;
    } else if ([_productType isEqualToString:@"iPod7,1"]) {
        _deviceType = LL_iPod_Touch_6;
    } else if ([_productType isEqualToString:@"iPod9,1"]) {
        _deviceType = LL_iPod_Touch_7;
    } else if ([_productType isEqualToString:@"iPhone1,1"]) {
        _deviceType = LL_iPhone;
    } else if ([_productType isEqualToString:@"iPhone1,2"]) {
        _deviceType = LL_iPhone_3G;
    } else if ([_productType isEqualToString:@"iPhone2,1"]) {
        _deviceType = LL_iPhone_3GS;
    } else if ([_productType isEqualToString:@"iPhone3,1"] ||
               [_productType isEqualToString:@"iPhone3,2"] ||
               [_productType isEqualToString:@"iPhone3,3"]) {
        _deviceType = LL_iPhone_4;
    } else if ([_productType isEqualToString:@"iPhone4,1"]) {
        _deviceType = LL_iPhone_4S;
    } else if ([_productType isEqualToString:@"iPhone5,1"] ||
               [_productType isEqualToString:@"iPhone5,2"]) {
        _deviceType = LL_iPhone_5;
    } else if ([_productType isEqualToString:@"iPhone5,3"] ||
               [_productType isEqualToString:@"iPhone5,4"]) {
        _deviceType = LL_iPhone_5C;
    } else if ([_productType isEqualToString:@"iPhone6,1"] ||
               [_productType isEqualToString:@"iPhone6,2"]) {
        _deviceType = LL_iPhone_5S;
    } else if ([_productType isEqualToString:@"iPhone7,2"]) {
        _deviceType = LL_iPhone_6;
    } else if ([_productType isEqualToString:@"iPhone7,1"]) {
        _deviceType = LL_iPhone_6_Plus;
    } else if ([_productType isEqualToString:@"iPhone8,1"]) {
        _deviceType = LL_iPhone_6S;
    } else if ([_productType isEqualToString:@"iPhone8,2"]) {
        _deviceType = LL_iPhone_6S_Plus;
    } else if ([_productType isEqualToString:@"iPhone8,4"]) {
        _deviceType = LL_iPhone_SE;
    }else if ([_productType isEqualToString:@"iPhone9,1"] ||
              [_productType isEqualToString:@"iPhone9,3"]) {
        _deviceType = LL_iPhone_7;
    }else if ([_productType isEqualToString:@"iPhone9,2"] ||
              [_productType isEqualToString:@"iPhone9,4"]) {
        _deviceType = LL_iPhone_7_Plus;
    }else if ([_productType isEqualToString:@"iPhone10,4"] ||
              [_productType isEqualToString:@"iPhone10,1"]) {
        _deviceType = LL_iPhone_8;
    }else if ([_productType isEqualToString:@"iPhone10,2"] ||
              [_productType isEqualToString:@"iPhone10,5"]) {
        _deviceType = LL_iPhone_8_Plus;
    }else if ([_productType isEqualToString:@"iPhone10,3"] ||
              [_productType isEqualToString:@"iPhone10,6"]) {
        _deviceType = LL_iPhone_X;
    }else if ([_productType isEqualToString:@"iPhone11,8"]) {
        _deviceType = LL_iPhone_XR;
    }else if ([_productType isEqualToString:@"iPhone11,2"]) {
        _deviceType = LL_iPhone_XS;
    }else if ([_productType isEqualToString:@"iPhone11,4"] || [_productType isEqualToString:@"iPhone11,6"]) {
        _deviceType = LL_iPhone_XS_Max;
    } else if ([_productType isEqualToString:@"iPhone12,1"]) {
        _deviceType = LL_iPhone_11;
    }else if ([_productType isEqualToString:@"iPhone12,3"]) {
        _deviceType = LL_iPhone_11_Pro;
    }else if ([_productType isEqualToString:@"iPhone12,5"]) {
        _deviceType = LL_iPhone_11_Pro_Max;
    }else if ([_productType isEqualToString:@"iPad1,1"]) {
        _deviceType = LL_iPad_1;
    }else if ([_productType isEqualToString:@"iPad2,1"] ||
              [_productType isEqualToString:@"iPad2,2"] ||
              [_productType isEqualToString:@"iPad2,3"] ||
              [_productType isEqualToString:@"iPad2,4"]) {
        _deviceType = LL_iPad_2;
    } else if ([_productType isEqualToString:@"iPad3,1"] ||
               [_productType isEqualToString:@"iPad3,2"] ||
               [_productType isEqualToString:@"iPad3,3"]) {
        _deviceType = LL_The_New_iPad;
    } else if ([_productType isEqualToString:@"iPad3,4"] ||
               [_productType isEqualToString:@"iPad3,5"] ||
               [_productType isEqualToString:@"iPad3,6"]) {
        _deviceType = LL_iPad_4;
    } else if ([_productType isEqualToString:@"iPad4,1"] ||
               [_productType isEqualToString:@"iPad4,2"] ||
               [_productType isEqualToString:@"iPad4,3"]) {
        _deviceType = LL_iPad_Air;
    } else if ([_productType isEqualToString:@"iPad5,3"] ||
               [_productType isEqualToString:@"iPad5,4"]) {
        _deviceType = LL_iPad_Air2;
    }else if([_productType isEqualToString:@"iPad6,11"] ||
             [_productType isEqualToString:@"iPad6,12"]){
        _deviceType = LL_iPad_2017;
    }else if([_productType isEqualToString:@"iPad7,5"] ||
             [_productType isEqualToString:@"iPad7,6"]){
        _deviceType = LL_iPad_2018;
    }else if([_productType isEqualToString:@"iPad7,11"] ||
             [_productType isEqualToString:@"iPad7,12"]){
        _deviceType = LL_iPad_2019;
    }else if([_productType isEqualToString:@"iPad11,3"] ||
             [_productType isEqualToString:@"iPad11,4"]){
        _deviceType = LL_iPad_Air_2019;
    }else if ([_productType isEqualToString:@"iPad6,7"]||
              [_productType isEqualToString:@"iPad6,8"]) {
        _deviceType = LL_iPad_Pro_12_9_GEN1;
    }else if([_productType isEqualToString:@"iPad6,3"] ||
             [_productType isEqualToString:@"iPad6,4"]){
        _deviceType = LL_iPad_Pro_9_7_GEN1;
    }else if([_productType isEqualToString:@"iPad7,1"] ||
             [_productType isEqualToString:@"iPad7,2"]){
        _deviceType = LL_iPad_Pro_12_9_GEN2;
    }else if([_productType isEqualToString:@"iPad7,3"] ||
             [_productType isEqualToString:@"iPad7,4"]){
        _deviceType = LL_iPad_Pro_10_5_GEN2;
    }else if([_productType isEqualToString:@"iPad8,5"] ||
             [_productType isEqualToString:@"iPad8,6"] ||
             [_productType isEqualToString:@"iPad8,7"] ||
             [_productType isEqualToString:@"iPad8,8"] ){
        _deviceType = LL_iPad_Pro_12_9_GEN3;
    }else if([_productType isEqualToString:@"iPad8,1"] ||
             [_productType isEqualToString:@"iPad8,2"] ||
             [_productType isEqualToString:@"iPad8,3"] ||
             [_productType isEqualToString:@"iPad8,4"]){
        _deviceType = LL_iPad_Pro_11_GEN3;
    }else if ([_productType isEqualToString:@"iPad2,5"] ||
              [_productType isEqualToString:@"iPad2,6"] ||
              [_productType isEqualToString:@"iPad2,7"]) {
        _deviceType = LL_iPad_mini;
    } else if ([_productType isEqualToString:@"iPad4,4"] ||
               [_productType isEqualToString:@"iPad4,5"] ||
               [_productType isEqualToString:@"iPad4,6"]) {
        _deviceType = LL_iPad_mini_2;
    } else if ([_productType isEqualToString:@"iPad4,7"] ||
               [_productType isEqualToString:@"iPad4,8"] ||
               [_productType isEqualToString:@"iPad4,9"]) {
        _deviceType = LL_iPad_mini_3;
    } else if ([_productType isEqualToString:@"iPad5,1"] ||
               [_productType isEqualToString:@"iPad5,2"]) {
        _deviceType = LL_iPad_mini_4;
    }else if([_productType isEqualToString:@"iPad11,1"] ||
             [_productType isEqualToString:@"iPad11,2"]){
        _deviceType = LL_iPad_mini_2019;
    }else {
        //        if ([_hardwareModel.lowercaseString isEqualToString:@"n61ap"]) {
        //            _deviceType = LL_iPhone_6;
        //        } else if ([_hardwareModel.lowercaseString isEqualToString:@"n56ap"]) {
        //            _deviceType = LL_iPhone_6_Plus;
        //        } else {
        _deviceType = LL_iPod_Unknown;
        //        }
    }
}

@end
