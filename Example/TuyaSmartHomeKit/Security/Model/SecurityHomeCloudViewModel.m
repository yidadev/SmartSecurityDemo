//
//  SecurityHomeCloudViewModel.m
//  TYSecurityHomeModule
//
//  Created by MokZF on 2020/4/9.
//

#import "SecurityHomeCloudViewModel.h"
#import <TYUIKit/TYUIKit.h>
#import <TYFoundationKit/TYFoundationKit.h>
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityBaseKit.h>
#import <YYModel/YYModel.h>

@interface SecurityHomeCloudViewModel()
@property (nonatomic, weak) id<SecurityHomeViewModelProtocol> viewModelDelegate;
/// 正在进行报警倒计时
@property (nonatomic, assign) BOOL alarmCountDown;
/// 当前模式
@property (nonatomic, assign) ArmModeStatus currentMode;

//切换布撤防时，若有忽略设备，则需要跳转到忽略设页面，在忽略设备页面点击继续切换时，需要记录当前用户点击的布撤防模式
@property (nonatomic, assign) __block ArmModeStatus tempArmMode;

@property (nonatomic, assign) __block BOOL isLocalSwitchSecurityMode;

@property (nonatomic, copy) TYSecurityGatewayIgnoreDevicesHandler ignoreVCHandler;

@end


@implementation SecurityHomeCloudViewModel

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype _Nonnull)initViewModel:(TuyaSmartHome *)currentHome
                              delegate:(_Nonnull id<SecurityHomeViewModelProtocol>)delegate {
        self = [super init];
        if (self) {
            _viewModelDelegate = delegate;
            _currentHome = currentHome;
            _currentHome.securityDelegate = self;
            //网关设备更新，重新注册监听
            [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(registerGatewayService)
                name:@"SecurityNotiZigbeeGatewayAdd"
              object:nil];

            //切换房间
            [[NSNotificationCenter defaultCenter] addObserver:self
            selector:@selector(registerGatewayService)
                name:@"kSecurityNotiSyncDeviceInfoFromRemoteRequest"
              object:nil];

        }
        return self;
}
//- (instancetype _Nonnull )initViewModelWithDelete:(_Nonnull id<SecurityHomeViewModelProtocol>)delegate {
//    self = [super init];
//    if (self) {
//        _viewModelDelegate = delegate;
//        [[TuyaSmartSecuritySwitchModeManager sharedInstance] initWithHomeId:[self getHomeId] andDelegate:self];
//        //网关设备更新，重新注册监听
//        [[NSNotificationCenter defaultCenter] addObserver:self
//        selector:@selector(registerGatewayService)
//            name:kSecurityNotiZigbeeGatewayAdd
//          object:nil];
//
//        [[NSNotificationCenter defaultCenter] addObserver:self
//        selector:@selector(registerGatewayService)
//            name:kSecurityNotiZigbeeGatewayAdd
//          object:nil];
//
//        //切换房间
//        [[NSNotificationCenter defaultCenter] addObserver:self
//        selector:@selector(registerGatewayService)
//            name:kSecurityNotiSyncDeviceInfoFromRemoteRequest
//          object:nil];
//
//    }
//    return self;
//}

#pragma mark -notification methods
- (void)registerGatewayService {
//    [self.currentHome registerWithGatewayIds:[TYSecurityDataCenterUtil sharedInstance].gatewayDeviceWhiteList];
}

/// 当前家庭是否离线 (家庭下所有网关设备离线时代表该家庭离线)
- (BOOL)isLocationsAllGatewayDeviceOffline {
    return [self.currentHome isLocationOffline];
}


//- (void)bindView:(id<TuyaSmartSecurityPreventionLogicProtocol>)view {
////    self.headerViewDelegate = view;
//}

