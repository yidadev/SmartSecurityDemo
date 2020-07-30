//
//  SecurityHomeViewModelProtocol.h
//  TYSecurityHomeModule
//
//  Created by MokZF on 2020/3/25.
//

#import <Foundation/Foundation.h>
//#import <TYSecurityHomeModule/TYSecurityHomeProtocol.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityQueryStateModel.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityLocaitonStateModel.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityBaseKitDefinition.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SecurityHomeViewModelProtocol <NSObject>

@optional

/// 布撤防倒计时或者报警倒计时时，更新头部banner信息
/// @param delayDes 描述文案
- (void)shouldUpdateBannerWithDelayDes:(nullable NSString *)delayDes;

/// 设备dp变化时刷新banner信息
/// @param infos 文案
- (void)shouldUpdateBannerInfo:(NSArray<NSString *> *)infos;

/// 头视图点击放大、缩小(首页UI变化)
/// @param isScaled 放大、缩小
- (void)headerViewScaled:(BOOL)isScaled;

/// 刷新tableView异常设备列表
- (void)tableViewShouldReloadData:(NSArray *)data;

/// 布撤防时异常设备列表
/// @param deviceIds 设备id
- (void)didReceiveUnusualDevice:(NSArray<NSString *> *)deviceIds;

/// 网关状态变化首页View更新UI
/// @param state 网关状态
- (void)homeViewShouldReLayoutWithGateWayState:(GatewayDeviceState)state;

/// 查询状态超时、切换状态超时
- (void)querySecurityModeTimeOut;

/// 查询到布撤防状态
/// @param currentMode 当前状态
- (void)didReceiveSecurityMode:(ArmModeStatus)currentMode;

///// 查询到锁设备
///// @param dataArray 首页锁数据
//- (void)didReceiveLocks:(NSArray<TYDeviceCALockModel *> *)dataArray;

/// 更新网关状态
/// @param type 操作类型
/// @param success 是否成功
- (void)gatewayStateDidUpdate:(TYHSGatewayStateUpdateType)type success:(BOOL)success error:(NSError *)error;

/// 主页面弹出网关状态弹出
/// @param models 网关model
- (void)homeVCshouldAlterGatewayStateView:(NSArray<TuyaSmartSecurityGatewayStatuModel *> *)models;

/// 家庭报警状态(倒计时)
/// @param model 数据
- (void)didReceiveHomeAlarmStateAndVoiceState:(TuyaSmartSecurityLocaitonStateModel *)model;

/// 网关开始布撤防
- (void)gatewayDeviceBeginSwitchMode;

/// 单个网关最终布撤防回调
/// @param targetMode 模式
/// @param deviceId 设备id
- (void)gatewayDeviceDidEnterMode:(ArmModeStatus)targetMode deviceId:(NSString *)deviceId state:(TYSecurityGatewayDeviceArmResultType)type;


/// 报警状态发送改变
/// @param alarmState 报警状态
- (void)locationAlarmStateChange:(TYSecurityLocationAlarmState)alarmState;

///错误回调
- (void)handlerError:(NSError *)error errorType:(TYSecurityModeErrorType)errorType;

@end

NS_ASSUME_NONNULL_END
