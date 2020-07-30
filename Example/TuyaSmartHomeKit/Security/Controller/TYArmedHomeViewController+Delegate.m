//
//  TYArmedHomeViewController+Delegate.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/28.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYArmedHomeViewController+Delegate.h"
#import "TYIgnoreDeviceListViewController.h"
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import "TYWarningViewController.h"
#import <TYFoundationKit/TYFoundationKit.h>
#import <TYUIKit/TYUIKit.h>
#import "TYSmartHomeManager.h"

@implementation TYArmedHomeViewController (Delegate)

#pragma makr -- TuyaSmartSecurityHomeProtocol

/// 切换布撤防时候倒计时回调
/// @param countDownTime 倒计时时间(只返回最大值和最小值0)
- (void)asynSecurityModeWillSwitchAfterDelay:(NSInteger)countDownTime {
    if (countDownTime == 0) {
        [self releaseTimer];
        self.countDownLabel.text = @" mode countdown: 0";
    }
    
    if (countDownTime > 0) {
        [self timer];
        self.countDownLabelString = @" mode countdown";
        self.countDownCount = countDownTime;
    }
}

/// 切换布撤防回调
/// @param currentMode 当前状态
/// @param deleyTime 倒计时
- (void)securityModeDidSwitch:(ArmModeStatus)currentMode delayTime:(NSInteger)deleyTime {
    [self updateCurrentModelState:currentMode];
    if (deleyTime == 0) {
        [self releaseTimer];
        self.countDownLabel.text = @" mode countdown: 0";
    }
    
    if (deleyTime > 0) {
        [self timer];
        self.countDownCount = deleyTime;
        self.countDownLabelString = @" mode countdown";
    }
}

/// 网关报警倒计时监听
/// @param delayTime 报警倒计时
- (void)securityGatewayWillAlarmAfterDelay:(NSInteger)delayTime {
    if (delayTime == 0) {
        [self releaseTimer];
    }
    
    if (delayTime > 0) {
        [self timer];
        self.countDownCount = delayTime;
        self.countDownLabelString = @" alarm countdown";
    }
}

/// ignore设备
- (void)didReceiveUnusualDevice:(NSArray<NSString *> *)deviceIds {
    if (deviceIds.count == 0) {
        [self.currentHome switchSecurityArmMode:self.tempMode];
        return;
    }
    TYIgnoreDeviceListViewController *ignoreVC = [TYIgnoreDeviceListViewController new];
    ty_weakify(self);
    ignoreVC.ignoreDeviceIds = deviceIds;
    ignoreVC.continueBlock = ^{
        ty_strongify(self);
        [self.currentHome switchSecurityArmMode:self.tempMode];
        [self.navigationController popViewControllerAnimated:YES];
    };
    [self.navigationController pushViewController:ignoreVC animated:YES];
}

/// bypass设备
- (void)didReceiveBypassDevice:(NSArray<NSString *> *)deviceIds {
    NSString *text = @"";
    for (NSString *deviceId in deviceIds) {
        NSArray *allDevices = [TYSmartHomeManager sharedInstance].currentHome.deviceList;
        for (TuyaSmartDeviceModel *deviceModel in allDevices) {
            if ([deviceId isEqualToString:deviceModel.devId]) {
                text = [NSString stringWithFormat:@"\n%@ bypassed",deviceModel.name];
            }
        }
    }
    if (text.length > 0) {
        self.bypassDeviceLabel.text = text;
    }

}

/// 查询异常设备
/// @param deviceModel 异常设备信息
- (void)didReceiveAbnormalDevice:(NSArray<TuyaSmartSecurityErrorDeviceModel *> *)deviceModel {
    
}

/// 网关状态更细(取消报警、撤防并取消报警、静音、开启声音)
/// @param type 操作类型
/// @param success 是否成功
/// @param error 错误信息
- (void)gatewayStateDidUpdate:(TYHSGatewayStateUpdateType)type success:(BOOL)success error:(NSError *)error {

}

/// 弹框有异常的网关列表
/// @param devId 设备id
- (void)shouldAlterGatewayStateView:(NSArray<TuyaSmartSecurityGatewayStatuModel *> *)devId {
    
}

/// 更新家庭状态
/// @param state 状态
- (void)shouldUpdateLocationStatus:(GatewayDeviceState)state {
    
}

