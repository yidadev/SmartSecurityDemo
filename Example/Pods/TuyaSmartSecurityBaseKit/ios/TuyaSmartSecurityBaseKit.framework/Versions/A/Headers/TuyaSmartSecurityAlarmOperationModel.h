//
//  TYSecurityAlarmOperationModel.h
//  TYSecurityHomeModule
//
//  Created by MokZF on 2020/4/10.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TYAlarmOperationType) {
    TYAlarmOperationType_DisarmAndDisalarm = 0,
    TYAlarmOperationType_CancelAlarm
};

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityAlarmOperationModel : NSObject

@property (nonatomic, copy) NSString *action;
@property (nonatomic, assign) TYAlarmOperationType type;

@end

NS_ASSUME_NONNULL_END