- (void)queryCurrentArmModeStatus {
    //无网关(当前家庭下没有安防认证的可用网关)
    [self.currentHome getGateWayDevice:^(NSArray<NSString *> * _Nonnull dataArray) {
        if (dataArray.count == 0) {
            if ([self.viewModelDelegate respondsToSelector:@selector(homeViewShouldReLayoutWithGateWayState:)]) {
                [self.viewModelDelegate homeViewShouldReLayoutWithGateWayState:GatewayDeviceState_noGatewayDevice];
            }
            return;
        }
        
        //所有网关都离线，则改家庭显示离线
        if ([self isLocationsAllGatewayDeviceOffline]) {
            if ([self.viewModelDelegate respondsToSelector:@selector(homeViewShouldReLayoutWithGateWayState:)]) {
                [self.viewModelDelegate homeViewShouldReLayoutWithGateWayState:GatewayDeviceState_gatewayDeviceOffline];
                return;
            }
        }
        
        if (self.alarmCountDown) {
            return;
        }
        [self.currentHome querySecurityArmMode];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//获取abnormal设备
- (void)queryAbnormalDevicesForBanner {
    ty_weakify(self);
    //SecurityTODO
//    [[TYSecurityDataCenterUtil sharedInstance] queryAbnormalDeviceWith:^(NSArray<NSString *> * _Nonnull deviceDescList) {
//        ty_strongify(self);
//        if ([self.viewModelDelegate respondsToSelector:@selector(shouldUpdateBannerInfo:)]) {
//            [self.viewModelDelegate shouldUpdateBannerInfo:deviceDescList];
//        }
//    }];
}

//更新异常设备
- (void)queryAlreadyBypassDevices {
    //拉取byPass设备
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] queryLocationBypssDevicesWithHomeId:[self getHomeId]];
    [self.currentHome queryBypssDevices];
}

- (void)resetAlarmingFlag {
    self.alarmCountDown = NO;
}

- (void)queryIgnoreDeviceWithMode:(ArmModeStatus)mode
                      fromGateway:(TYSecurityGatewayIgnoreDevicesHandler)handler {
    self.ignoreVCHandler = handler;
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] queryIgnoreDeviceFromGateway:mode completeHandler:handler];
    [self.currentHome queryIgnoreDevicesFromGateway:mode completeHandler:handler];
}

//获取离线设备
- (void)queryOfflineDevicesWithIgnoreDevice:(NSArray<TYKAPopItemDataModel *> *)ignoreDevices {
    ty_weakify(self);

    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    __block NSError *serviceError;
    //获取error device
    NSMutableArray *abnormalDeviceArray = [[NSMutableArray alloc] init];
//    [self.deviceService getAbnormalDeviceWith:[self getHomeId] success:^(NSArray<TYAbnormalDeviceModel *> * _Nullable anormalDeviceList) {
//
//        for (NSInteger i = 0; i < anormalDeviceList.count; i++) {
//            TYAbnormalDeviceModel *abnormalModel = anormalDeviceList[i];
//            TuyaSmartDeviceModel *deviceModel = [[TYSecurityDataCenterUtil sharedInstance] queryDeviceWithId:abnormalModel.devId];
//            TYKAPopItemDataModel *nameModel = [TYKAPopItemDataModel new];
//            nameModel.titleString = deviceModel.name;
//            nameModel.iconUrl = deviceModel.iconUrl;
//            nameModel.deviceId = deviceModel.devId;
//            nameModel.subTitleString = abnormalModel.info;
//            nameModel.isOfflineDevice = NO;
//            [abnormalDeviceArray addObject:nameModel];
//        }
//        dispatch_group_leave(group);
//    } failure:^(NSError *error) {
//        serviceError = error;
//        dispatch_group_leave(group);
//    }];
    
    //获取offline device
    NSMutableArray *offlineDeviceArray = [[NSMutableArray alloc] init];
    if ([self isLocationsAllGatewayDeviceOffline]) {
        self.currentMode = ArmModeStatusDisarmed;
    }
    
    dispatch_group_enter(group);
    //SecurityTODO
//    [[TYSecurityDataCenterUtil sharedInstance] queryOfflineDevicesWithMode:self.currentMode success:^(NSArray<TuyaSmartDeviceModel *> * _Nullable offlineDevices) {
//        for (NSInteger i = 0; i < offlineDevices.count; i++) {
//            TuyaSmartDeviceModel *devieceModel = offlineDevices[i];
//            TYKAPopItemDataModel *nameModel = [TYKAPopItemDataModel new];
//            nameModel.titleString = devieceModel.name;
//            nameModel.iconUrl = devieceModel.iconUrl;
//            nameModel.isOfflineDevice = YES;
//            nameModel.deviceId = devieceModel.devId;
//            [offlineDeviceArray addObject:nameModel];
//        }
//        dispatch_group_leave(group);
//
//    } failure:^(NSError *error) {
//        serviceError = error;
//        dispatch_group_leave(group);
//    }];
        
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        ty_strongify(self);
        //SecurityTODO
//        NSMutableArray *array = [TYSecurityAlarmUntil deleteRepetitionDataWithBypassDevice:ignoreDevices
//                                                                            offlineDevice:offlineDeviceArray
//                                                                              errorDevice:abnormalDeviceArray];
//        if ([self.headerViewDelegate respondsToSelector:@selector(updateDeviceCount:)]) {
//            [self.headerViewDelegate updateDeviceCount:[NSString stringWithFormat:@"%ld",array.count]];
//        }
//        if ([self.viewModelDelegate respondsToSelector:@selector(tableViewShouldReloadData:)]) {
//            [self.viewModelDelegate tableViewShouldReloadData:array];
//        }
    });
    
}
- (long long)getHomeId {
    return self.currentHome.homeModel.homeId;
}

