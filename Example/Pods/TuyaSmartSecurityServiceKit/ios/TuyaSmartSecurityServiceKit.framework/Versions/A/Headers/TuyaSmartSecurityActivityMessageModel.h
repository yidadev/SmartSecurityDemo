//
//  TYActivityMsgModel.h
//  AFNetworking
//
//  Created by 浩天 on 2019/3/18.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,TYActivityMsgType) {
    TYActivityMsgTypeNormal = 0,//普通消息
    TYActivityMsgTypeWarning = 1//预警消息
};

NS_ASSUME_NONNULL_BEGIN


@interface TuyaSmartSecurityActivityMessageModel : NSObject

// 消息ID / Message ID
@property (nonatomic, copy) NSString *msgId;
// 消息标题 / Message Type
@property (nonatomic, copy) NSString *msgTypeContent;
// 消息内容 / Message content
@property (nonatomic, copy) NSString *msgContent;

@property (nonatomic, assign) NSTimeInterval gmtCreate;//时间(秒)
@property (nonatomic, copy) NSString *icon;//图标
@property (nonatomic, copy) NSString *msgSrcId;//消息触发源ID，可能是设备ID，可能是场景ID，可能是⽤用户ID等
@property (nonatomic, copy) NSString *cameraDevId;//触发摄像头事件的时候，会触发
@property (nonatomic, copy) NSString *deviceId;//设备id
@property (nonatomic, copy) NSString *attachPics;//附加图⽚
@property (nonatomic, copy) NSString *actionURL;//跳转地址
@property (nonatomic, copy) NSString *dateTime;//时间
@property (nonatomic, copy) NSString *locationId;
@property (nonatomic, copy) NSString *msgTitle;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *deviceName;

@property(nonatomic, assign) NSInteger msgType;
//安防系统消息专有消息字段
@property (nonatomic, assign) TYActivityMsgType level;//-普通消息，1-预警消息
@property (nonatomic, assign) NSInteger hasVedio;//是否有关联录像，0-没有，1-有
@property (nonatomic, assign) NSInteger readStatus;//消息已读状态，0-未读，1-已读
@property (nonatomic, assign) NSInteger isAlarm;//是否是报警消息
@property (nonatomic, assign) NSInteger state;//(0、1未处理，2、3、4已处理)
@property (nonatomic, assign) NSInteger msgCategory;//消息类型(1：camera  2:security 3:other)
@property (nonatomic, assign) NSInteger attachType;//用于判断是图片还是录像(1:pic、2:video)
@property (nonatomic, assign) BOOL favorite;//该消息是否被收藏


//标记是否选中
@property (nonatomic, assign) BOOL selected;
//
@property (nonatomic, copy) NSString *p_string;

@end

NS_ASSUME_NONNULL_END
