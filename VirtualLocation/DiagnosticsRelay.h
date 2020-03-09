//
//  DiagnosticsRelay.h
//  VirtualLocation
//
//  Created by 罗磊 on 2019/12/25.
//  Copyright © 2019 luolei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiagnosticsRelay : NSObject

+ (BOOL)restartDevice:(NSString *)udid;
@end

NS_ASSUME_NONNULL_END
