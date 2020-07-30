//
//  TYSecurityRuleDeviceModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/6/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface TuyaSmartSecurityArmedRuleDeviceModel : NSObject

/// 设备id
@property (nonatomic, copy) NSString *deviceId;

/// 用户id
@property (nonatomic, copy) NSString *uid;

/// 家庭拥有者id
@property (nonatomic, copy) NSString *ownerId;

/// 设备的名称（配网后设备的名称）
@property (nonatomic, copy) NSString *name;

/// 设备的别称（修改后的设备名称）
@property (nonatomic, copy) NSString *customName;

/// 设备能力
@property (nonatomic, assign) NSInteger ability;

/// 设备产品分类id
@property (nonatomic, copy) NSString *productId;

/// 设备产品代码
@property (nonatomic, copy) NSString *productCode;

/// 设备类别
@property (nonatomic, copy) NSString *categoryName;

/// 是否是子设备
@property (nonatomic, assign) BOOL sub;

/// 是否是环境设备（环境设备不参与选择，所有布防类型下都是参与联动）
@property (nonatomic, assign) BOOL fixed;

/// 是否选中，安全设备是否参与布防类型的规则
@property (nonatomic, assign) BOOL selected;

/// 设备的图片
@property (nonatomic, copy) NSString *icon;

/// 设备的激活时间
@property (nonatomic, assign) NSTimeInterval activeTime;

@end

NS_ASSUME_NONNULL_END
