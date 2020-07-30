//
//  TYArmedHomeViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/18.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"
#import <TuyaSmartSecurityBaseKit/TuyaSmartHome+TuyaSmartSecurity.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYArmedHomeViewController : TPBaseViewController

@property (nonatomic, strong) UIButton *stayButton;
@property (nonatomic, strong) UIButton *awayButton;
@property (nonatomic, strong) UIButton *disarmButton;
@property (nonatomic, strong) UIButton *sosButton;
@property (nonatomic, strong) UITextField *currnetModelLabel;
@property (nonatomic, strong) UITextField *locationOnlineState;
@property (nonatomic, strong) UITextField *countDownLabel;
@property (nonatomic, strong) UITextField *bypassDeviceLabel;
@property (nonatomic, strong) TuyaSmartHome *currentHome;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, copy, nullable) NSString *countDownLabelString;
@property (nonatomic, assign) NSInteger countDownCount;
@property (nonatomic, assign) ArmModeStatus tempMode;
@property (nonatomic, assign) ArmModeStatus currentMode;
@property (nonatomic, assign) BOOL isAlarming;

- (void)releaseTimer;


@end

NS_ASSUME_NONNULL_END
