//
//  TuyaSmartLogger.h
//  TuyaSmartLogger
//
//  Created by zhukw on 2019/7/16.
//

#import <Foundation/Foundation.h>

@interface TuyaSmartLogger : NSObject

+ (void)startLog;

+ (NSString *)getDebugLogPath;

@end
