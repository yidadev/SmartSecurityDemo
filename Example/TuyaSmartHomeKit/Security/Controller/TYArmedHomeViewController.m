//
//  TYArmedHomeViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/18.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYArmedHomeViewController.h"
#import <TYUIKit/TYUIKit.h>
#import <Masonry/Masonry.h>
#import "TYSmartHomeManager.h"
#import "TYArmedHomeViewController+Delegate.h"
#import "TYArmSettingViewCtoller.h"

@interface TYArmedHomeViewController ()


@end

@implementation TYArmedHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPage];
    [self dataInit];
}
#pragma mark -
#pragma mark - delegate


#pragma mark -
#pragma mark - action
- (void)rightItemAction {
    TYArmSettingViewCtoller *setVC = [TYArmSettingViewCtoller new];
    setVC.currentMode = self.currentMode;
    [self.navigationController pushViewController:setVC animated:YES];
}

#pragma mark -
#pragma mark - public method
- (void)releaseTimer {
    if (self.isAlarming) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
    self.countDownLabelString = nil;
    self.countDownLabel.text = @"mode countdown: 0";
}

#pragma mark -
#pragma mark - private method
- (void)disarmAction {
    if (self.currentMode == ArmModeStatusDisarmed) {
        [TPProgressUtils showSuccess:@"already in Disarm mode" toView:self.view];
        return;
    }
    [self.currentHome switchSecurityArmMode:ArmModeStatusDisarmed];
}

- (void)stayAction {
    self.tempMode = ArmModeStatusStaying;
    if (self.currentMode == ArmModeStatusStaying) {
        [TPProgressUtils showSuccess:@"Location already in Stay mode" toView:self.view];
        return;
    }
    [self.currentHome queryIgnoreDevicesFromGateway:ArmModeStatusStaying completeHandler:nil];
}

- (void)awayAction {
    self.tempMode = ArmModeStatusLeaving;
    if (self.currentMode == ArmModeStatusLeaving) {
        [TPProgressUtils showSuccess:@"Location already in Away mode" toView:self.view];
        return;
    }
    [self.currentHome queryIgnoreDevicesFromGateway:ArmModeStatusLeaving completeHandler:nil];
}

- (void)_timerIntervalAction {
    self.countDownLabel.text = [NSString stringWithFormat:@" %@: %ld",self.countDownLabelString,self.countDownCount];
    self.countDownCount--;
    if (self.countDownCount == 0) {
        [self releaseTimer];
    }
}

