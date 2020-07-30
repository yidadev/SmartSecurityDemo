//
//  TYSelectDelayViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/29.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYSelectDelayViewController.h"
#import "TYSetDelayTimeViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityArmedRuleSetting.h>
#import "TYSmartHomeManager.h"
#import <TYFoundationKit/TYFoundationKit.h>


@interface TYSelectDelayViewController ()

@property (nonatomic, strong) UIButton *exitDelayBtn;
@property (nonatomic, strong) UIButton *entryDelayBtn;

@property (nonatomic, strong) UILabel *exitDelayTimeLabel;
@property (nonatomic, strong) UILabel *entryDelayTimeLabel;

@property (nonatomic, strong) TuyaSmartSecurityArmedRuleDelayTimeModel *timeModel;


@end

@implementation TYSelectDelayViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPage];
    [self loadData];
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

- (void)_exitDelay {
    TYSetDelayTimeViewController *delayVC = [TYSetDelayTimeViewController new];
    delayVC.currentMode = self.currentMode;
    delayVC.isAlarming = NO;
    delayVC.currentTime = self.timeModel.enableDelayTime;
    delayVC.alarmTime = self.timeModel.alarmDelayTime;
    [self.navigationController pushViewController:delayVC animated:YES];
}

- (void)_entryDelay {
    TYSetDelayTimeViewController *delayVC = [TYSetDelayTimeViewController new];
    delayVC.currentMode = self.currentMode;
    delayVC.isAlarming = YES;
    delayVC.currentTime = self.timeModel.enableDelayTime;
    delayVC.alarmTime = self.timeModel.alarmDelayTime;
    [self.navigationController pushViewController:delayVC animated:YES];
}


#pragma mark -
#pragma mark - getter and setter

- (UIButton *)exitDelayBtn {
    if (!_exitDelayBtn) {
        _exitDelayBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_exitDelayBtn setTitle:@"Exit Delay" forState:UIControlStateNormal];
        [_exitDelayBtn setTintColor:[UIColor whiteColor]];
        _exitDelayBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _exitDelayBtn.backgroundColor = [UIColor orangeColor];
        [_exitDelayBtn addTarget:self action:@selector(_exitDelay) forControlEvents:UIControlEventTouchUpInside];
        _exitDelayBtn.layer.cornerRadius = 5;
        _exitDelayBtn.layer.masksToBounds = YES;
    }
    return _exitDelayBtn;
}

- (UIButton *)entryDelayBtn {
    if (!_entryDelayBtn) {
        _entryDelayBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_entryDelayBtn setTitle:@"Entry Delay" forState:UIControlStateNormal];
        [_entryDelayBtn setTintColor:[UIColor whiteColor]];
        _entryDelayBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _entryDelayBtn.backgroundColor = [UIColor orangeColor];
        [_entryDelayBtn addTarget:self action:@selector(_entryDelay) forControlEvents:UIControlEventTouchUpInside];
        _entryDelayBtn.layer.cornerRadius = 5;
        _entryDelayBtn.layer.masksToBounds = YES;
    }
    return _entryDelayBtn;
}

- (UILabel *)exitDelayTimeLabel {
    if (!_exitDelayTimeLabel) {
        _exitDelayTimeLabel = [UILabel new];
        _exitDelayTimeLabel.font = [UIFont systemFontOfSize:15];
        _exitDelayTimeLabel.textColor = [UIColor blackColor];
    }
    return _exitDelayTimeLabel;
}

- (UILabel *)entryDelayTimeLabel {
    if (!_entryDelayTimeLabel) {
        _entryDelayTimeLabel = [UILabel new];
        _entryDelayTimeLabel.font = [UIFont systemFontOfSize:15];
        _entryDelayTimeLabel.textColor = [UIColor blackColor];
    }
    return _entryDelayTimeLabel;
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
    
    [self.view addSubview:self.exitDelayBtn];
    [self.view addSubview:self.entryDelayBtn];
    [self.view addSubview:self.entryDelayTimeLabel];
    [self.view addSubview:self.exitDelayTimeLabel];
    
    [self.exitDelayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBarView.mas_bottom).offset(20);
        make.left.mas_equalTo(self.view).offset(20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(54);
    }];
    
    [self.exitDelayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        make.centerY.mas_equalTo(self.exitDelayBtn);
        make.size.mas_equalTo(CGSizeMake(30, 54));
    }];
    
    [self.entryDelayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.exitDelayBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(54);
    }];
    
    [self.entryDelayTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-20);
        make.centerY.mas_equalTo(self.entryDelayBtn);
        make.size.mas_equalTo(CGSizeMake(30, 54));
    }];
}

- (void)loadData {
    
    long long homeId = [TYSmartHomeManager sharedInstance].currentHome.homeModel.homeId;
    
    ty_weakify(self);
    [[TuyaSmartSecurityArmedRuleSetting sharedInstance]
     getDelayTimeWithMode:self.currentMode
     homeId:homeId
     success:^(TuyaSmartSecurityArmedRuleDelayTimeModel * _Nullable delayTime) {
        ty_strongify(self);
        self.exitDelayTimeLabel.text = [NSString stringWithFormat:@"%ld",delayTime.enableDelayTime];
        self.entryDelayTimeLabel.text = [NSString stringWithFormat:@"%ld",delayTime.alarmDelayTime];
        self.timeModel = delayTime;
        
    } failure:^(NSError *error) {
        
        [TPProgressUtils showError:error];
    }];
    
    
    
    
}

@end
