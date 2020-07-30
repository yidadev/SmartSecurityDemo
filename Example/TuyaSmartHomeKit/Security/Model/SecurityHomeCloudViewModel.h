//
//  SecurityHomeCloudViewModel.h
//  TYSecurityHomeModule
//
//  Created by MokZF on 2020/4/9.
//

#import <Foundation/Foundation.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityHomeProtocol.h>
#import "SecurityHomeViewModelProtocol.h"
//#import "TuyaSmartSecurityPreventionLogicProtocol.h"
//#import "TuyaSmartSecuritySwitchModeManager.h"
#import <TuyaSmartSecurityBaseKit/TuyaSmartHome+TuyaSmartSecurity.h>

@class TYKAPopItemDataModel;


NS_ASSUME_NONNULL_BEGIN

@interface SecurityHomeCloudViewModel : NSObject<TuyaSmartSecurityHomeProtocol>

@property (nonatomic, strong) TuyaSmartHome *currentHome;
/// 初始化方法
/// @param delegate 代理
- (instancetype _Nonnull)initViewModel:(TuyaSmartHome *)currentHome
                              delegate:(_Nonnull id<SecurityHomeViewModelProtocol>)delegate;

//- (instancetype _Nonnull)initViewModelWithDelete:(_Nonnull id<SecurityHomeViewModelProtocol>)delegate;

/// 禁止使用init方法直接初始化
- (instancetype _Nullable)init NS_UNAVAILABLE;

/// 绑定业务头视图和业务逻辑
/// @param view 签署TYHSHeaderViewProtocol代理的首页headerView
//- (void)bindView:(id<TuyaSmartSecurityPreventionLogicProtocol>)view;

/// 查询初始状态
- (void)queryCurrentArmModeStatus;

/// 获取当前状态
- (ArmModeStatus)currentMode;

/// 更新banner信息
- (void)queryAbnormalDevicesForBanner;

/// 展示空的头视图(三个灰色的按钮)
- (void)showEmptyHeaderView;

/// 清除数据数据
- (void)clearData;

/// 判断家庭是否已经报警
//- (BOOL)locationAlarmed;

/// 发起sos报警
- (void)startSOSAlarm:(TYHSGatewaySOSType)sosType;

/// 获取离线设备
/// @param ignoreDevices 忽略设备(可不穿)
- (void)queryOfflineDevicesWithIgnoreDevice:(NSArray<TYKAPopItemDataModel *> *)ignoreDevices;

/// 获取锁列表
- (void)getCurrentHomeLocksList;

/// 点击布撤防时，若有忽略设备，则跳转到忽略设备页面，在忽略设备页面点击继续布撤防时，调用该方法
/// @param step 布撤防步骤
//- (void)ignoreDeviceVCSwitchSecurityModeStep:(TYHSSwitchModeStep)step;

/// 查询忽略设备
/// @param mode 当前模式
/// @param handler 回调
- (void)queryIgnoreDeviceWithMode:(ArmModeStatus)mode
                      fromGateway:(TYSecurityGatewayIgnoreDevicesHandler)handler;

/// 更新网关状态
/// @param type 更新类型
- (void)gatewayStateDidUpdate:(TYHSGatewayStateUpdateType)type;

- (ArmModeStatus)getTempMode;

/// 更新报警倒计时动画
- (void)updateAnimationWhenAppActive;


/// 切换家庭时重置报警标记
- (void)resetAlarmingFlag;

/// 获取家庭报警状态(倒计时)
- (void)getHomeAlarmState;

- (void)ignoreVCContinueArm:(ArmModeStatus)targetModel;

@end

NS_ASSUME_NONNULL_END
