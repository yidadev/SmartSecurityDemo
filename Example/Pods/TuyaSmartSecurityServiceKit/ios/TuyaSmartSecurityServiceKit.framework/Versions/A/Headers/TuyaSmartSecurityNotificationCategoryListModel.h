//
//  TYNotificationCategoryListModel.h
//  BlocksKit
//
//  Created by MokZF on 2019/10/23.
//

#import <Foundation/Foundation.h>


@class TuyaSmartSecurityNotificationItemModel;

@interface TuyaSmartSecurityNotificationDisturbModel : NSObject

@property(nonatomic, copy) NSString *targetId;
@property(nonatomic, copy) NSString *timeZoneId;
@property(nonatomic, copy) NSString *bizId;
@property(nonatomic, copy) NSString *startTime;
@property(nonatomic, copy) NSString *endTime;

@end

@interface TuyaSmartSecurityNotificationItemModel : NSObject

@property(nonatomic, copy) NSString *name;
@property(nonatomic, assign) BOOL value;
@property(nonatomic, assign) NSInteger type;

@property(nonatomic, strong) NSArray<TuyaSmartSecurityNotificationDisturbModel *> *disturbList;

@end

@interface TuyaSmartSecurityNotificationCategoryListModel : NSObject

@property(nonatomic, assign) BOOL isDefault;
@property(nonatomic, copy) NSString *bizKey;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) NSArray<TuyaSmartSecurityNotificationItemModel *> *switchList;
@property(nonatomic, assign) NSInteger sortOrder;
@end


