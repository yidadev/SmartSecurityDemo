//
//  TYIgnoreDeviceListViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/28.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYIgnoreDeviceListViewController.h"
#import <Masonry/Masonry.h>
#import "TYSmartHomeManager.h"

@interface TYIgnoreDeviceListViewController ()

@property (nonatomic, strong) UILabel *currnetModelLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *continueButton;
@property (nonatomic, strong) UIButton *cancelButton;

@end

@implementation TYIgnoreDeviceListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTopBarView];
    [self initPage];
}

- (void)initTopBarView {
    self.centerTitleItem.title = @"Ignore Devcies";
    self.topBarView.centerItem = self.centerTitleItem;
    self.leftBackItem.title = @"Back";
    self.topBarView.leftItem = self.leftBackItem;
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
- (void)_continueAction {
    self.continueBlock ? self.continueBlock() : nil;
}

- (void)_cancelAction {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark - getter and setter
- (UILabel *)currnetModelLabel {
    if (!_currnetModelLabel) {
        _currnetModelLabel = [UILabel new];
        _currnetModelLabel.font = [UIFont systemFontOfSize:16.0];
        _currnetModelLabel.textColor = [UIColor blackColor];
        _currnetModelLabel.enabled = NO;
        _currnetModelLabel.numberOfLines = 0;
        _currnetModelLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _currnetModelLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18.0];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.text = @"ignore Device Ids";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)continueButton {
    if (!_continueButton) {
        _continueButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_continueButton setTitle:@"Continue" forState:UIControlStateNormal];
        [_continueButton setTintColor:[UIColor whiteColor]];
        _continueButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _continueButton.backgroundColor = [UIColor orangeColor];
        [_continueButton addTarget:self action:@selector(_continueAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _continueButton;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [_cancelButton setTintColor:[UIColor whiteColor]];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _cancelButton.backgroundColor = [UIColor orangeColor];
        [_cancelButton addTarget:self action:@selector(_cancelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}

- (void)setIgnoreDeviceIds:(NSArray *)ignoreDeviceIds {
    _ignoreDeviceIds = ignoreDeviceIds;
    NSString *text = @"";
    for (NSString *deviceId in ignoreDeviceIds) {
        NSArray *allDevices = [TYSmartHomeManager sharedInstance].currentHome.deviceList;
        for (TuyaSmartDeviceModel *deviceModel in allDevices) {
            if ([deviceId isEqualToString:deviceModel.nodeId]) {
                text = [NSString stringWithFormat:@"\n%@ abnormal",deviceModel.name];
            }
        }
    }
    self.currnetModelLabel.text = text;
}
#pragma mark -
#pragma mark - init

- (void)initPage {
    [self.view addSubview:self.currnetModelLabel];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.continueButton];
    [self.view addSubview:self.cancelButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(30);
    }];
    
    [self.currnetModelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
        make.right.left.mas_equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    
    [self.continueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.continueButton.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
}

@end
