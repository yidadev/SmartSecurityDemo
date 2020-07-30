//
//  TuyaSmartSecurityPreModel.h
//  TYSecurityHomeSecModule
//
//  Created by MokZF on 2020/6/9.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityPreModel : NSObject

@property (nonatomic, copy) NSString *mode;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *stage;//当前状态，pre/switching/done
@property (nonatomic, assign) NSTimeInterval enterTime;//预计进入布撤防时间
@property (nonatomic, strong) NSArray *states;//网关状态列表

@end

NS_ASSUME_NONNULL_END
