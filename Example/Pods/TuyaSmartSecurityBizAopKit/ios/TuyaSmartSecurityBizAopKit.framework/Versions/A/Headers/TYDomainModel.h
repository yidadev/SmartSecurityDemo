//
//  TYDomainModel.h
//  TuyaSmartPublic
//
//  Created by XuChengcheng on 16/5/3.
//  Copyright © 2016年 Tuya. All rights reserved.
//

@interface TYDomainModel : NSObject

@property(nonatomic, strong) NSString    *aispeechHttpsUrl;
@property(nonatomic, strong) NSString    *gwApiUrl;
@property(nonatomic, strong) NSString    *gwMqttUrl;
@property(nonatomic, strong) NSString    *mobileApiUrl;
@property(nonatomic, strong) NSString    *mobileMqttUrl;
@property(nonatomic, strong) NSString    *mobileMqttsUrl;
@property(nonatomic, strong) NSString    *mobileMediaMqttUrl;
@property(nonatomic, strong) NSString    *pxApiUrl;
@property(nonatomic, strong) NSString    *regionCode;


@end
