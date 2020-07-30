//
//  TYChooseAccountTypeViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Wei Zhang on 2020/7/18.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYChooseAccountTypeViewController.h"
#import <Masonry/Masonry.h>
#import "TYCustomerAccountViewController.h"
#import "TYLoginViewController.h"
#import "TYSmartHomeManager.h"

@interface TYChooseAccountTypeViewController ()

@property (nonatomic, strong) UIButton *tuyaAccuntButton;
@property (nonatomic, strong) UIButton *customerAccuntButton;
@property (nonatomic, strong) UITextView *tipTextView;

@end

@implementation TYChooseAccountTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTopBarView];
    [self initView];
    
    [self loadNotification];
}


- (void)initTopBarView {
    
    self.topBarView.leftItem = self.leftCancelItem;
    self.leftCancelItem.title = @"Logout";
    
    self.centerTitleItem.title = @"Tuya Account";
    self.topBarView.centerItem = self.centerTitleItem;
    
    [self.view addSubview:self.topBarView];
    
}

- (void)initView {
    
    [self.view addSubview:self.tuyaAccuntButton];
    [self.tuyaAccuntButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.view).offset(120);
        make.height.mas_equalTo(54);
    }];
    
    [self.view addSubview:self.customerAccuntButton];
    [self.customerAccuntButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.tuyaAccuntButton.mas_bottom).offset(40);
        make.height.mas_equalTo(54);
    }];
    
    [self.view addSubview:self.tipTextView];
    [self.tipTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.top.equalTo(self.customerAccuntButton.mas_bottom).offset(40);
        make.height.mas_equalTo(100);
    }];
    
}



/**
 @brief Log out action.
 */
- (void)CancelButtonTap {
    WEAKSELF_AT;
    [[TuyaSmartUser sharedInstance] loginOut:^{
        weakSelf_AT.tipTextView.text = @"Logout success!";
        [TYSmartHomeManager sharedInstance].currentHome = nil;
    } failure:^(NSError *error) {
        weakSelf_AT.tipTextView.text = error.localizedDescription;
    }];
}

- (void)loadNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionInvalid) name:TuyaSmartUserNotificationUserSessionInvalid object:nil];
}

- (void)sessionInvalid {
    if ([[TuyaSmartUser sharedInstance] isLogin]) {
        // Log out.
        [[TuyaSmartUser sharedInstance] loginOut:NULL failure:NULL];
        [TYSmartHomeManager sharedInstance].currentHome = nil;
        self.tipTextView.text = @"Session expired，you need to login again.";
    }
}


- (UIButton *)tuyaAccuntButton {
    if (!_tuyaAccuntButton) {
        _tuyaAccuntButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _tuyaAccuntButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_tuyaAccuntButton setTitle:@"Tuya Account" forState:UIControlStateNormal];
        [_tuyaAccuntButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _tuyaAccuntButton.backgroundColor = UIColor.orangeColor;
        WEAKSELF_AT
        [_tuyaAccuntButton bk_addEventHandler:^(id sender) {

            TYLoginViewController *loginVC = [TYLoginViewController new];
            [weakSelf_AT.navigationController pushViewController:loginVC animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tuyaAccuntButton;
}


- (UIButton *)customerAccuntButton {
    if (!_customerAccuntButton) {
        _customerAccuntButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _customerAccuntButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_customerAccuntButton setTitle:@"Customer Account" forState:UIControlStateNormal];
        [_customerAccuntButton setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        _customerAccuntButton.backgroundColor = UIColor.orangeColor;
        WEAKSELF_AT
        [_customerAccuntButton bk_addEventHandler:^(id sender) {
            
            TYCustomerAccountViewController *vc = [TYCustomerAccountViewController new];
            [weakSelf_AT.navigationController pushViewController:vc animated:YES];
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _customerAccuntButton;
}

- (UITextView *)tipTextView {
    if (!_tipTextView) {
        _tipTextView = [[UITextView alloc] initWithFrame:CGRectZero];
        _tipTextView.editable = NO;
        
        _tipTextView.font = [UIFont systemFontOfSize:15.0];
        _tipTextView.layer.borderColor = UIColor.blackColor.CGColor;
        _tipTextView.layer.borderWidth = 1.0;
    }
    return _tipTextView;
}

@end
