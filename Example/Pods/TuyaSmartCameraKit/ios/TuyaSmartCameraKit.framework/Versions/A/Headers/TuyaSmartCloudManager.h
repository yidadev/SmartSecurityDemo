//
//  TuyaSmartCloudManager.h
//  TuyaSmartCamera_Example
//
//  Created by 傅浪 on 2019/3/28.
//  Copyright © 2019 fulang@tuya.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TuyaSmartCloudModels.h"
#import <CoreMedia/CoreMedia.h>
#import <TuyaSmartCameraBase/TuyaSmartCameraBase.h>

typedef NS_ENUM(NSUInteger, TuyaSmartCloudState) {
    TuyaSmartCloudStateNoService,       // [^en]no cloud service[$en] [^zh]没有云服务[$zh]
    TuyaSmartCloudStateNoData,          // [^en]in cloud service but no data[$en] [^zh]云服务中没有数据[$zh]
    TuyaSmartCloudStateValidData,       // [^en]in cloud service and has video data[$en] [^zh]云服务中存在视频数据[$zh]
    TuyaSmartCloudStateExpiredNoData,   // [^en]cloud service has being expired and no data[$en] [^zh]云服务已过期并且没有数据[$zh]
    TuyaSmartCloudStateExpiredData,     // [^en]cloud service has being expired but has video data[$en] [^zh]云服务已经过期但存在视频数据[$zh]
    TuyaSmartCloudStateLoadFailed       // [^en]load cloud data failed[$en] [^zh]加载云端数据失败[$zh]
};

@class TuyaSmartCloudManager;
@protocol TuyaSmartCloudManagerDelegate <NSObject>

@optional

- (void)cloudManager:(TuyaSmartCloudManager *)cloudManager didReceivedFrame:(CMSampleBufferRef)frameBuffer videoFrameInfo:(TuyaSmartVideoFrameInfo)frameInfo;

- (void)cloudManager:(TuyaSmartCloudManager *)player  didReceivedAudioFrameInfo:(TuyaSmartAudioFrameInfo)frameInfo;

@end

@interface TuyaSmartCloudManager : NSObject

@property (nonatomic, strong) NSString *devId;

@property (nonatomic, assign) BOOL autoRender;

@property (nonatomic, strong, readonly) NSArray<TuyaSmartCloudDayModel *> *cloudDays;

@property (nonatomic, weak) id<TuyaSmartCloudManagerDelegate> delegate;

@property (nonatomic, strong) NSString *encryptKey;

@property (nonatomic, strong) NSString *authJson;

- (instancetype)initWithDeviceId:(NSString *)devId;

/**
 [^en]
 config cloud data tags. if you want reqeust cloud data for service api by yourself instead of use "loadCloudData:", you shoud call this method before play cloud video.
 [$en]

 [^zh]
 配置云端数据标签。如果您想要自己调用api代替使用“loadCloudData”请求云端数据，您应该再播放云端视频之前调用此方法。
 [$zh]

 @param jsonCloudDataTags [^en]cloud data tags[$en] [^zh]云数据标签[$zh]
 */
- (void)configCloudDataTags:(NSString *)jsonCloudDataTags;

- (NSString *)configCloudDataTagsV2:(NSString *)jsonCloudDataTags;

/**
 [^en]
 load cloud data
 [$en]

 [^zh]
 加载云端数据
 [$zh]
 @param complete callback
 */
- (void)loadCloudData:(void(^)(TuyaSmartCloudState state))complete;

/**
 [^en]
 reload cloud days
 [$en]

 [^zh]
 重新加载云端日期数据
 [$zh]
 
 @param complete callback
 */
- (void)reLoadCloudDays:(void(^)(NSArray<TuyaSmartCloudDayModel *> *cloudDays))complete;

/**
 [^en]
 get time event of the day
 [$en]

 [^zh]
 获取某天的时间片数据
 [$zh]
 @param cloudDay [^en]target day[$en] [^zh]目标日期[$zh]
 @param offset [^en]event index offset[$en] [^zh]事件索引偏移量[$zh]
 @param limit  [^en]event count limit, -1 is get all[$en] [^zh]事件数量限制，-1代表所有[$zh]
 @param success success callback
 @param failure failure callback
 */
