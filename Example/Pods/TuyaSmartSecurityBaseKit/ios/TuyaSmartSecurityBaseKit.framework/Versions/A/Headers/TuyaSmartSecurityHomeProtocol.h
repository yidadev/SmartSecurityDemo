//
//  TYSecurityHomeProtocol.h
//  TYSecurityHomeModule
//
//  Created by MokZF on 2020/2/20.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityLocaitonStateModel.h"
#import "TuyaSmartSecurityQueryStateModel.h"
#import "TuyaSmartSecurityBaseKitDefinition.h"
#import "TuyaSmartSecurityErrorDeviceModel.h"

typedef NS_ENUM(NSInteger,GatewayDeviceState){
    GatewayDeviceState_noGatewayDevice = 1,//无网关
    GatewayDeviceState_gatewayDeviceOffline,//网关离线
    GatewayDeviceState_gatewayDeviceOnline//网关在线
};

typedef NS_ENUM(NSUInteger, TYSecurityModeErrorType) {
    TYSecurityModeErrorType_QueryModeError,
    TYSecurityModeErrorType_SwitchModeError,
    TYSecurityModeErrorType_QueryIgnoreDeviceError,
    TYSecurityModeErrorType_QueryBypassDeviceError,
    TYSecurityModeErrorType_QueryAbnormalDeviceError,
};

@protocol TuyaSmartSecurityHomeProtocol <NSObject>

/// 切换布撤防时候倒计时回调
/// @param countDownTime 倒计时时间(只返回最大值和最小值0)
- (void)asynSecurityModeWillSwitchAfterDelay:(NSInteger)countDownTime;

/// 切换布撤防回调
/// @param currentMode 当前状态
/// @param deleyTime 倒计时
- (void)securityModeDidSwitch:(ArmModeStatus)currentMode delayTime:(NSInteger)deleyTime;

/// 网关报警倒计时监听
/// @param delayTime 报警倒计时
- (void)securityGatewayWillAlarmAfterDelay:(NSInteger)delayTime;

/// ignore设备
- (void)didReceiveUnusualDevice:(NSArray<NSString *> *)deviceIds;

/// bypass设备
- (void)didReceiveBypassDevice:(NSArray<NSString *> *)deviceIds;

/// 查询异常设备
/// @param deviceModel 异常设备信息
- (void)didReceiveAbnormalDevice:(NSArray<TuyaSmartSecurityErrorDeviceModel *> *)deviceModel;

/// 网关状态更细(取消报警、撤防并取消报警、静音、开启声音)
/// @param type 操作类型
/// @param success 是否成功
/// @param error 错误信息
- (void)gatewayStateDidUpdate:(TYHSGatewayStateUpdateType)type success:(BOOL)success error:(NSError *)error;

/// 更新家庭状态
/// @param state 状态
- (void)shouldUpdateLocationStatus:(GatewayDeviceState)state;

/// 发送报警
/// @param model 报警信息
- (void)didReceiveHomeAlarmInfo:(TuyaSmartSecurityLocaitonStateModel *)model;

/// 错误回调
/// @param error error
/// @param errorType 错误类型
- (void)handlerError:(NSError *)error errorType:(TYSecurityModeErrorType)errorType;

/// 单个网关布撤防结果回调
/// @param targetMode 布撤防模式
/// @param deviceId 网关设备id
/// @param state 结果
- (void)gatewayDeviceDidEnterMode:(ArmModeStatus)targetMode
                         deviceId:(NSString *)deviceId
                            state:(TYSecurityGatewayDeviceArmResultType)state;

/// 报警状态发送改变
/// @param alarmState 报警状态
- (void)locationAlarmStateChange:(TYSecurityLocationAlarmState)alarmState;
@end

