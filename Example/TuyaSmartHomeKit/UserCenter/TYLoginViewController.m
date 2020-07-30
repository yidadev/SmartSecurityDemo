//
//  TYLoginViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by 盖剑秋 on 2018/11/5.
//  Copyright © 2018 xuchengcheng. All rights reserved.
//

#import "TYLoginViewController.h"
#import "TYLoginAndRegisterView.h"
#import "TYLoginAndRegisterUtils.h"
#import "TYSmartHomeManager.h"
#import <TuyaSmartSecurityServiceKit/TuyaSmartSecurityServiceKit.h>

@interface TYLoginViewController () <TYLoginAndRegisterViewDelegate>

@property (nonatomic, strong) TYLoginAndRegisterView *rootView;
@property (nonatomic, strong) TYRegisterViewController *registerViewController;
@property (nonatomic, strong) TuyaSmartHomeManager *homeManager;

@end

/*
 doc link
 
 en:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/en/resource/User.html#user-management
 zh-hans:https://tuyainc.github.io/tuyasmart_home_ios_sdk_doc/zh-hans/resource/User.html#%E7%94%A8%E6%88%B7%E7%AE%A1%E7%90%86
 */

@implementation TYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTopBarView];
    self.rootView = [[TYLoginAndRegisterView alloc] initWithType:TYLoginAndRegisterViewTypeLogin];
    self.rootView.delegate = self;
    [self.view addSubview:self.rootView];
    self.view.backgroundColor = [UIColor whiteColor];
    // session invalid
    [self getSecurityService];
    //Add this function or not, by yourself.
    [self autoFillCountryCodeWithDeviceInfo];
    
    
    self.rootView.accountField.text = @"guoqudemo@bccto.me";
    self.rootView.countryCodeField.text = @"86";
    self.rootView.passwordField.text = @"hs123456";
    
    
}

- (void)initTopBarView {
    
    self.topBarView.leftItem = self.leftBackItem;
    self.centerTitleItem.title = @"Login";
    self.topBarView.centerItem = self.centerTitleItem;
    self.rightTitleItem.title = @"Register";
    self.topBarView.rightItem = self.rightTitleItem;

    [self.view addSubview:self.topBarView];
}

- (void)rightBtnAction {
    
    self.registerViewController = [TYRegisterViewController new];
    
    WEAKSELF_AT
    [self.registerViewController setRegisterResultBlock:^(NSString * _Nonnull resultInfoStr) {
        weakSelf_AT.rootView.tipsLabel.text = resultInfoStr;
        [weakSelf_AT getSecurityService];
    }];
    [self.navigationController pushViewController:self.registerViewController animated:YES];
}

- (void)getSecurityService {
    
    if (![TuyaSmartUser sharedInstance].isLogin) return;
    
    WEAKSELF_AT
    [[TuyaSmartSecurityUser sharedInstance] getServiceInfoWithSuccess:^(TuyaSmartSecurityUserServiceModel * _Nullable userServiceModel) {
    
        if (userServiceModel.isBind) {
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

#pragma mark - Actions.

- (void)loginAndRegisterViewTrigerredAction:(TYLoginAndRegisterViewActionType)actionType {
    if (actionType == TYLoginAndRegisterViewActionTypeLogin) {
        [self passwordLogin];
    }
}

- (void)passwordLogin {
    [self.view endEditing:YES];
    if (!self.rootView.accountField.text.length) {
        self.rootView.tipsLabel.text = @"account field can't be nil.";
        return;
    }
    
    if (!self.rootView.countryCodeField.text.length) {
        self.rootView.tipsLabel.text = @"Country code is essential.";
        return;
    }
    
    if (self.rootView.passwordField.text.length < 6) {
        self.rootView.tipsLabel.text = @"Invalid password formmat.";
        return;
    }
    if ([TYLoginAndRegisterUtils isValidateEmail:self.rootView.accountField.text]) {
        [self loginWithEmailAndPassword];
    } else {
        [self loginWithPhoneNumberAndPassword];
    }
}


/**
 @brief Login with email address and password.
 */
- (void)loginWithEmailAndPassword {
    
    NSString *countryCode   = self.rootView.countryCodeField.text;
    NSString *email         = self.rootView.accountField.text;
    NSString *password      = self.rootView.passwordField.text;
    
    [self showProgressView];
    
    WEAKSELF_AT
    [[TuyaSmartUser sharedInstance] loginByEmail:countryCode email:email password:password success:^{
        weakSelf_AT.rootView.tipsLabel.text = @"Login with email and password success！";
        [weakSelf_AT hideProgressView];
        [weakSelf_AT getSecurityService];
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
        [weakSelf_AT hideProgressView];
    }];
}


/**
 @brief Login with phone number and password.
 */
- (void)loginWithPhoneNumberAndPassword {
    NSString *countryCode   = self.rootView.countryCodeField.text;
    NSString *phoneNumber   = self.rootView.accountField.text;
    NSString *password      = self.rootView.passwordField.text;
    
    [self showProgressView];
    WEAKSELF_AT
    
    [[TuyaSmartUser sharedInstance] loginByPhone:countryCode phoneNumber:phoneNumber password:password success:^{
        weakSelf_AT.rootView.tipsLabel.text = @"Login with phone number and password success！";
        [weakSelf_AT hideProgressView];
        [weakSelf_AT getSecurityService];
    } failure:^(NSError *error) {
        weakSelf_AT.rootView.tipsLabel.text = error.localizedDescription;
        [weakSelf_AT hideProgressView];
    }];
}

/**
 @brief Log out action.
 */
- (void)autoFillCountryCodeWithDeviceInfo {
    
    NSString *code = [TYLoginAndRegisterUtils getDefaultCountryCode];
    if (code.length) {
        self.rootView.countryCodeField.text = code;
    }
}

#pragma mark - Getters

- (TuyaSmartHomeManager *)homeManager {
    if (!_homeManager) {
        _homeManager = [TuyaSmartHomeManager new];
    }
    return _homeManager;
}
@end
