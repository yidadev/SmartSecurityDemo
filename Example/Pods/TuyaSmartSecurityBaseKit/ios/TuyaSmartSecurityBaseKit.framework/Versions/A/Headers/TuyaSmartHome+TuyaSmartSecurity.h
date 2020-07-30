//
//  TuyaSmartHome+TuyaSmartSecurity.h
//  TuyaSmartSecurityBaseKit
//
//  Created by MokZF on 2020/7/6.
//

#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import "TuyaSmartSecurityHomeProtocol.h"
#import "TuyaSmartSecurityAlarmMessageModel.h"
#import "TuyaSmartSecurityAlarmOperationModel.h"
#import "TuyaSmartSecurityLocaitonStateModel.h"
#import "TuyaSmartSecurityEmergencyListModel.h"
#import "TuyaSmartSecurityGatewayAlarmMessageModel.h"
#import "TuyaSmartSecurityBaseKitDefinition.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, TYSecurityLocationMonitorState) {
    TYSecurityLocationMonitorState_NotSet,
    TYSecurityLocationMonitorState_SelfMonitoring,
    TYSecurityLocationMonitorState_ProMonitoring
};

//家庭mc注册状态
//Home MC registration status
typedef void(^TYSecurityLocationMonitorStateHandler)(TYSecurityLocationMonitorState state);
//当前报警消息列表
//List of current alarm messages
typedef void(^TYSecurityLocationAlarmMessageHandler)(NSArray<TuyaSmartSecurityGatewayAlarmMessageModel *> *alarmMessageArray);
//报警操作文案获取
//Get alarm operation copy
typedef void(^TYSecurityLocationAlarmOperationHandler)(NSArray<TuyaSmartSecurityAlarmOperationModel *> *operationArray);
//报警声音状态获取回调
//Get alarm sound status callback
typedef void(^TYSecurityLocatinAlarmVoiceHandler)(TuyaSmartSecurityLocaitonStateModel *_Nullable model);
//紧急联系人回调
//Emergency contact callback
typedef void(^TYSecurityLocationAlarmEmergencyHandler)(NSArray<TuyaSmartSecurityEmergencyListModel *> * _Nullable emergencyArray);

typedef void (^TYSecurityLocationAlarmCountDownHandler)(NSTimeInterval timeInterval, NSString * _Nullable alarmId);

typedef void(^TYSecurityErrorHandler)(NSError * _Nullable error);

typedef void(^TYSecurityGatewayIgnoreDevicesHandler)(NSArray<NSString *> * _Nullable ignoreDevicesArray);

@class TuyaSmartSecurityProperty;

@interface TuyaSmartHome (TuyaSmartSecurity)


/// 安防布撤防代理
@property (nonatomic, weak) id<TuyaSmartSecurityHomeProtocol> securityDelegate;

/// 注册网关服务(家庭网关设备发生变化时要重新注册)
/// @param nDevices 网关id集合
- (void)registerWithGatewayIds:(NSArray<NSString *> *)nDevices;

/// 切换布撤防模式
/// @param mode 对应模式
- (void)switchSecurityArmMode:(ArmModeStatus)mode;

/// 查询当前布撤防状态
- (void)querySecurityArmMode;

/// 开启SOS报警
/// @param type SOS报警类型
/// @param success 成功回调
/// @param failure  错误回调
- (void)startSOSAlarm:(TYHSGatewaySOSType)type
              success:(nullable void(^)(BOOL success))success
              failure:(nullable void(^)(NSError *error))failure;

/// 布撤防时查询bypass设备
- (void)queryBypssDevices;

/// 查询异常设备
- (void)queryAbnormalDevices;

/// bypass页面查询忽略设备(从网关查询)
/// @param mode 当前布撤防模式
/// @param handler 回调
- (void)queryIgnoreDevicesFromGateway:(ArmModeStatus)mode
                      completeHandler:(nullable TYSecurityGatewayIgnoreDevicesHandler)handler;
 
/// 更新网关状态
/// @param operationType 操作类型
- (void)updateGatewayState:(TYHSGatewayStateUpdateType)operationType;

/// 获取家庭安防状态(包含报警倒计时信息、是否报警、是否离线)
- (void)getHomeSecurityState;