- (void)timeEventsWithCloudDay:(TuyaSmartCloudDayModel *)cloudDay
                        offset:(int)offset
                         limit:(int)limit
                       success:(void(^)(NSArray<TuyaSmartCloudTimeEventModel *> * timeEvents))success
                       failure:(void(^)(NSError * error))failure;

/**
 [^en]
 get time line data of the day
 [$en]

 [^zh]
 获取某天的时间轴数据
 [$zh]
 @param cloudDay [^en]target day[$en] [^zh]目标日期[$zh]
 @param success success callback
 @param failure failure callback
 */
- (void)timeLineWithCloudDay:(TuyaSmartCloudDayModel *)cloudDay
                     success:(void(^)(NSArray<TuyaSmartCloudTimePieceModel *> * timePieces))success
                     failure:(void(^)(NSError * error))failure;


/**
 [^en]
 play cloud video
 [$en]

 [^zh]
 播放云端视频
 [$zh]

 @param startTime [^en]start time[$en] [^zh]开始时间[$zh]
 @param endTime [^en]end time. cloud video will auto continue util the last video finished in the day[$en] [^zh]结束时间，云视频将会自动继续播放直到当天最后一个视频[$zh]
 @param isEvent [^en]YES is the time event, NO is the time line video.[$en] [^zh]YES 是时间片事件，NO是时间轴视频[$zh]
 @param responseCallback [^en]errCode 0 is success, negative is failed.[$en] [^zh]errorCode 0 是成功，负数为失败[$zh]
 @param finishedCallback [^en]video is finished[$en] [^zh]视频已经结束[$zh]
 */
- (void)playCloudVideoWithStartTime:(long)startTime
                            endTime:(long)endTime
                            isEvent:(BOOL)isEvent
                         onResponse:(void(^)(int errCode))responseCallback
                         onFinished:(void(^)(int errCode))finishedCallback;


/**
 [^en]
 pause play
 [$en]

 [^zh]
 暂停播放
 [$zh]

 @return [^en]errCode 0 is success[$en] [^zh]errCode 0 为成功[$zh]
 */
- (int)pausePlayCloudVideo;


/**
 [^en]
 resume play
 [$en]

 [^zh]
 恢复播放
 [$zh]

 @return [^en]errCode 0 is success[$en] [^zh]errCode 0 为成功[$zh]
 */
- (int)resumePlayCloudVideo;


/**
 [^en]
 stop play
 [$en]

 [^zh]
 停止播放
 [$zh]

 @return [^en]errCode 0 is success[$en] [^zh]errCode 0 为成功[$zh]
 */
- (int)stopPlayCloudVideo;

/**
 [^en]
 video frame render view
 [$en]

 [^zh]
 视频帧渲染视图
 [$zh]
 
 @return render view
 */
- (UIView<TuyaSmartVideoViewType> *)videoView;

/**
 [^en]
 set mute.
 [$en]

 [^zh]
 设置静音
 [$zh]
 @param mute [^en]mute sound.[$en] [^zh]是否静音[$zh]
 @param success success call back.
 @param failure failed call back.
 */
- (void)enableMute:(BOOL)mute success:(void(^)(void))success failure:(void (^)(NSError * error))failure;

/**
 [^en]
 get mute state.
 [$en]

 [^zh]
 获取静音状态
 [$zh]
 @return BOOL
 */
- (BOOL)isMuted;

/**
 [^en]
 start record.
 [$en]

 [^zh]
 开始录制
 [$zh]
 */
- (void)startRecord;

/**
 [^en]
 start record and the video will save to the file path.
 [$en]

 [^zh]
 开始录制，并且视频将会存到filepath
 [$zh]

 @param filePath [^en]save path[$en] [^zh]保存路径[$zh]
 */
