//
//  TYHomeCacheService.h
//  TuyaSmartKit
//
//  Created by 冯晓 on 2017/12/22.
//  Copyright © 2017年 Tuya. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TuyaSmartHomeModel.h"
#import <TuyaSmartDeviceKit/TuyaSmartDeviceKit.h>
//#import "TuyaSmartHomeMemberModel.h"
//#import "TuyaSmartRoomModel.h"
//#import "TuyaSmartDeviceModel.h"
//#import "TuyaSmartGroupModel.h"
//#import "TuyaSmartBleMeshModel.h"

#define kDefaultDocHomePath        @"home"
#define kDefaultDocHomeCacheListPath    @"home/list"
#define kDefaultDocHomeCacheDetailPath    @"home/detail"

#define kDefaultHomeDetailCacheDataNew  @"kDefaultHomeDetailCacheDataNew"
#define kDefaultHomeListCacheDataNew    @"kDefaultHomeListCacheDataNew"

#define kDefaultLastAppVersion   @"kDefaultLastAppVersion"

/*
 bizType及parentType的值如下：
 
 LOCATION(2, "位置(家或办公室)"),
 MESH(3, "mesh"),
 ROOM(4, "房间"),
 GROUP(5, "群组"),
 DEVICE(6, "设备")
 */

typedef enum : NSUInteger {
    TY_BIZTYPE_LOCATION = 2,
    TY_BIZTYPE_MESH,
    TY_BIZTYPE_ROOM,
    TY_BIZTYPE_GROUP,
    TY_BIZTYPE_DEVICE,
} TY_BIZTYPE_Model;


@interface TYHomeCacheService : NSObject

TYSDK_SINGLETON;

//初始化加载缓存
- (void)clearLocalCache;

- (void)initLocalCacheData;

- (void)reset;

#pragma mark - Update Cache

- (void)updateHomesList:(NSArray <TuyaSmartHomeModel *> *)homeList;

- (void)addHomeInfo:(TuyaSmartHomeModel *)homeInfo;

- (void)updateHomeInfo:(TuyaSmartHomeModel *)homeInfo;

- (void)updateRoomList:(NSArray <TuyaSmartRoomModel *> *)roomList homeId:(long long)homeId;

- (void)updateDeviceList:(NSArray <TuyaSmartDeviceModel *> *)deviceList homeId:(long long)homeId;

- (void)updateGroupList:(NSArray <TuyaSmartGroupModel *> *)groupList homeId:(long long)homeId;

- (void)updateGroupProductList:(NSArray <NSDictionary *> *)groupProductList;

- (void)updateRelations:(NSDictionary *)relations homeId:(long long)homeId;

/** 更新设备或群组的显示顺序 */
- (void)updateDeviceOrGroupOrder:(NSArray *)orderList homeId:(long long)homeId;

- (void)addGroupModel:(TuyaSmartGroupModel *)groupModel homeId:(long long)homeId;

- (void)updateGroupModel:(TuyaSmartGroupModel *)groupModel;

- (void)addDeviceModel:(TuyaSmartDeviceModel *)deviceModel homeId:(long long)homeId;

- (void)addDeviceModelList:(NSArray<TuyaSmartDeviceModel *> *)deviceModelList homeId:(long long)homeId;

- (void)updateRoomModel:(TuyaSmartRoomModel *)roomModel homeId:(long long)homeId;

- (void)addRoomGroupRelationWithGroupId:(long long)groupId homeId:(long long)homeId roomId:(long long)roomId;

- (void)addRoomDeviceRelationWithDeviceId:(NSString *)deviceId homeId:(long long)homeId roomId:(long long)roomId;

- (void)updateDeviceGroupRelationWithDeviceList:(NSArray *)deviceList groupId:(long long)groupId;

//zigbee创建群组的update信息不能乱发，不然面板会崩溃
- (void)updateDeviceGroupRelationWithDeviceList:(NSArray *)deviceList groupId:(long long)groupId shouldNotify:(BOOL)shouldNotify;

// 更新room下的设备，群组信息
- (void)updateRoomRelationWithDeviceGroupList:(NSArray *)deviceGroupList roomId:(long long)roomId;

- (void)updateSharedDeviceList:(NSArray <TuyaSmartDeviceModel *> *)deviceList;

- (void)updateSharedGroupList:(NSArray <TuyaSmartGroupModel *> *)groupList;

- (void)updateMeshModel:(TuyaSmartBleMeshModel *)meshModel;

- (NSInteger)getMeshGroupAddressFromLocalWithMeshId:(NSString *)meshId;
- (NSInteger)getMeshGroupCountFromLocalWithMeshId:(NSString *)meshId;
- (void)removeMeshGroupWithAddress:(NSInteger)address meshId:(NSString *)meshId;

#pragma mark - Remove Cache

- (void)removeHome:(long long)homeId;

- (void)removeDeviceWithDevId:(NSString *)devId;

- (void)removeGroupWithGroupId:(long long)groupId;

- (void)removeRoomDeviceRelationWithDevId:(NSString *)devId roomId:(long long)roomId;

- (void)removeRoomGroupRelationWithGroupId:(long long)groupId roomId:(long long)roomId;

- (void)removeRoom:(long long)homeId roomId:(long long)roomId;

#pragma mark - Get List Cache

- (NSArray <TuyaSmartHomeModel *> *)getHomeList;

- (NSArray <TuyaSmartRoomModel *> *)getRoomListWithHomeId:(long long)homeId;

- (NSArray <TuyaSmartDeviceModel *> *)getDeviceListWithHomeId:(long long)homeId;

- (NSArray <TuyaSmartGroupModel *> *)getGroupListWithHomeId:(long long)homeId;

- (NSArray <TuyaSmartDeviceModel *> *)getDeviceListWithRoomId:(long long)roomId;

- (NSArray <TuyaSmartGroupModel *> *)getGroupListWithRoomId:(long long)roomId;

- (NSArray <TuyaSmartDeviceModel *> *)getDeviceListWithGroupId:(long long)groupId;

- (NSArray <TuyaSmartDeviceModel *> *)getAllDeviceList;

- (NSArray <TuyaSmartGroupModel *> *)getAllGroupList;

- (NSArray <TuyaSmartDeviceModel *> *)getSharedDeviceList;

- (NSArray <TuyaSmartGroupModel *> *)getSharedGroupList;

- (NSArray <TuyaSmartBleMeshModel *> *)getAllMeshList;

- (long long)getRoomIdWithDevId:(NSString *)devId;

- (long long)getRoomIdWithGroupId:(long long)groupId;

- (long long)getHomeIdWithDevId:(NSString *)devId;

- (long long)getHomeIdWithGroupId:(long long)groupId;

#pragma mark - Get Cache

- (TuyaSmartHomeModel *)getHomeInfoWithHomeId:(long long)homeId;

- (TuyaSmartRoomModel *)getRoomInfoWithHomeId:(long long)homeId roomId:(long long)roomId;

- (TuyaSmartDeviceModel *)getDeviceInfoWithDevId:(NSString *)devId;

- (TuyaSmartGroupModel *)getGroupInfoWithGroupId:(long long)groupId;

- (TuyaSmartBleMeshModel *)getMeshModelWithMeshId:(NSString *)meshId;

- (TuyaSmartBleMeshModel *)getMeshModelWithHomeId:(long long)homeId isSigMesh:(BOOL)isSigMesh;

- (NSDictionary *)getGroupProductWithProductId:(NSString *)productId;

#pragma mark - subsribe

#if TARGET_OS_IOS

- (void)subscribeAllTopic;

#endif

@end
