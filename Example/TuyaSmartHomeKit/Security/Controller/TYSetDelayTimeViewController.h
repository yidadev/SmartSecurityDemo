//
//  TYSetDelayTimeViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/29.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TYSetDelayTimeViewController : TPBaseViewController

@property (nonatomic, assign) ArmModeStatus currentMode;
@property (nonatomic, assign) BOOL isAlarming;
@property (nonatomic, assign) NSInteger currentTime;
@property (nonatomic, assign) NSInteger alarmTime;

@end

NS_ASSUME_NONNULL_END