/// 发送报警
/// @param model 报警信息
- (void)didReceiveHomeAlarmInfo:(TuyaSmartSecurityLocaitonStateModel *)model {
    if (model.onlineState == TYSecurityLocationLineState_AllGatewayOnline || model.onlineState == TYSecurityLocationLineState_SomeGatewayOffline) {
        self.locationOnlineState.text = @" Locaiton Online State: Online";
        //家庭在线的情况下，查询当前布撤防状态
        [self.currentHome querySecurityArmMode];
        [self.currentHome queryBypssDevices];
    }else {
        self.locationOnlineState.text = @" Locaiton Online State: Offline";
    }
    
    if (model.alarmState == TYSecurityLocationState_Alarm) {
        [self alarmLogic:YES];
    }else {
        [self alarmLogic:NO];
    }
    
    if (model.alarmCountdown > 0) {
        [self releaseTimer];
        [self timer];
        self.countDownCount = model.alarmCountdown;
        self.countDownLabelString = @" alarm countdown";
    }
    self.isAlarming = (model.alarmCountdown > 0);
}

/// 错误回调
/// @param error error
/// @param errorType 错误类型
- (void)handlerError:(NSError *)error errorType:(TYSecurityModeErrorType)errorType {
    [TPProgressUtils showError:error];
}

/// 网关开始布撤防(收到忽略设备后，网关开始布撤防，APP端弹出alter显示每个网关布撤防结果)
- (void)gatewayDeviceBeginSwitchMode {
    
}

/// 单个网关布撤防结果回调
/// @param targetMode 布撤防模式
/// @param deviceId 网关设备id
/// @param state 结果
- (void)gatewayDeviceDidEnterMode:(ArmModeStatus)targetMode
                         deviceId:(NSString *)deviceId
                            state:(TYSecurityGatewayDeviceArmResultType)state {
    TuyaSmartDevice *deviceModel = [TuyaSmartDevice deviceWithDeviceId:deviceId];
    [TPProgressUtils showSuccess:[NSString stringWithFormat:@"%@ operation success",deviceModel.deviceModel.name] toView:self.view];
}

/// 报警状态发送改变
/// @param alarmState 报警状态
- (void)locationAlarmStateChange:(TYSecurityLocationAlarmState)alarmState {
    if (alarmState == TYSecurityLocationState_Alarm) {
        [self alarmLogic:YES];
    }else {
        [self alarmLogic:NO];
    }
}

- (void)alarmLogic:(BOOL)alarm {
    NSMutableArray *subVCS = TY_TopViewController().navigationController.viewControllers.mutableCopy;

    if (alarm) {
        self.isAlarming = YES;
        if ([TY_TopViewController() isKindOfClass:[TYWarningViewController class]]) {
            return;
        }
        BOOL containWarningVC = NO;
        UIViewController *tempVC;
        for (NSInteger i = 0; i < TY_TopViewController().navigationController.viewControllers.count; i++) {
            UIViewController *viewController = TY_TopViewController().navigationController.viewControllers[i];
            if ([viewController isKindOfClass:[TYWarningViewController class]]) {
                containWarningVC = YES;
                tempVC = viewController;
                [subVCS removeObject:viewController];
            }
        }
        
        if (!containWarningVC) {
            TYWarningViewController *warningVC = [[TYWarningViewController alloc] init];
            [TY_TopViewController().navigationController pushViewController:warningVC animated:YES];
        }else {
            TY_TopViewController().navigationController.viewControllers = subVCS.copy;
            [TY_TopViewController().navigationController pushViewController:tempVC animated:YES];
        }
    }else {
        self.isAlarming = NO;
        [self releaseTimer];
        if ([self.navigationController.viewControllers.firstObject isKindOfClass:NSClassFromString(@"TYWarningViewController")]) {
            [self.navigationController popViewControllerAnimated:YES];
            return;
        }
        for (UIViewController *viewController in TY_TopViewController().navigationController.viewControllers) {
            if ([viewController isKindOfClass:[TYWarningViewController class]]) {
                [subVCS removeObject:viewController];
            }
        }
        TY_TopViewController().navigationController.viewControllers = subVCS.copy;
    }
}

#pragma makr --
- (void)updateCurrentModelState:(ArmModeStatus)mode {
    NSString *modeString = @"";
    if (mode == ArmModeStatusLeaving) {
        modeString = @"Leaving";
    }else if (mode == ArmModeStatusStaying) {
        modeString = @"Stay";
    }else if (mode == ArmModeStatusDisarmed) {
        modeString = @"Disarm";
    }
    self.currentMode = mode;
    self.currnetModelLabel.text = [NSString stringWithFormat:@" Current Security Mode is: %@",modeString];
}

@end