- (void)_sosAction {
    [self.currentHome startSOSAlarm:TYHSGatewaySOSType_Fire success:^(BOOL success) {
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark - network load


#pragma mark -  update


#pragma mark -  p_private

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -
#pragma mark - getter and setter
- (UIButton *)sosButton {
    if (!_sosButton) {
        _sosButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_sosButton setTitle:@"SOS" forState:UIControlStateNormal];
        [_sosButton setTintColor:[UIColor whiteColor]];
        _sosButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _sosButton.backgroundColor = [UIColor orangeColor];
        _sosButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_sosButton addTarget:self action:@selector(_sosAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sosButton;
}
- (UIButton *)stayButton {
    if (!_stayButton) {
        _stayButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_stayButton setTitle:@"Stay" forState:UIControlStateNormal];
        [_stayButton setTintColor:[UIColor whiteColor]];
        _stayButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _stayButton.backgroundColor = [UIColor orangeColor];
        [_stayButton addTarget:self action:@selector(stayAction) forControlEvents:UIControlEventTouchUpInside];
        _stayButton.layer.cornerRadius = 36;
        _stayButton.layer.masksToBounds = YES;
    }
    return _stayButton;
}

- (UIButton *)awayButton {
    if (!_awayButton) {
        _awayButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_awayButton setTitle:@"Away" forState:UIControlStateNormal];
        [_awayButton setTintColor:[UIColor whiteColor]];
        _awayButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _awayButton.backgroundColor = [UIColor orangeColor];
        [_awayButton addTarget:self action:@selector(awayAction) forControlEvents:UIControlEventTouchUpInside];
        _awayButton.layer.cornerRadius = 36;
        _awayButton.layer.masksToBounds = YES;
    }
    return _awayButton;
}

- (UIButton *)disarmButton {
    if (!_disarmButton) {
        _disarmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_disarmButton setTitle:@"Disarm" forState:UIControlStateNormal];
        [_disarmButton setTintColor:[UIColor whiteColor]];
        _disarmButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _disarmButton.backgroundColor = [UIColor orangeColor];
        [_disarmButton addTarget:self action:@selector(disarmAction) forControlEvents:UIControlEventTouchUpInside];
        _disarmButton.layer.cornerRadius = 36;
        _disarmButton.layer.masksToBounds = YES;
    }
    return _disarmButton;
}

- (UITextField *)currnetModelLabel {
    if (!_currnetModelLabel) {
        _currnetModelLabel = [UITextField new];
        _currnetModelLabel.font = [UIFont systemFontOfSize:14.0];
        _currnetModelLabel.textColor = [UIColor blackColor];
        _currnetModelLabel.text = @" Current Security Mode is: ";
        _currnetModelLabel.layer.borderColor = UIColor.orangeColor.CGColor;
        _currnetModelLabel.layer.borderWidth = 1.0;
        _currnetModelLabel.enabled = NO;
    }
    return _currnetModelLabel;
}

- (UITextField *)countDownLabel {
    if (!_countDownLabel) {
        _countDownLabel = [UITextField new];
        _countDownLabel.font = [UIFont systemFontOfSize:14.0];
        _countDownLabel.textColor = [UIColor blackColor];
        _countDownLabel.layer.borderColor = UIColor.orangeColor.CGColor;
        _countDownLabel.layer.borderWidth = 1.0;
        _countDownLabel.enabled = NO;
    }
    return _countDownLabel;
}

- (TuyaSmartHome *)currentHome {
    if (!_currentHome) {
        _currentHome = [TYSmartHomeManager sharedInstance].currentHome;
        _currentHome.securityDelegate = self;
    }
    return _currentHome;
}

- (UITextField *)locationOnlineState {
    if (!_locationOnlineState) {
        _locationOnlineState = [UITextField new];
        _locationOnlineState.font = [UIFont systemFontOfSize:14.0];
        _locationOnlineState.textColor = [UIColor blackColor];
        _locationOnlineState.text = @" Locaiton Online State: ";
        _locationOnlineState.layer.borderColor = UIColor.orangeColor.CGColor;
        _locationOnlineState.layer.borderWidth = 1.0;
        _locationOnlineState.enabled = NO;
    }
    return _locationOnlineState;
}

- (UITextField *)bypassDeviceLabel {
    if (!_bypassDeviceLabel) {
        _bypassDeviceLabel = [UITextField new];
        _bypassDeviceLabel.font = [UIFont systemFontOfSize:14.0];
        _bypassDeviceLabel.textColor = [UIColor blackColor];
        _bypassDeviceLabel.layer.borderColor = UIColor.orangeColor.CGColor;
        _bypassDeviceLabel.layer.borderWidth = 1.0;
        _bypassDeviceLabel.text = @"bypass:";
        _bypassDeviceLabel.enabled = NO;
    }
    return _bypassDeviceLabel;
}

- (NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(_timerIntervalAction) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer
                                     forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

#pragma mark -
#pragma mark - init

- (void)initPage {
    [self initTopBarView];
}

- (void)initTopBarView {
    [self.view addSubview:self.topBarView];
    self.centerTitleItem.title = @"Security Mode";
    self.topBarView.centerItem = self.centerTitleItem;
    self.leftBackItem.title = @"Back";
    self.topBarView.leftItem = self.leftBackItem;
    
    self.topBarView.rightItem = self.rightTitleItem;
    self.rightTitleItem.title = @"Setting";
    self.rightTitleItem.target = self;
    self.rightTitleItem.action = @selector(rightItemAction);
    self.topBarView.rightItem = self.rightTitleItem;
    [self addSubViews];
}

- (void)addSubViews {
    [self.view addSubview:self.stayButton];
    [self.view addSubview:self.awayButton];
    [self.view addSubview:self.disarmButton];
    [self.view addSubview:self.currnetModelLabel];
    [self.view addSubview:self.locationOnlineState];
    [self.view addSubview:self.countDownLabel];
    [self.view addSubview:self.bypassDeviceLabel];
    [self.view addSubview:self.sosButton];
    [self layoutSubViews];
}

- (void)layoutSubViews {
    CGFloat spaceW = (TY_ScreenWidth() - 72 - 72 -72)/4;
    [self.awayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(72, 72));
        make.left.mas_equalTo(self.view).offset(spaceW);
        make.top.mas_equalTo(self.topBarView).offset(100);
    }];
    
    [self.disarmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.awayButton);
        make.top.mas_equalTo(self.awayButton);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [self.stayButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.disarmButton);
        make.size.mas_equalTo(self.awayButton);
        make.left.mas_equalTo(self.disarmButton.mas_right).offset(spaceW);
    }];
    
    [self.locationOnlineState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.disarmButton.mas_bottom).offset(10);
        make.left.mas_equalTo(self.awayButton);
        make.height.mas_equalTo(54);
        make.right.mas_equalTo(self.stayButton);
    }];
    
    [self.currnetModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.locationOnlineState.mas_bottom).offset(10);
        make.left.mas_equalTo(self.awayButton);
        make.height.mas_equalTo(54);
        make.right.mas_equalTo(self.stayButton);
    }];
    
    [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.currnetModelLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.awayButton);
        make.height.mas_equalTo(54);
        make.right.mas_equalTo(self.stayButton);
    }];
    
    [self.bypassDeviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.countDownLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.awayButton);
        make.height.mas_equalTo(80);
        make.right.mas_equalTo(self.stayButton);
    }];
    
    [self.sosButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bypassDeviceLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.awayButton);
        make.height.mas_equalTo(54);
        make.right.mas_equalTo(self.stayButton);
    }];
}

- (void)dataInit {
    //获取网关白名单列表
    security_weakify(self);
    [self.currentHome getGateWayDevice:^(NSArray<NSString *> * _Nonnull dataArray) {
        security_strongify(self);
        if (dataArray.count > 0) {
            //获取家庭状态(报警状态、倒计时、在离线等信息)
            [self.currentHome registerWithGatewayIds:dataArray];
            [self.currentHome getHomeSecurityState];
        }else {
            //无网关页面
        }
    } failure:^(NSError * _Nonnull error) {
        //无网关页面
        [TPProgressUtils showError:error];
    }];
}

- (void)dealloc {
    NSLog(@"dealloc: %@",NSStringFromClass([self class]));
}
@end