/// 判断家庭是否离线
- (BOOL)isLocationOffline;

/// 获取家庭网关白名单设备
/// @param successHandler 成功回调
/// @param failureHandler 失败回调
- (void)getGateWayDevice:(void(^)(NSArray<NSString *> *dataArray))successHandler
                 failure:(void(^)(NSError *error))failureHandler;

/**
 设置网关布撤防语音密码密码
 @param type 维度(家庭、个人)
 @param encryptionPassWord 加密后的密码
 @param success 成功回调
 @param failure 失败回调
 */
- (void)setGatewayVoicePassword:(TYSecurityGatewayVoicePassCodeType)type
             encryptionPassWord:(NSString *)encryptionPassWord
                        success:(nullable void(^)(BOOL success))success
                        failure:(nullable void(^)(NSError *error))failure;

/// 校验家庭是否设置过安防网关语音密码
/// @param type 维度(家庭、个人)
/// @param success 成功回调
/// @param failure 失败回调
- (void)getGatewayVoicePasswordState:(TYSecurityGatewayVoicePassCodeType)type
                             success:(nullable void(^)(BOOL success))success
                             failure:(nullable void(^)(NSError *error))failure;

//***********************************************ALARM***************************************************************//
//************************************************ALARM**************************************************************//
//
/// 获取所有告警消息
/// Get all alarming messages
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getAlarmMessageList:(TYSecurityLocationAlarmMessageHandler)success
                    failure:(void(^)(NSError *error))failure;

/// 获取家庭监控中心注册类型
/// Gets the location monitoring center registration type
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getHomeMonitorState:(TYSecurityLocationMonitorStateHandler)success
                    failure:(void(^)(NSError *error))failure;

/// 校验家庭服务中是否包含MC的服务
/// Verify that the home service contains the services of the MC
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)checkLocationServiceContainMC:(void(^)(BOOL success))success
                              failure:(void(^)(NSError *error))failure;

/// 呼叫紧急联系人上报(用户拨打紧急联系人号码时，上报标记)
/// Call the emergency contact to report (when the user dials the emergency contact number, report marks)
/// @param phone 电话号码 / phone number
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)makeCallEmergencyPhoneMark:(NSString *)phone
                           success:(void(^)(BOOL success))success
                           failure:(void(^)(NSError *error))failure;

/// 获取报警操作文案
/// @param success 成功回调
/// @param failure 失败回调
- (void)getAlarmOperationTitle:(TYSecurityLocationAlarmOperationHandler)success
                       failure:(void(^)(NSError *error))failure;

/// 报警紧急联系人列表
/// Alarm emergency contact list
/// /// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getAlarmEmergencyConnect:(TYSecurityLocationAlarmEmergencyHandler)success
                         failure:(void(^)(NSError *error))failure;

/// 获取报警自动发送至MC倒计时
/// Get alarm automatically sent to MC countdown
/// @param alarmId 报警消息id / Alarming message id
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getAlarmAutoSendMCCountDownTime:(NSString *)alarmId
                                success:(TYSecurityLocationAlarmCountDownHandler)success
                                failure:(void(^)(NSError *error))failure;

/// 上报报警至监控中心
/// Report to the police center
/// @param alarmIdsJsonString 所有报警消息的Id / All alarming message id
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)sendAlarmToMonitorCenter:(NSString *)alarmIdsJsonString
                         success:(void(^)(BOOL success))success
                         failure:(void(^)(NSError *error))failure;

/// 报警页面操作事件(声音开关、取消报警、撤防并取消报警)
/// Alarm page operation event (sound switch, cancel alarm, disarm and cancel alarm)
/// @param operationType 操作类型 / Operation Type
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)updateLocationAlarmStatus:(TYHSGatewayStateUpdateType)operationType
                          success:(void(^)(BOOL success))success
                          failure:(void(^)(NSError *error))failure;

/// 获取报警页面声音状态
/// Gets the sound status of the alarm page
/// @param success 成功回调 / Success Callback
/// @param failure 失败回调 / Failure Callback
- (void)getLocationAlarmVoiceState:(TYSecurityLocatinAlarmVoiceHandler)success
                           failure:(void(^)(NSError *error))failure;




@end

NS_ASSUME_NONNULL_END
