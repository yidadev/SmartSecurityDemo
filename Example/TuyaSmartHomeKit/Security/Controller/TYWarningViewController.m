//
//  TYWarningViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/28.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYWarningViewController.h"
#import "TYSmartHomeManager.h"
#import <TYUIKit/TYUIKit.h>
#import <TYFoundationKit/TYFoundationKit.h>
#import <Masonry/Masonry.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartHome+TuyaSmartSecurity.h>

@interface TYWarningViewController ()
@property (nonatomic, strong) UIButton *cancelAlarmButton;
@property (nonatomic, strong) UIButton *disarmButton;
@property (nonatomic, strong) TuyaSmartHome *currentHome;
@property (nonatomic, strong) UILabel *alarmMsg;


@end

@implementation TYWarningViewController

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


#pragma mark -
#pragma mark - public method


#pragma mark -
#pragma mark - private method

#pragma mark - network load


#pragma mark -  update


#pragma mark -  p_private
- (void)_cancelAlarm {
    [self.currentHome updateGatewayState:TYHSGatewayStateUpdateType_CancelAlarm];
}

- (void)_disarm {
    [self.currentHome updateGatewayState:TYHSGatewayStateUpdateType_CancelAlarmAndDisarm];
}


#pragma mark -
#pragma mark - getter and setter
- (UIButton *)cancelAlarmButton {
    if (!_cancelAlarmButton) {
        _cancelAlarmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelAlarmButton setTitle:@"Cancel Alarm" forState:UIControlStateNormal];
        [_cancelAlarmButton setTintColor:[UIColor whiteColor]];
        _cancelAlarmButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _cancelAlarmButton.backgroundColor = [UIColor orangeColor];
        [_cancelAlarmButton addTarget:self action:@selector(_cancelAlarm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelAlarmButton;
}

- (UIButton *)disarmButton {
    if (!_disarmButton) {
        _disarmButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_disarmButton setTitle:@"Disarm" forState:UIControlStateNormal];
        [_disarmButton setTintColor:[UIColor whiteColor]];
        _disarmButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _disarmButton.backgroundColor = [UIColor orangeColor];
        [_disarmButton addTarget:self action:@selector(_disarm) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disarmButton;
}

- (UILabel *)alarmMsg {
    if (!_alarmMsg) {
        _alarmMsg = [UILabel new];
        _alarmMsg.font = [UIFont systemFontOfSize:25.0];
        _alarmMsg.textColor = [UIColor blackColor];
        _alarmMsg.textAlignment = NSTextAlignmentCenter;
        _alarmMsg.numberOfLines = 0;
    }
    return _alarmMsg;
}

- (TuyaSmartHome *)currentHome {
    if (!_currentHome) {
        _currentHome = [TYSmartHomeManager sharedInstance].currentHome;
    }
    return _currentHome;
}

#pragma mark -
#pragma mark - init

- (void)initPage {
    [self initTopBarView];
    [self.view addSubview:self.topBarView];
    [self.view addSubview:self.cancelAlarmButton];
    [self.view addSubview:self.disarmButton];
    [self.view addSubview:self.alarmMsg];
    
    [self.alarmMsg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBarView.mas_bottom);
        make.left.mas_equalTo(self.view).offset(15);
        make.right.mas_equalTo(self.view).offset(-15);
        make.height.mas_equalTo(200);
    }];
    
    [self.cancelAlarmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
    [self.disarmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cancelAlarmButton.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
}

- (void)initTopBarView {
    self.centerTitleItem.title = @"Alarming";
    self.topBarView.centerItem = self.centerTitleItem;
    self.leftBackItem.title = @"Back";
    self.topBarView.leftItem = self.leftBackItem;
    
//    self.topBarView.rightItem = self.rightTitleItem;
//    self.rightTitleItem.title = @"Setting";
//    self.rightTitleItem.target = self;
//    self.rightTitleItem.action = @selector(rightItemAction);
//    self.topBarView.rightItem = self.rightTitleItem;
//    [self addSubViews];
}

- (void)dataInit {
    ty_weakify(self);
    [self.currentHome getAlarmMessageList:^(NSArray<TuyaSmartSecurityGatewayAlarmMessageModel *> * _Nonnull alarmMessageArray) {
        ty_strongify(self);
        NSString *message = @"";
        for (TuyaSmartSecurityGatewayAlarmMessageModel *model in alarmMessageArray) {
            message = [NSString stringWithFormat:@"%@\n%@",message,model.typeDesc];
        }
        self.alarmMsg.text = message;
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

@end
