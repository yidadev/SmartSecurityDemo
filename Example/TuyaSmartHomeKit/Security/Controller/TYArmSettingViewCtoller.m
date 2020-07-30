//
//  TYArmSettingViewCtoller.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/29.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYArmSettingViewCtoller.h"
#import <TYUIKit/TYUIKit.h>
#import <TYFoundationKit/TYFoundationKit.h>
#import <Masonry/Masonry.h>
#import "TYSelectSensorsViewController.h"
#import "TYSelectDelayViewController.h"

@interface TYArmSettingViewCtoller ()

@property (nonatomic, strong) UILabel *titleLaleSensors;
@property (nonatomic, strong) UILabel *titleLaleDelay;

@property (nonatomic, strong) UIButton *stayS;
@property (nonatomic, strong) UIButton *awayS;

@property (nonatomic, strong) UIButton *stayD;
@property (nonatomic, strong) UIButton *awayD;

@end

@implementation TYArmSettingViewCtoller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPage];
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
- (void)_staySAction {
    TYSelectSensorsViewController *selectSensorVC = [TYSelectSensorsViewController new];
    selectSensorVC.currentMode = ArmModeStatusStaying;
    [self.navigationController pushViewController:selectSensorVC animated:YES];
}

- (void)_awaySAction {
    TYSelectSensorsViewController *selectSensorVC = [TYSelectSensorsViewController new];
    selectSensorVC.currentMode = ArmModeStatusLeaving;
    [self.navigationController pushViewController:selectSensorVC animated:YES];
}

- (void)_awayDAction {
    TYSelectDelayViewController *delayVC = [TYSelectDelayViewController new];
    delayVC.currentMode = ArmModeStatusLeaving;
    [self.navigationController pushViewController:delayVC animated:YES];
}

- (void)_stayDAction {
    TYSelectDelayViewController *delayVC = [TYSelectDelayViewController new];
    delayVC.currentMode = ArmModeStatusStaying;
    [self.navigationController pushViewController:delayVC animated:YES];
}

#pragma mark -
#pragma mark - getter and setter
- (UILabel *)titleLaleSensors {
    if (!_titleLaleSensors) {
        _titleLaleSensors = [UILabel new];
        _titleLaleSensors.font = [UIFont systemFontOfSize:16.0];
        _titleLaleSensors.text = @"Monitoring Sensors";
        _titleLaleSensors.backgroundColor = [UIColor ty_colorWithHex:0xF8F8F8];
        _titleLaleSensors.textColor = [UIColor ty_colorWithHex:0x81828B];
        _titleLaleSensors.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLaleSensors;
}

- (UILabel *)titleLaleDelay {
    if (!_titleLaleDelay) {
        _titleLaleDelay = [UILabel new];
        _titleLaleDelay.font = [UIFont systemFontOfSize:16.0];
        _titleLaleDelay.text = @"Entry & Exit Delay";
        _titleLaleDelay.backgroundColor = [UIColor ty_colorWithHex:0xF8F8F8];
        _titleLaleDelay.textColor = [UIColor ty_colorWithHex:0x81828B];
        _titleLaleDelay.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLaleDelay;
}

- (UIButton *)stayS {
    if (!_stayS) {
        _stayS = [[UIButton alloc] initWithFrame:CGRectZero];
        [_stayS setTitle:@"Stay" forState:UIControlStateNormal];
        [_stayS setTintColor:[UIColor whiteColor]];
        _stayS.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _stayS.backgroundColor = [UIColor orangeColor];
        [_stayS addTarget:self action:@selector(_staySAction) forControlEvents:UIControlEventTouchUpInside];
        _stayS.layer.cornerRadius = 5;
        _stayS.layer.masksToBounds = YES;
    }
    return _stayS;
}

- (UIButton *)awayS {
    if (!_awayS) {
        _awayS = [[UIButton alloc] initWithFrame:CGRectZero];
        [_awayS setTitle:@"Awaw" forState:UIControlStateNormal];
        [_awayS setTintColor:[UIColor whiteColor]];
        _awayS.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _awayS.backgroundColor = [UIColor orangeColor];
        [_awayS addTarget:self action:@selector(_awaySAction) forControlEvents:UIControlEventTouchUpInside];
        _awayS.layer.cornerRadius = 5;
        _awayS.layer.masksToBounds = YES;
    }
    return _awayS;
}

- (UIButton *)stayD {
    if (!_stayD) {
        _stayD = [[UIButton alloc] initWithFrame:CGRectZero];
        [_stayD setTitle:@"Stay" forState:UIControlStateNormal];
        [_stayD setTintColor:[UIColor whiteColor]];
        _stayD.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _stayD.backgroundColor = [UIColor orangeColor];
        [_stayD addTarget:self action:@selector(_stayDAction) forControlEvents:UIControlEventTouchUpInside];
        _stayD.layer.cornerRadius = 5;
        _stayD.layer.masksToBounds = YES;
    }
    return _stayD;
}

- (UIButton *)awayD {
    if (!_awayD) {
        _awayD = [[UIButton alloc] initWithFrame:CGRectZero];
        [_awayD setTitle:@"Away" forState:UIControlStateNormal];
        [_awayD setTintColor:[UIColor whiteColor]];
        _awayD.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _awayD.backgroundColor = [UIColor orangeColor];
        [_awayD addTarget:self action:@selector(_awayDAction) forControlEvents:UIControlEventTouchUpInside];
        _awayD.layer.cornerRadius = 5;
        _awayD.layer.masksToBounds = YES;
    }
    return _awayD;
}

#pragma mark -
#pragma mark - init

- (void)initPage {
    [self initTopBarView];
    [self addSuView];
}

- (void)initTopBarView {
    self.view.backgroundColor = [UIColor ty_colorWithHex:0xF8F8F8];
    [self.view addSubview:self.topBarView];
    self.centerTitleItem.title = @"Security Mode";
    self.topBarView.centerItem = self.centerTitleItem;
    self.leftBackItem.title = @"Back";
    self.topBarView.leftItem = self.leftBackItem;
    
//    self.topBarView.rightItem = self.rightTitleItem;
//    self.rightTitleItem.title = @"Setting";
//    self.rightTitleItem.target = self;
//    self.rightTitleItem.action = @selector(rightItemAction);
//    self.topBarView.rightItem = self.rightTitleItem;
}

- (void)addSuView {
    [self.view addSubview:self.titleLaleDelay];
    [self.view addSubview:self.titleLaleSensors];
    [self.view addSubview:self.stayD];
    [self.view addSubview:self.stayS];
    [self.view addSubview:self.awayD];
    [self.view addSubview:self.awayS];
    
    [self.titleLaleSensors mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.stayS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLaleSensors.mas_bottom);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(54);
    }];
    
    [self.awayS mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stayS.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(54);
    }];
    
    [self.titleLaleDelay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.awayS.mas_bottom).offset(60);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.stayD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLaleDelay.mas_bottom);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(54);
    }];
    
    [self.awayD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stayD.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(54);
    }];
}

@end
