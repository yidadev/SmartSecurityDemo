//
//  TYSecurityRuleDeviceGroupByRoomModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/8/8.
//

#import <Foundation/Foundation.h>

@class TuyaSmartSecurityArmedRuleDeviceModel;

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityRuleDeviceGroupByRoomModel : NSObject

@property (strong, nonatomic) NSString *roomName;

@property (strong, nonatomic) NSArray<TuyaSmartSecurityArmedRuleDeviceModel *> *ruleDeviceList;

@end

NS_ASSUME_NONNULL_END
