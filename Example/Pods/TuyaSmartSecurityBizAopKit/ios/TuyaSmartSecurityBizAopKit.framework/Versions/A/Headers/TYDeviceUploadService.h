//
//  TYDeviceUploadService.h
//  Pods
//
//  Created by XuChengcheng on 2019/5/24.
//

//#import "TuyaSmartRequest.h"
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TYDeviceUploadService : TuyaSmartRequest

- (void)uploadToServe:(NSString *_Nullable)fileName
                  biz:(NSString *_Nullable)biz
                 type:(NSString *_Nullable)type
                 data:(NSData *_Nullable)data
              success:(nullable void (^)(NSString * _Nullable cloudKey))success
              failure:(TYFailureError _Nullable )failure;

@end

NS_ASSUME_NONNULL_END
