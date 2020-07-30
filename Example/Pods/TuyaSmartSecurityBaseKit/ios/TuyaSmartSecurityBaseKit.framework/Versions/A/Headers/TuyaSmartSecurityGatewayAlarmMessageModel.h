//
//  TYGatewayAlarmMsgModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TYAlarmDetailModel;

typedef NS_ENUM(NSInteger,AlarmMessageState){
    AlarmMessageStateOpen = 1,
    AlarmMessageStateCancel = 2,
    AlarmMessageStateDone = 3,
    AlarmMessageStateMC = 4,
    AlarmMessageStateDealed = 5
};

typedef NS_ENUM(NSUInteger, TYSecurityAlarmType) {
    TYSecurityAlarmType_FireSmoke,
    TYSecurityAlarmType_FireCO,
    TYSecurityAlarmType_WaterLeak,
    TYSecurityAlarmType_SOS,
    TYSecurityAlarmType_Default,
    TYSecurityAlarmType_Gas,
    TYSecurityAlarmType_Undefine,
};
/*
 resp:
 [{
         "alarmId":"gm1558418301177c69mA",
         "state":1, //1-open,2-cancel,3-done,4-monitoring center,5-monitoring dealed
         "homeId":"1463006",
         "msgId":"sm1558418301177c69mA",
         "msgContent":"this is a test message: camera",
         "msgTitle":"test",
         "productType":"camera",
         "productId":"kU",
         "deviceIds":[
             "sm1558418301177c69mA","sm1558418301177c69mB"
         ]
         "monitoringDeadline":1558418301181
 }]
 */
@interface TuyaSmartSecurityGatewayAlarmMessageModel : NSObject

@property (nonatomic, copy) NSString *alarmId;
@property (nonatomic, copy) NSString *msgId;
@property (nonatomic, copy) NSString *msgContent;
@property (nonatomic, copy) NSString *msgTitle;
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, strong) NSArray<NSString *> *deviceIds;
@property (nonatomic, copy) NSString *monitoringDeadline;
@property(nonatomic, copy) NSString *type;//报警类型
@property (nonatomic, assign) TYSecurityAlarmType alarmType;//报警类型枚举值
@property(nonatomic, copy) NSString *typeDesc;//报警类型描述
@property(nonatomic, copy) NSString *gmtCreate;
@property(nonatomic, assign) AlarmMessageState state;//报警状态

@property(nonatomic, strong) NSMutableArray<TYAlarmDetailModel *> *details;
@property(nonatomic, assign) NSInteger alarmLeavel;

@end

@interface TYAlarmDetailModel : NSObject

@property(nonatomic, copy) NSString *roomName;
@property(nonatomic, copy) NSString *deviceName;
@property(nonatomic, copy) NSString *timeString;

@end

NS_ASSUME_NONNULL_END
