//
//  LLSimulatelocation.h
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/9.
//  Copyright © 2019 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LLSimulatelocation : NSObject

+ (BOOL)simulateLocation:(NSString *)lat lng:(NSString *)lng udid:(NSString *)udid;
+ (BOOL)restoreLocation:(NSString *)udid;
@end

NS_ASSUME_NONNULL_END