- (void)showEmptyHeaderView {
//    if ([self.headerViewDelegate respondsToSelector:@selector(initRefreshPreventViewWithSecurityMode:)]) {
//        [self.headerViewDelegate initRefreshPreventViewWithSecurityMode:[TYStatusPreventViewHelper emptyModeLogic]];
//    }
}

- (ArmModeStatus)currentMode {
    return _currentMode;
}

- (ArmModeStatus)getTempMode {
    return _tempArmMode;
}

/// 移除headerView进度条、禁止倒计时回调
- (void)clearData {
    
}

- (void)startSOSAlarm:(TYHSGatewaySOSType)sosType {
    [self.currentHome startSOSAlarm:sosType success:^(BOOL success) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] startSOSAlarmWithHomeId:[self getHomeId] sosType:sosType success:^(BOOL success) {
//
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
}

- (void)gatewayStateDidUpdate:(TYHSGatewayStateUpdateType)type {
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] updateGatewayStateWithHomeId:[self getHomeId] operationType:type];
    [self.currentHome updateGatewayState:type];
}

- (void)updateAnimationWhenAppActive {
    
}

- (void)getHomeAlarmState {
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] getHomeAlarmStateWithHomeId:[self getHomeId]];
    [self.currentHome getHomeSecurityState];
}

- (void)showNoGatewayAlter {
//    TYAlertView *alertView = [[TYAlertView
//                               alloc]
//                              initSimpleAlertWithTitle:@""
//                              message:NSLocalizedString(@"hs_select_one_gateway", @"")
//                              style:TYAlertViewStyleAlert];
//
//    TYAlertAction *cancelAction = [TYAlertAction actionWithTitle:NSLocalizedString(@"config_wifi_not_find_well", @"") color:[UIColor blackColor] font:[UIFont systemFontOfSize:16] alertAciton:^{
//
//    }];
//    cancelAction.isCancel = YES;
//    [alertView addAlertAction:cancelAction];
//    [alertView show];
}

- (void)ignoreVCContinueArm:(ArmModeStatus)targetModel {
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] switchSecurityArmModeWithHomeId:[self getHomeId] mode:targetModel];;
    [self.currentHome switchSecurityArmMode:targetModel];
}

- (void)locationAlarmStateChange:(TYSecurityLocationAlarmState)alarmState {

}

