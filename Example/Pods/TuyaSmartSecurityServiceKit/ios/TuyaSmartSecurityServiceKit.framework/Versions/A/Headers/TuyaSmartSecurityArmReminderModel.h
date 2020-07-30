//
//  TYArmReminderModel.h
//  TuyaSecuritySDK
//
//  Created by MokZF on 2019/12/18.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, TYArmReminderType) {
    TYArmReminderTypeStay = 1,//在家
    TYArmReminderTypeAway = 2//离家
};

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityArmReminderModel : NSObject

/// 家庭ID / Home ID
@property(nonatomic, copy) NSString *homeId;

/// 布防类型 / Arm Reminder Type
@property(nonatomic, assign) TYArmReminderType type;

/// 状态(开启或者关闭) / Status(Open or Close)
@property(nonatomic, assign) BOOL enable;
@property(nonatomic, copy) NSString *checkTime;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *subTitle;
@property(nonatomic, assign) BOOL on;
@property(nonatomic, assign) CGFloat rowHeight;

@end

NS_ASSUME_NONNULL_END