- (void)startRecordAtPath:(NSString *)filePath;

/**
 [^en]
  stop record. video will save to photo album. photo asset collection name is bundle name, "[NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey]".
 [$en]

 [^zh]
 停止录制，视频将会存在系统相册。相片asset collection名称为 bundle name，"[NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey]"
 [$zh]
 @return [^en]error code. return 0 as record success.[$en] [^zh]错误码，返回0代表记录成功[$zh]
 */
- (int)stopRecord;

/**
 [^en]
 get a screenshot of th video and save it to photo album. photo asset collection name is bundle name, "[NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey]".
 [$en]

 [^zh]
 获取视频的截图并存储到系统相册。照片 asset collection 名称为 bundle name，"[NSBundle mainBundle].infoDictionary[(__bridge NSString *)kCFBundleNameKey]"
 [$zh]
 */
- (UIImage *)snapShoot;

/**
 [^en]
 get a screenshot of the video and save it to file path. if you do not need a thumbnil, set thumbnilPath nil.
 [$en]

 [^zh]
 获取视频的截图并存储到指定的目录，如果不需要缩略图，设置 thumbnilPath 为nil
 [$zh]
 */
- (UIImage *)snapShootAtPath:(NSString *)filePath thumbnilPath:(NSString *)thumbnilPath;

/**
 [^en]
 destory resource
 [$en]

 [^zh]
 销毁 资源
 [$zh]
 */
- (void)destroy;

/**
 [^en]
 play encrypt video in detect message
 [$en]

 [^zh]
 在侦测消息追踪播放加密视频
 [$zh]
 
 @param url [^en]video path[$en] [^zh]视频路径[$zh]
 @param nStartTime [^en]Start time to play[$en] [^zh]开始播放的时间[$zh]
 @param encryptKey [^en]encrypt key[$en] [^zh]加密key[$zh]
 @param callback start callback
 @param finihedCallBack finish callback

 @return error code
*/
- (int)playVideoMessageWithUrl:(NSString *)url startTime:(int)nStartTime encryptKey:(NSString *)encryptKey onResponse:(void (^)(int errCode))callback onFinish:(void (^)(int errCode))finihedCallBack;

/**
 [^en]
 pause play video
 [$en]

 [^zh]
 暂停播放视频
 [$zh]
 
 @return error code
*/
- (int)pausePlayVideoMessage;

/**
 [^en]
 resume play video
 [$en]

 [^zh]
 恢复播放视频
 [$zh]
 
 @return error code
*/
- (int)resumePlayVideoMessage;

/**
 [^en]
 stop play video
 [$en]

 [^zh]
 停止播放视频
 [$zh]
 
 @return error code
*/
- (int)stopPlayVideoMessage;

/**
 [^en]
 play encrypt audio in detect message
 [$en]

 [^zh]
 在侦测消息中播放加密音频
 [$zh]
 
 @param url [^en]audio path[$en] [^zh]音频路径[$zh]
 @param nStartTime [^en]Start time to play[$en] [^zh]开始播放时间[$zh]
 @param encryptKey [^en]encrypt key[$en] [^zh]加密key[$zh]
 @param callback start callback
 @param finihedCallBack finish callback

 @return error code
*/
- (int)playAudioMessageWithUrl:(NSString *)url startTime:(int)nStartTime encryptKey:(NSString *)encryptKey onResponse:(void (^)(int errCode))callback onFinish:(void (^)(int errCode))finihedCallBack;

/**
 [^en]
 pause play audio
 [$en]

 [^zh]
 暂停播放音频
 [$zh]
 
 @return error code
*/
- (int)pausePlayAudioMessage;

/**
 [^en]
 resume play audio
 [$en]

 [^zh]
 恢复播放音频
 [$zh]
 
 @return error code
*/
- (int)resumePlayAudioMessage;

/**
 [^en]
 stop play audio
 [$en]

 [^zh]
 停止播放音频
 [$zh]
 
 @return error code
*/
- (int)stopPlayAudioMessage;

@end

