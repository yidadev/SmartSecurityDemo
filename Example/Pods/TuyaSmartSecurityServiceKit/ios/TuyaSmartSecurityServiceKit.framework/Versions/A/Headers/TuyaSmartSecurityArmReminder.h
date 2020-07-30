//
//  TuyaSecurityArmReminder.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/12.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartSecurityArmReminderModel.h"

typedef void(^ArmReminderList)(NSArray<TuyaSmartSecurityArmReminderModel *> * _Nullable armReminderList);


NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityArmReminder : NSObject

/// singleInstance
/// 单例
+ (instancetype)sharedInstance;


/// 获取布防提醒的列表
/// Get ArmReminder list
///
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getArmReminderStatus:(long long)homeId
                     success:(ArmReminderList)success
                     failure:(TYFailureError)failure;


/// 修改布防提醒
/// Modify ArmReminder
///
/// @param homeId 家庭Id / Home ID
/// @param type 布防类型
/// @param enable 开/关
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)updateArmReminderStatus:(long long)homeId
                           type:(TYArmReminderType)type
                         enable:(BOOL)enable
                        success:(TYSuccessBOOL)success
                        failure:(TYFailureError)failure;

/// 忽略提醒
/// Ignore ArmReminder
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)ignoreArmReminder:(long long)homeId
                  success:(TYSuccessBOOL)success
                  failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
