//
//  Deviceimagemounter.h
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/31.
//  Copyright © 2019 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Deviceimagemounter : NSObject

+(BOOL)mountImage:(NSString *)imagePath signPath:(NSString *)signPath udid:(NSString *)udid;

@end

NS_ASSUME_NONNULL_END