#pragma mark SecurityHomeHeaderProtocol
/// 点击布撤防按钮
/// @param targetMode 对应布撤防
- (void)switchSecurityMode:(ArmModeStatus)targetMode {
    //报警倒计时中只允许撤防
    if (self.alarmCountDown && targetMode != ArmModeStatusDisarmed) {
        return;
    }
    
    if ([self isLocationsAllGatewayDeviceOffline]) {
        //家庭离线状态，这里强制将首页头视图置为灰色不可点击状态
//        [self.headerViewDelegate initRefreshPreventViewWithSecurityMode:[TYStatusPreventViewHelper secUIEmptyDataModel]];
        return;
    }
    
    if (targetMode == [self currentMode]) {
        return;
    }
    
    //注册网关设备(这里补偿注册一次)
//    [[TuyaSmartSecuritySwitchModeManager sharedInstance] registerGatewayService:[TYSecurityDataCenterUtil sharedInstance].gatewayDeviceWhiteList];
//    [self.currentHome registerWithGatewayIds:[TYSecurityDataCenterUtil sharedInstance].gatewayDeviceWhiteList];
    
//    [TYProgressHUD showHUDAddedTo:TY_TopViewController().view];
    self.tempArmMode = targetMode;
    self.isLocalSwitchSecurityMode = YES;
    
    if (targetMode == ArmModeStatusDisarmed) {
        if ([self.viewModelDelegate respondsToSelector:@selector(gatewayDeviceBeginSwitchMode)]) {
            [self.viewModelDelegate gatewayDeviceBeginSwitchMode];
        }
//        [[TuyaSmartSecuritySwitchModeManager sharedInstance] switchSecurityArmModeWithHomeId:[self getHomeId] mode:ArmModeStatusDisarmed];
        [self.currentHome switchSecurityArmMode:ArmModeStatusDisarmed];
    }else {
        
        NSMutableDictionary *bodyDictionary = [[NSMutableDictionary alloc] init];
        [bodyDictionary tysdk_safeSetObject:@(targetMode) forKey:@"mode"];
        NSMutableDictionary *sessionDictionary = [[NSMutableDictionary alloc] init];
        [sessionDictionary tysdk_safeSetObject:[NSNumber numberWithLongLong:[self getHomeId]] forKey:@"gid"];

        
        TuyaSmartRequest *request = [[TuyaSmartRequest alloc] init];
        [request requestWithApiName:@"tuya.m.security.rule.device.get" postData:bodyDictionary getData:sessionDictionary version:@"3.0" success:^(id result) {
             NSArray<TuyaSmartSecurityArmedRuleDeviceModel *> *nDeviceList = [NSArray yy_modelArrayWithClass:[TuyaSmartSecurityArmedRuleDeviceModel class] json:result];
//            [TYStatusPreventViewHelper cacheRuleDevice:nDeviceList];
            BOOL hasGatewayDevie = NO;
            for (TuyaSmartSecurityArmedRuleDeviceModel *model in nDeviceList) {
                if (!model.sub && model.selected) {
                    hasGatewayDevie = YES;
                    break;
                }
            }
            if (hasGatewayDevie) {
                self.tempArmMode = targetMode;
                [self.currentHome queryIgnoreDevicesFromGateway:targetMode completeHandler:nil];
            }else {
//                [TYProgressHUD hideAllHUDFor:TY_TopViewController().view];
                [self showNoGatewayAlter];
            }

        } failure:^(NSError *error) {
            
        }];
//        [self.modeSettingService getDeviceListByMode:targetMode withHomeId:[self getHomeId] success:^(NSArray<TuyaSmartSecurityArmedRuleDeviceModel *> *nDeviceList) {
//            [TYStatusPreventViewHelper cacheRuleDevice:nDeviceList];
//            BOOL hasGatewayDevie = NO;
//            for (TuyaSmartSecurityArmedRuleDeviceModel *model in nDeviceList) {
//                if (!model.sub && model.selected) {
//                    hasGatewayDevie = YES;
//                    break;
//                }
//            }
//            if (hasGatewayDevie) {
//                self.tempArmMode = targetMode;
////                [[TuyaSmartSecuritySwitchModeManager sharedInstance] queryIgnoreDeviceFromGateway:targetMode completeHandler:nil];
//                [self.currentHome queryIgnoreDevicesFromGateway:targetMode completeHandler:nil];
//            }else {
//                [TYProgressHUD hideAllHUDFor:TY_TopViewController().view];
//                [self showNoGatewayAlter];
//            }
//
//        } failure:^(NSError *error) {
//            
//        }];
    }
}

/// itemView倒计时时调用方法，每秒调用一次
/// @param desString 倒计时描述(区分报警倒计时描述和布防倒计时描述)
- (void)itemViewBeginCountDown:(NSString *)desString {
    //刷新banner信息
    if ([self.viewModelDelegate respondsToSelector:@selector(shouldUpdateBannerWithDelayDes:)]) {
        [self.viewModelDelegate shouldUpdateBannerWithDelayDes:desString];
    }
}

/// headerView点击缩放
/// @param isScale 缩放(YES:缩小，NO：放大)
- (void)headerViewDidScaled:(BOOL)isScale {
    //刷新view
    if (isScale) {
        if (self.currentMode == ArmModeStatusUndefine) {
            return;
        }
        //判断家庭状态是否离线是否离线
        if ([self isLocationsAllGatewayDeviceOffline] || self.currentMode == ArmModeStatusDisarmed) {
            //撤防情况下只显示离线环境设备 + error设备
            [self queryOfflineDevicesWithIgnoreDevice:@[]];
        }else {
            //环境离线设备 + bypass设备 + error设备
            [self queryAlreadyBypassDevices];
        }
    }
    
    if ([self.viewModelDelegate respondsToSelector:@selector(headerViewScaled:)]) {
        [self.viewModelDelegate headerViewScaled:isScale];
    }
}

