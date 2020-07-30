//
//  TYSecurityHomePersonGeofenceViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Wei Zhang on 2020/7/21.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYSecurityHomePersonGeofenceViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartSecurityServiceKit/TuyaSmartSecurityServiceKit.h>
#import "TYSmartHomeManager.h"

@interface TYSecurityHomePersonGeofenceViewController ()

@property (nonatomic, strong) UIButton *uploadDeviceButton;
@property (nonatomic, strong) UIButton *setUsedDeviceButton;
@property (nonatomic, strong) UIButton *openGeoServiceButton;

@end

@implementation TYSecurityHomePersonGeofenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
}

- (void)initView {
    
    self.centerTitleItem.title = @"Geo Service";
    self.topBarView.centerItem = self.centerTitleItem;
    self.topBarView.leftItem = self.leftBackItem;
    
    [self.view addSubview:self.uploadDeviceButton];
    [self.uploadDeviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBarView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(48);
    }];
    
    [self.view addSubview:self.setUsedDeviceButton];
    [self.setUsedDeviceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.uploadDeviceButton.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(48);
    }];
    
    [self.view addSubview:self.openGeoServiceButton];
    [self.openGeoServiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.setUsedDeviceButton.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(48);
    }];
    
}

#pragma mark - action
- (void)uploadDeviceButtonAction:(UIButton *)button {
    
    TuyaSmartSecurityGeofenceMobileInfoModel *model = [TuyaSmartSecurityGeofenceMobileInfoModel new];
    model.deviceId = @"1111111111111111";
    model.deviceName = @"testGeofence";
    
    TuyaSmartHome *smartHome = [TYSmartHomeManager sharedInstance].currentHome;
    
    [[TuyaSmartSecurityGeofence sharedInstance] uploadMobileInfo:smartHome.homeModel.homeId deviceModel:model success:^(NSDictionary *dict) {
        NSLog(@"%@", dict);
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
}


- (void)setUsedDeviceButtonAction:(UIButton *)button {
    
    TuyaSmartHome *smartHome = [TYSmartHomeManager sharedInstance].currentHome;
    
    //get mobile list
    [[TuyaSmartSecurityGeofence sharedInstance] getMobileList:smartHome.homeModel.homeId success:^(NSArray<TuyaSmartSecurityGeofenceCommonlyUsedMobileModel *> * _Nullable mobileList) {
        
        
        if (mobileList.count) {
            
            TuyaSmartSecurityGeofenceCommonlyUsedMobileModel *firstModel = [mobileList firstObject];
            
            [[TuyaSmartSecurityGeofence sharedInstance] setCommonlyUsedMobile:smartHome.homeModel.homeId deviceId:firstModel.uuid success:^(BOOL result) {
                
                NSLog(@"%ld", result);
                
            } failure:^(NSError *error) {
                
                NSLog(@"%@", error.localizedDescription);
                
            }];
        }
    
        
    } failure:^(NSError *error) {
        
    }];
    
    
    
    
}

- (void)openGeoServiceButtonAction:(UIButton *)button {
    
    TuyaSmartHome *smartHome = [TYSmartHomeManager sharedInstance].currentHome;
    
    //switch 
    [[TuyaSmartSecurityGeofence sharedInstance] switchGeoService:smartHome.homeModel.homeId geoStatus:YES success:^(BOOL result) {
        
        self.isOpenGeoService = result;
        NSLog(@"%ld", result);
        
    } failure:^(NSError *error) {
        
        NSLog(@"%@", error.localizedDescription);
        
    }];
    
}




#pragma mark - get & set

- (UIButton *)uploadDeviceButton {
    if (!_uploadDeviceButton) {
        _uploadDeviceButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_uploadDeviceButton setTitle:@"Upload Device Info" forState:UIControlStateNormal];
        [_uploadDeviceButton setTintColor:[UIColor whiteColor]];
        _uploadDeviceButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _uploadDeviceButton.backgroundColor = [UIColor orangeColor];
        [_uploadDeviceButton addTarget:self action:@selector(uploadDeviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _uploadDeviceButton;
    
}

- (UIButton *)setUsedDeviceButton {
    if (!_setUsedDeviceButton) {
        _setUsedDeviceButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_setUsedDeviceButton setTitle:@"Set Uesed Device" forState:UIControlStateNormal];
        [_setUsedDeviceButton setTintColor:[UIColor whiteColor]];
        _setUsedDeviceButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _setUsedDeviceButton.backgroundColor = [UIColor orangeColor];
        [_setUsedDeviceButton addTarget:self action:@selector(setUsedDeviceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setUsedDeviceButton;
}

- (UIButton *)openGeoServiceButton {
    if (!_openGeoServiceButton) {
        _openGeoServiceButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openGeoServiceButton setTitle:@"Open Geo Service" forState:UIControlStateNormal];
        [_openGeoServiceButton setTintColor:[UIColor whiteColor]];
        _openGeoServiceButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _openGeoServiceButton.backgroundColor = [UIColor orangeColor];
        [_openGeoServiceButton addTarget:self action:@selector(openGeoServiceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openGeoServiceButton;
}



@end
