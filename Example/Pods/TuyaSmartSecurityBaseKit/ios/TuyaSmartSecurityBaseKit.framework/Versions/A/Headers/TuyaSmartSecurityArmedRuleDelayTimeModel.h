//
//  TYArmedRuleDelayTimeModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/9.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityBaseKitDefinition.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityArmedRuleDelayTimeModel : NSObject

/// 布撤防模式
@property (nonatomic, assign) ArmModeStatus mode;

/// 布防延迟时间
@property (nonatomic, assign) NSInteger enableDelayTime;

/// 报警延迟时间
@property (nonatomic, assign) NSInteger alarmDelayTime;

@end

NS_ASSUME_NONNULL_END
