//
//  TYIgnoreDeviceListViewController.h
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/28.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TPBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ContinueBlock)(void);

@interface TYIgnoreDeviceListViewController : TPBaseViewController

@property (nonatomic, strong) NSArray *ignoreDeviceIds;
@property (nonatomic, copy) ContinueBlock continueBlock;

@end

NS_ASSUME_NONNULL_END
