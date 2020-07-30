//
//  TYEventLinkCameraGroupModel.h
//  BlocksKit
//
//  Created by Wei Zhang on 2019/10/23.
//

#import <Foundation/Foundation.h>

@class TuyaSmartSecurityEventRecordingBindCameraModel;

NS_ASSUME_NONNULL_BEGIN

@interface TuyaSmartSecurityEventLinkCameraGroupModel : NSObject


/// 房间名称 / Room Name
@property (nonatomic, copy) NSString *roomName;

/// 摄像头列表 / Camera List
@property (nonatomic, strong) NSArray<TuyaSmartSecurityEventRecordingBindCameraModel *> *cameraDeviceList;

@end

NS_ASSUME_NONNULL_END
