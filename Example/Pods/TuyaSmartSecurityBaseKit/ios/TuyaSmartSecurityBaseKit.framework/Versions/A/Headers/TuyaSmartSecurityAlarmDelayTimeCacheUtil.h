//
//  TYAlarmDelayTimeUntil.h
//  TuyaSecuritySDK
//
//  Created by MokZF on 2019/11/18.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityArmedRuleDelayTimeModel.h"

@interface TuyaSmartSecurityAlarmDelayTimeCacheUtil : NSObject

+ (instancetype)sharedInstance;

- (void)setDelayTimeWithType:(ArmModeStatus)modeTypde
                   dataModel:(TuyaSmartSecurityArmedRuleDelayTimeModel *)dataModel;

- (void)updateCacheDelayTime:(NSInteger)time
                        mdoe:(ArmModeStatus)mode
                     isAlarm:(BOOL)isAlarm;

- (TuyaSmartSecurityArmedRuleDelayTimeModel *)getCacheDelayTimeWithMode:(ArmModeStatus)mode;

@end
