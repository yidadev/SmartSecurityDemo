//
//  TYSecurityDeviceCategoryModel.h
//  BlocksKit
//
//  Created by 浩天 on 2019/5/21.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartSecurityArmedRuleDeviceModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityDeviceCategoryModel : NSObject

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *code;
@property (strong, nonatomic) NSArray<TuyaSmartSecurityArmedRuleDeviceModel *> *ruleDeviceModels;

@end

NS_ASSUME_NONNULL_END
