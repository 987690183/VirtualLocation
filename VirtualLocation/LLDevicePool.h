//
//  LLDevicePool.h
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/24.
//  Copyright © 2019 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLDevice.h"

NS_ASSUME_NONNULL_BEGIN

@protocol LLDeviceConnectionDelegate <NSObject>

@optional
- (void)notifyDeviceConnection:(NSString *)udid;
- (void)notifyDeviceDisConnection:(NSString *)udid;

@end

@interface LLDevicePool : NSObject
{
    NSMutableDictionary *_devicePool;
}

@property(nonatomic,weak)id <LLDeviceConnectionDelegate> delegate;
- (LLDevice *)getDevice:(NSString *)udid;
- (long)deviceCount;

- (void)startLisen;

@end

NS_ASSUME_NONNULL_END
