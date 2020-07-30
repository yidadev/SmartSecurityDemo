//
//  TuyaSecurityMessageKitDefinition.h
//  Pods
//
//  Created by MokZF on 2020/5/12.
//

#ifndef TuyaSecurityMessageKitDefinition_h
#define TuyaSecurityMessageKitDefinition_h

typedef NS_ENUM(NSInteger,TYSecurityArmedMsgType) {
    TYSecurityArmedMsgTypeAll = 0,//所有消息 / All Messages
    TYSecurityArmedMsgActivityType = 1,//activity消息 / activity Message
    TYSecurityArmedMsgNotificationType = 2,//Notification消息 / Notification Message
    
};

typedef NS_ENUM(NSInteger,TYSecurityMessageDealType) {
    TYSecurityMessageDealTypeUnDeal = 0,//未处理(0、1均代表改消息未处理) / Undisposed Message
    TYSecurityMessageDealTypeUnDealToo = 1,//未处理 / Undisposed Message
    TYSecurityMessageDealTypeUnlock = 2,//解除报警 / Cancel The Alarm Message
    TYSecurityMessageDealTypeConnected = 3,//已联系紧急联系人 /  Emergency Contact
    TYSecurityMessageDealTypeCallSercice = 4//已呼叫安防服务 /  Call Security Services
    
};

typedef NS_ENUM(NSInteger,TYSecurityMessageFavoriteState) {
    TYSecurityMessageRemoveFavorite = 0,//取消收藏  / Cancel Collection
    TYSecurityMessageSetFavorite = 1//收藏 / Collection
};

#endif /* TuyaSecurityMessageKitDefinition_h */
