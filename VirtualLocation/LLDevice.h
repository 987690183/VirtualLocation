//
//  LLDevice.h
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/24.
//  Copyright © 2019 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


typedef enum DeviceFamily {
    LL_iPod_Unknown = 0,
    LL_iPod_Gen1_Gen2 = 1,
    LL_iPod_Gen3 = 2,
    LL_iPod_Mini = 3,
    LL_iPod_Gen4 = 4,
    LL_iPod_Gen4_2 = 5,
    LL_iPod_Gen5 = 6,
    LL_iPod_Nano_Gen1 = 7,
    LL_iPod_Nano_Gen2 = 9,
    LL_iPod_Classic = 11,
    LL_iPod_Nano_Gen3 = 12,
    LL_iPod_Nano_Gen4 = 15,
    LL_iPod_Nano_Gen5 = 16,
    LL_iPod_Nano_Gen6 = 17,
    LL_iPod_Nano_Gen7 = 18,
    LL_iPod_Shuffle_Gen1 = 128,
    LL_iPod_Shuffle_Gen2 = 130,
    LL_iPod_Shuffle_Gen3 = 132,
    LL_iPod_Shuffle_Gen4 = 133,
    LL_iOS_Device = 1000,
    LL_iPod_Touch_1 = 1001,
    LL_iPod_Touch_2 = 1002,
    LL_iPod_Touch_3 = 1003,
    LL_iPod_Touch_4 = 1004,
    LL_iPod_Touch_5 = 1005,
    LL_iPod_Touch_6 = 1006,
    LL_iPod_Touch_7 = 1007,
    LL_iPhone = 2001,
    LL_iPhone_3G = 2002,
    LL_iPhone_3GS = 2003,
    LL_iPhone_4 = 2004,
    LL_iPhone_4S = 2005,
    LL_iPhone_5 = 2006,
    LL_iPhone_5C = 2007,
    LL_iPhone_5S = 2008,
    LL_iPhone_6 = 2009,
    LL_iPhone_6_Plus = 2010,
    LL_iPhone_6S = 2011,
    LL_iPhone_6S_Plus = 2012,
    LL_iPhone_SE = 2016,
    LL_iPhone_7 = 2017,
    LL_iPhone_7_Plus = 2018,
    LL_iPhone_8 = 2019,
    LL_iPhone_8_Plus = 2020,
    LL_iPhone_X = 2021,
    LL_iPhone_XR = 2022,
    LL_iPhone_XS = 2023,
    LL_iPhone_XS_Max = 2024,
    LL_iPhone_11 = 2025,
    LL_iPhone_11_Pro = 2026,
    LL_iPhone_11_Pro_Max = 2027,
    LL_iPad_1 = 3001,
    LL_iPad_2 = 3002,
    LL_The_New_iPad = 3003,
    LL_iPad_4 = 3004,
    LL_iPad_Air = 3005,
    LL_iPad_Air2 = 3006,
    LL_iPad_2017 = 3007,
    LL_iPad_2018 = 3008,
    LL_iPad_2019 = 3010,
    LL_iPad_Air_2019 = 3009,
    
    LL_iPad_mini = 4001,
    LL_iPad_mini_2 = 4002,
    LL_iPad_mini_3 = 4003,
    LL_iPad_mini_4 = 4004,
    LL_iPad_mini_2019 = 4005,
    
    LL_iPad_Pro_12_9_GEN1 = 4050,
    LL_iPad_Pro_9_7_GEN1 = 4051,
    LL_iPad_Pro_12_9_GEN2 = 4052,
    LL_iPad_Pro_10_5_GEN2 = 4053,
    LL_iPad_Pro_12_9_GEN3 = 4054,
    LL_iPad_Pro_11_GEN3 = 4055,
    
} DeviceFamilyEnum;


@interface LLDevice : NSObject

@property(nonatomic,assign,readonly)DeviceFamilyEnum deviceType;
@property(nonatomic,strong)NSString *deviceName;
@property(nonatomic,strong)NSString *serialNumber;
@property(nonatomic,strong)NSString *udid;
@property(nonatomic,strong,readonly)NSString *productName;
@property(nonatomic,strong)NSString *productType;
@property(nonatomic,strong)NSString *iOSVersion;



@end

NS_ASSUME_NONNULL_END
