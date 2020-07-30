//
//  TYGeoHomesModel.h
//  TYKABaseComponents
//
//  Created by MokZF on 2019/9/2.
//

#import <Foundation/Foundation.h>

/*
 enable = 1;
 fenceData = "{\"lon\":\"1233\",\"radius\":\"100\",\"title\":\"test\",\"lat\":\"5646\"}";
 fenceId = "d91f5b11-db78-11e9-ad55-0242ee690017";
 gmtCreate = 1568964769678;
 gmtModified = 1569209806818;
 homeId = 8784083;
 lat = 5646;
 lon = 1233;
 radius = 100;
 title = test;
 */
NS_ASSUME_NONNULL_BEGIN


@interface TuyaSecurityGeofenceRegionItemModel : NSObject


/// 纬度 / latitude
@property(nonatomic, assign) double lat;

/// 经度 / longitude
@property(nonatomic, assign) double lon;

/// 是否设置过家庭位置 / Whether the family location has been set
@property(nonatomic, assign) BOOL isSettedLocation;

/// 半径 / radius
@property(nonatomic, assign) double radius;

/// 位置名称 / Location's name
@property(nonatomic, copy) NSString *title;

@end

@interface TuyaSmartSecurityGeofenceRegionDataModel : NSObject


/// 地理围栏唯一识别ID / Geofence Unique identification ID
@property(nonatomic, copy) NSString *fenceId;

/// 家庭Id / Home ID
@property(nonatomic, assign) long long homeId;

/// 创建时间 / Create Time
@property(nonatomic, assign) NSTimeInterval gmtCreate;

/// 修改时间 / Modify Time
@property(nonatomic, assign) NSTimeInterval gmtModified;

/// 是否参与地理围栏 / Whether to join in Geofenc
@property(nonatomic, assign) NSInteger enable;

/// 地理围栏位置数据 / Geofence Region Data
@property(nonatomic, strong) TuyaSecurityGeofenceRegionItemModel *data;
@end

NS_ASSUME_NONNULL_END