- (void)alarmCountDownDidEnd {
    self.alarmCountDown = NO;
}

#pragma mark TYSecurityHomeProtocol
/// 切换布撤防时候倒计时回调
/// @param countDownTime 倒计时时间(只返回最大值和最小值0)
- (void)asynSecurityModeWillSwitchAfterDelay:(NSInteger)countDownTime {
    if (countDownTime == 0) {
        [self clearData];
        //更新banner信息
        if ([self.viewModelDelegate respondsToSelector:@selector(shouldUpdateBannerWithDelayDes:)]) {
            [self.viewModelDelegate shouldUpdateBannerWithDelayDes:nil];
        }
        [self queryAbnormalDevicesForBanner];
    }
}

/// 切换布撤防监听
/// @param currentMode 当前状态
/// @param deleyTime 倒计时
- (void)securityModeDidSwitch:(ArmModeStatus)currentMode delayTime:(NSInteger)deleyTime {
    if (currentMode == ArmModeStatusUndefine) {
        
        [self resetAlarmingFlag];
        return;
    }
    
    
    self.currentMode = currentMode;
    
    if (currentMode == ArmModeStatusDisarmed) {
        [self resetAlarmingFlag];
        //发出撤防通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SecurityHomeDidDisarmed" object:@{@"disarmStatus" : @"1"}];
        //更新设备列表
        [self queryOfflineDevicesWithIgnoreDevice:@[]];
    }else {
        [self queryAlreadyBypassDevices];
    }
    
    if (self.alarmCountDown) {
    }
}

- (void)didReceiveHomeAlarmInfo:(TuyaSmartSecurityLocaitonStateModel *)model {

}

/// 收到ignore设备
/// @param deviceIds 设备id
- (void)didReceiveUnusualDevice:(NSArray<NSString *> *)deviceIds {
    //只有本地点击才会跳转到忽略设备列表页面
    if (self.isLocalSwitchSecurityMode) {
        if ([TY_TopViewController() isKindOfClass:NSClassFromString(@"TYSecurityBypassViewController")]) {
            self.ignoreVCHandler ? self.ignoreVCHandler(deviceIds) : nil;
            return;
        }
//        [TYProgressHUD hideAllHUDFor:TY_TopViewController().view];
        if (deviceIds.count == 0) {
//            [[TuyaSmartSecuritySwitchModeManager sharedInstance] switchSecurityArmModeWithHomeId:[self getHomeId] mode:self.tempArmMode];
            [self.currentHome switchSecurityArmMode:self.tempArmMode];
            if ([self.viewModelDelegate respondsToSelector:@selector(gatewayDeviceBeginSwitchMode)]) {
                [self.viewModelDelegate gatewayDeviceBeginSwitchMode];
            }
        }else {
            if ([self.viewModelDelegate respondsToSelector:@selector(didReceiveUnusualDevice:)]) {
                [self.viewModelDelegate didReceiveUnusualDevice:deviceIds];
            }
        }
    }
}

/// 收到bypass设备
/// @param deviceIds 设备id
- (void)didReceiveBypassDevice:(NSArray<NSString *> *)deviceIds {
//    NSArray *bypassDevice = [TYSecurityAlarmUntil getUnusualDeviceWithDeviceIds:deviceIds];
//    [self queryOfflineDevicesWithIgnoreDevice:bypassDevice];
}

/// 单个网关最终布撤防回调
/// @param targetMode 模式
/// @param deviceId 设备id
- (void)gatewayDeviceDidEnterMode:(ArmModeStatus)targetMode deviceId:(NSString *)deviceId state:(TYSecurityGatewayDeviceArmResultType)state {
    if (!self.isLocalSwitchSecurityMode) {
        return;
    }
    if ([self.viewModelDelegate respondsToSelector:@selector(gatewayDeviceDidEnterMode:deviceId:state:)]) {
        [self.viewModelDelegate gatewayDeviceDidEnterMode:targetMode deviceId:deviceId state:state];
    }
}

