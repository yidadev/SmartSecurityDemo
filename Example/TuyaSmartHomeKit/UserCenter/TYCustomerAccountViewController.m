//
//  TYCustomerAccountViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Wei Zhang on 2020/7/18.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYCustomerAccountViewController.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import "TYLoginAndRegisterView.h"
#import "TYLoginAndRegisterUtils.h"
#import "TYSmartHomeManager.h"
#import <TuyaSmartSecurityServiceKit/TuyaSmartSecurityServiceKit.h>

@interface TYCustomerAccountViewController ()<TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYLoginAndRegisterView *rootView;
@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;

@end

@implementation TYCustomerAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.centerTitleItem.title = @"Customer Account";
    
    self.rootView = [[TYLoginAndRegisterView alloc] initWithType:TYLoginAndRegisterViewTypeUid];
    self.rootView.delegate = self;
    [self.view addSubview:self.rootView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.topBarView.leftItem = self.leftBackItem;
    [self.view addSubview:self.topBarView];
    
}

- (void)loginAndRegisterViewTrigerredAction:(TYLoginAndRegisterViewActionType)actionType {
    
    if (actionType == TYLoginAndRegisterViewActionTypeUid) {
        //三方登录
        
        if (!self.rootView.accountField.text.length ||
            !self.rootView.passwordField.text.length ||
            !self.rootView.countryCodeField.text.length) {
            self.rootView.tipsLabel.text = @"Account or password or verify code can't be nil.";
            return;
        }
        
        WEAKSELF_AT
        [[TuyaSmartSecurityUser sharedInstance]
         loginOrRegisterWithCountryCode:self.rootView.countryCodeField.text
         uid:self.rootView.accountField.text
         password:self.rootView.passwordField.text
         success:^(id result) {
            
            weakSelf_AT.rootView.tipsLabel.text = @"Register or login success.";
            [weakSelf_AT getSecurityService];
            
        } failure:^(NSError *error) {
            weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
        }];
        
    }
}


- (void)getSecurityService {
    
    WEAKSELF_AT
    [[TuyaSmartSecurityUser sharedInstance]
     getServiceInfoWithSuccess:^(TuyaSmartSecurityUserServiceModel * _Nullable userServiceModel) {
        
        if (userServiceModel.isBind) {
            weakSelf_AT.rootView.tipsLabel.text = @"bind dealer information.";
            [weakSelf_AT loadHomeData];
            return;
        }
        //need to bind dealer
        UIAlertView *alert = [UIAlertView bk_alertViewWithTitle:@"Attention" message:@"Need to bind Dealer information." ];
        [alert bk_setCancelButtonWithTitle:@"OK" handler:NULL];
        [alert show];
        
    } failure:^(NSError *error) {
        
    }];
    
}


- (void)loadHomeData {
    
    if (![TuyaSmartUser sharedInstance].isLogin) return;
    [TYCameraCloudServicePanelSDK userStateChanged];
    WEAKSELF_AT
    [self.homeManager getHomeListWithSuccess:^(NSArray<TuyaSmartHomeModel *> *homes) {
        
        if (homes.count > 0) {
            // If homes are already exist, choose the first one as current home.
            TuyaSmartHomeModel *model = [homes firstObject];
            TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:model.homeId];
            [TYSmartHomeManager sharedInstance].currentHome = home;
            
        } else {
            // Or else, add a default home named "hangzhou's home" and choose it as current home.
            [weakSelf_AT.homeManager addHomeWithName:@"hangzhou's home" geoName:@"hangzhou" rooms:@[@"bedroom"] latitude:0 longitude:0 success:^(long long homeId) {
                TuyaSmartHome *home = [TuyaSmartHome homeWithHomeId:homeId];
                [TYSmartHomeManager sharedInstance].currentHome = home;
            } failure:^(NSError *error) {
                //Do fail action.
            }];
        }
    } failure:^(NSError *error) {
        //Do fail action.
    }];
}


#pragma mark - Getters

- (TuyaSmartHomeManager *)homeManager {
    if (!_homeManager) {
        _homeManager = [TuyaSmartHomeManager new];
    }
    return _homeManager;
}

@end
