//
//  TuyaSmartScenePreConditionModel.h
//  TYSmartSceneModule
//
//  Created by leon on 2018/11/14.
//

/*
 * 自动化场景前置条件，例如“生效时间段”条件
 */

#import <Foundation/Foundation.h>

@interface TuyaSmartScenePreConditionModel : NSObject<NSCoding>

/**
 * 场景id
 * scene's Id
 */
@property (nonatomic, copy) NSString *scenarioId;

/**
 * 条件id
 * condition's Id
 */
@property (nonatomic, copy) NSString *conditionId;

/**
 * 前置条件类型
 * "timeCheck" 生效时间段
 *
 * precondition type
 * "timeCheck", valid time period
 */
@property (nonatomic, copy) NSString *condType;


/**
 * 前置条件参数字典
 * "timeInterval":"custom",           //时间区间：custom|daytime|night|allDay
 * "timeZoneId": "Asia/Shanghai",     //时区id必传
 * "loops" : "1111111",               //每一位分别代表周日到周一的七天，1表示生效
 * "start" : "20:30",                 //type为timeCheck且timeInterval为custom生效
 * "end"   : "06:30",                 //type为timeCheck且timeInterval为custom生效
 * "cityId" : "793409534348627968",   //城市ID
 * "cityName" : "杭州市"               //城市名称，服务端不做任何处理保存，并在查询时返回
 *
 * precondition's exepression
 * "timeInterval":"custom",           //time period：custom|daytime|night|allDay
 * "timeZoneId": "Asia/Shanghai",     //needed, timezone Id
 * "loops" : "1111111",               //each bit representing from sunday to saturday, "1" for valid.
 * "start" : "20:30",                 //type is timeCheck and timeInterval is custom, this property will be useful.
 * "end"   : "06:30",                 //type is timeCheck and timeInterval is custom, this property will be useful.
 * "cityId" : "793409534348627968",   //city Id
 * "cityName" : "杭州市"               //city name, this property is only saved in the cloud, will not be changed by cloud.
 */
@property (nonatomic, strong) NSDictionary *expr;

@end

