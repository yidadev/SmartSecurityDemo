//
//  TYArmedRuleSetting.h
//  BlocksKit
//
//  Created by Wei Zhang on 2020/5/9.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartBaseKit/TuyaSmartBaseKit.h>
#import <TuyaSmartUtil/TuyaSmartUtil.h>
#import "TuyaSmartSecurityBaseKitDefinition.h"

@class TuyaSmartSecurityArmedRuleDeviceModel,TuyaSmartSecurityArmedRuleDelayTimeModel;

typedef void (^GetArmedRuleDeviceList)(NSArray<TuyaSmartSecurityArmedRuleDeviceModel *> * _Nullable nDeviceList);

typedef void (^GetArmedRuleDelayDataList)(NSArray<TuyaSmartSecurityArmedRuleDelayTimeModel *> * _Nullable delayTimeList);

typedef void (^GetArmedRuleDelayData)(TuyaSmartSecurityArmedRuleDelayTimeModel * _Nullable delayTime);


NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityArmedRuleSetting : NSObject

/// singleInstance
/// 单例
+ (instancetype)sharedInstance;

/// 获取指定布防模式下的设备
/// Gets the device in the specified deployment mode
///
/// @param modeStatus 布防模式（在家布防，离家布防）/ arm mode(stay, away)
/// @param homeId 家庭id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getDeviceListWithMode:(ArmModeStatus)modeStatus
                       homeId:(long long)homeId
                      success:(GetArmedRuleDeviceList)success
                      failure:(TYFailureError)failure;



/// 保存指定模式下的联动设备
/// Saves the device in specified mode
///
/// @param modeStatus 布防模式（在家布防，离家布防）/ arm mode(stay, away)
/// @param homeId 家庭id / Home ID
/// @param nDeviceRules 设备规则 {"gatewayId":gatewayId, "deviceIds":["deviceId1","deviceId2"]}
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)saveDeviceListWithMode:(ArmModeStatus)modeStatus
                        homeId:(long long)homeId
                deviceRuleList:(NSArray *)nDeviceRules
                       success:(TYSuccessID)success
                       failure:(TYFailureError)failure;


/// 获取所有模式的延迟规则，目前只有2中布防模式（在家布防，离家布防）
/// Get the delay rule for all modes, currently there are only 2 modes (stay, away)
///
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getAllModeDelayRuleWithHomeId:(long long)homeId
                              success:(GetArmedRuleDelayDataList)success
                              failure:(TYFailureError)failure;


/// 获取指定模式的延迟规则
/// Gets the delay rule for the specified schema
///
/// @param modeStatus 布防模式（在家布防，离家布防）/ arm mode(stay, away)
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getDelayTimeWithMode:(ArmModeStatus)modeStatus
                      homeId:(long long)homeId
                     success:(GetArmedRuleDelayData)success
                     failure:(TYFailureError)failure;


/// 获保存指定模式的延迟规则
/// Holds a delay rule for the specified schema
///
/// @param delayTimeModel 延迟模型 / delaytimeModel
/// @param homeId 家庭Id / Home ID
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)saveDelayTimeWithDelayRule:(TuyaSmartSecurityArmedRuleDelayTimeModel *)delayTimeModel
                            homeId:(long long)homeId
                           success:(TYSuccessBOOL)success
                           failure:(TYFailureError)failure;

@end

NS_ASSUME_NONNULL_END