/// 网关状态更新
/// @param type 更新类型
/// @param success 是否成功
- (void)gatewayStateDidUpdate:(TYHSGatewayStateUpdateType)type success:(BOOL)success error:(NSError *)error {
    if (!success) {
//        [TYProgressHUD hideAllHUDFor:TY_TopViewController().view];
//        [TPProgressUtils showError:error];
        return;
    }
    
    if (type == TYHSGatewayStateUpdateType_SoundOff || type == TYHSGatewayStateUpdateType_SoundOpen) {
//        NSNumber *state = (type == TYHSGatewayStateUpdateType_SoundOff) ? @(1) : @(0);
//        [[NSNotificationCenter defaultCenter] postNotificationName:kSecurityNotiZigbeeGatewayVoiceSwitchChange object:@{@"voice_state":state}];
        return;
    }
    
    if (type == TYHSGatewayStateUpdateType_CancelAlarm) {
        if ([TY_TopViewController() isKindOfClass:NSClassFromString(@"TYWarningViewController")]) {
            [TY_TopViewController().navigationController popViewControllerAnimated:YES];
        }
        return;
    }
    
    if (type == TYHSGatewayStateUpdateType_CancelAlarmAndDisarm) {
        //撤防通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SecurityHomeDidDisarmed" object:@{@"disarmStatus" : @"1"}];
        if ([TY_TopViewController() isKindOfClass:NSClassFromString(@"TYWarningViewController")]) {
            [TY_TopViewController().navigationController popViewControllerAnimated:YES];
        }
        //取消报警通知
//        [[NSNotificationCenter defaultCenter] postNotificationName:SecurityNotiZigbeeGatewayAlarmStatusChange object:@{@"alarm_state":@"normal"}];
        return;
    }
}

/// 更新首页状态
/// @param state 状态
- (void)shouldUpdateLocationStatus:(GatewayDeviceState)state {
    if (state == GatewayDeviceState_gatewayDeviceOffline) {
        if ([self.viewModelDelegate respondsToSelector:@selector(homeViewShouldReLayoutWithGateWayState:)]) {
            [self.viewModelDelegate homeViewShouldReLayoutWithGateWayState:GatewayDeviceState_gatewayDeviceOffline];
        }
        
//        if ([self.headerViewDelegate respondsToSelector:@selector(refreshPreventViewWithSecurityMode:)]) {
//            [self.headerViewDelegate refreshPreventViewWithSecurityMode:[TYStatusPreventViewHelper emptyModeLogic]];
//        }
    }
}

/// 网关布撤防状态
/// @param models 设备状态
- (void)shouldAlterGatewayStateView:(NSArray<TuyaSmartSecurityGatewayStatuModel *> *)models {
    if (!self.isLocalSwitchSecurityMode) {
        return;
    }
    if ([self.viewModelDelegate respondsToSelector:@selector(homeVCshouldAlterGatewayStateView:)]) {
        if (models.count == 0 || !models) {
            return;
        }
        [self.viewModelDelegate homeVCshouldAlterGatewayStateView:models];
        self.isLocalSwitchSecurityMode = NO;
    }
}

- (void)handlerError:(NSError *)error errorType:(TYSecurityModeErrorType)errorType {
    if (errorType == TYSecurityModeErrorType_SwitchModeError ||
        errorType == TYSecurityModeErrorType_QueryModeError ||
        errorType == TYSecurityModeErrorType_QueryIgnoreDeviceError) {
        self.isLocalSwitchSecurityMode = NO;
    }
}

- (void)gatewayDeviceBeginSwitchMode {
    if ([self.viewModelDelegate respondsToSelector:@selector(gatewayDeviceBeginSwitchMode)]) {
        [self.viewModelDelegate gatewayDeviceBeginSwitchMode];
    }
}

#pragma mark -
- (void)ansySecurityStatus:(ArmModeStatus)status {
    //发送通知，配网页面校验是否允许添加安防设备
    BOOL allowAddSecurityDevice = (status == ArmModeStatusDisarmed);
//    [[NSNotificationCenter defaultCenter] postNotificationName:kSecurityNotiCheckAllowAddDevice object:nil userInfo:@{@"allowAddSecurity" : @(allowAddSecurityDevice)}];
//    [TYStatusPreventViewHelper cahceGatewayStatus:status];
    if (status == ArmModeStatusDisarmed) {
//        [TYStatusPreventViewHelper sharedInstance].allowToDelaySettingVC = YES;
    }else {
//        [TYStatusPreventViewHelper sharedInstance].allowToDelaySettingVC = NO;
    }
}

#pragma mark - service


@end
