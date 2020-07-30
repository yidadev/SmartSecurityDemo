//
//  TYEventLinkRuleModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/10/23.
//

#import <Foundation/Foundation.h>

@class TuyaSmartSecurityEventRecordingBindCameraModel;

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityEventRecordingLinkRuleModel : NSObject


/// 规则Id / Rule ID
@property(nonatomic, copy) NSString *ruleId;

/// 设备ID / Device ID
@property(nonatomic, copy) NSString *deviceId;

/// 绑定的摄像头列表 / cameras for the specified sensor bindings
@property(nonatomic, strong) NSArray<TuyaSmartSecurityEventRecordingBindCameraModel *> *actionInfos;

@end

NS_ASSUME_NONNULL_END
