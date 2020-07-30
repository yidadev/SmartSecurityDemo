//
//  TYSecurityHomeGeofenceViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Wei Zhang on 2020/7/21.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYSecurityHomeGeofenceViewController.h"
#import "TYSecurityHomePersonGeofenceViewController.h"
#import <Masonry/Masonry.h>
#import <TuyaSmartSecurityServiceKit/TuyaSmartSecurityServiceKit.h>
#import "TYSmartHomeManager.h"
#import <CoreLocation/CoreLocation.h>

@interface TYSecurityHomeGeofenceViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) UIButton *openGeoServiceButton;
@property (nonatomic, strong) UIButton *openGeoFenceButton;
@property (nonatomic, strong) TYSecurityHomePersonGeofenceViewController *geoServiceVC;

@property (nonatomic, strong) UITextField *lonTextFiled;
@property (nonatomic, strong) UITextField *latTextField;
@property (nonatomic, strong) UITextField *radiusTextField;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation TYSecurityHomeGeofenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self initView];
}

- (void)initView {
    
    self.centerTitleItem.title = @"Home Geofence";
    self.topBarView.centerItem = self.centerTitleItem;
    
    self.topBarView.leftItem = self.leftBackItem;
    
    [self.view addSubview:self.openGeoServiceButton];
    [self.openGeoServiceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topBarView.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
    [self.view addSubview:self.lonTextFiled];
    [self.lonTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.openGeoServiceButton.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
    [self.view addSubview:self.latTextField];
    [self.latTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lonTextFiled.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
    
    [self.view addSubview:self.radiusTextField];
    [self.radiusTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.latTextField.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
    [self.view addSubview:self.openGeoFenceButton];
    [self.openGeoFenceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.radiusTextField.mas_bottom).offset(15);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_equalTo(54);
    }];
    
}




#pragma mark - delegate

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    
    TuyaSmartHome *smartHome = [TYSmartHomeManager sharedInstance].currentHome;
    
    [[TuyaSmartSecurityGeofence sharedInstance]
     processMobileInfo:smartHome.homeModel.homeId
     geofenceHomeId:smartHome.homeModel.homeId
     deviceId:kTestDeviceUUId
     isLeving:NO
     success:^(BOOL result) {
        #ifdef DEBUG
                NSLog(@"reach the home success");
        #endif
    } failure:^(NSError *error) {
        #ifdef DEBUG
                NSLog(@"error information  %@ ", error.localizedDescription);
        #endif
    }];
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    
    TuyaSmartHome *smartHome = [TYSmartHomeManager sharedInstance].currentHome;
    
    [[TuyaSmartSecurityGeofence sharedInstance]
     processMobileInfo:smartHome.homeModel.homeId
     geofenceHomeId:smartHome.homeModel.homeId
     deviceId:kTestDeviceUUId
     isLeving:YES
     success:^(BOOL result) {
        #ifdef DEBUG
                NSLog(@"reach the home success");
        #endif
    } failure:^(NSError *error) {
        #ifdef DEBUG
                NSLog(@"error information  %@ ", error.localizedDescription);
        #endif
    }];
}

#pragma mark - action:


- (void)openGeoServiceButtonAction:(UIButton *)button {
    
    [self.navigationController pushViewController:self.geoServiceVC animated:YES];
    
}
- (void)openGeofenceButtonAction:(UIButton *)button {
    
    if (!self.geoServiceVC.isOpenGeoService) {
        
        NSLog(@"open geo service first");
        
        return;
    }

    
    TuyaSmartHome *smartHome = [TYSmartHomeManager sharedInstance].currentHome;
    
    //1.Determine that the home location cannot be empty and the home location has valid latitude and longitude
    //2. raduis is not 0, great than 200m
    //3. Device positioning must be enabled and [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways;
    
    //set home address
    [smartHome
     updateHomeInfoWithName:@"home name"
     geoName:@"city name"
     latitude:self.latTextField.text.doubleValue
     longitude:self.lonTextFiled.text.doubleValue
     success:^{
        
    } failure:^(NSError *error) {
       
    }];
    
    //set location and raduis
    TuyaSmartSecurityGeofenceRegionRecordModel *recordInfoModel = [[TuyaSmartSecurityGeofenceRegionRecordModel alloc] init];
    recordInfoModel.lon = [NSString stringWithFormat:@"%.10lf",self.latTextField.text.doubleValue];
    recordInfoModel.lat = [NSString stringWithFormat:@"%.10lf",self.lonTextFiled.text.doubleValue];
    recordInfoModel.radius = [NSString stringWithFormat:@"%.10lf",ceil(self.radiusTextField.text.doubleValue)];
    recordInfoModel.title = @"title";
    
    [[TuyaSmartSecurityGeofence sharedInstance]
     recordInitialDeviceStatus:smartHome.homeModel.homeId
     recordModel:recordInfoModel
     success:^(BOOL result) {
       
    } failure:^(NSError *error) {
        
        
    }];
    
    
    //open Home Geofence
    [[TuyaSmartSecurityGeofence sharedInstance] switchGeoFence:smartHome.homeModel.homeId fenceStatus:YES
                                                       success:^(BOOL result) {
        NSLog(@"Open geo fence");
    
        
        // get All Region Data

        WEAKSELF_AT
        [[TuyaSmartSecurityGeofence sharedInstance]
         getAllHomeGeoFence:smartHome.homeModel.homeId
         deviceId:kTestDeviceUUId
         success:^(NSArray<TuyaSmartSecurityGeofenceRegionDataModel *> *geofenceList) {
            
            
            //enter service
            NSSet *regions = [self.locationManager monitoredRegions];
            
            //stop all
            for (CLCircularRegion *rg in regions) {
                [weakSelf_AT.locationManager stopMonitoringForRegion:rg];
            }
            
            //enter apple location services
            for (TuyaSmartSecurityGeofenceRegionDataModel *dataModel in geofenceList) {
                
                NSSet *regions = [self.locationManager monitoredRegions];
                
                CLCircularRegion *region;
                if (dataModel && dataModel.enable) {
                   CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(dataModel.data.lat, dataModel.data.lon);
                   region = [[CLCircularRegion alloc] initWithCenter:coordinate
                                                              radius:dataModel.data.radius
                                                          identifier:@"myapp"];
                   region.notifyOnEntry = YES;
                   region.notifyOnExit = YES;
                    
                }
                if (region) {
                   CLRegion *sameRegion = nil;
                   for (CLCircularRegion *rg in regions) {
                       if ([rg.identifier isEqualToString:region.identifier]) {
                           sameRegion = rg;
                           break;
                       }
                   }
                   
                   if (sameRegion) {
                       [self.locationManager stopMonitoringForRegion:sameRegion];
                   }
    
                    [self.locationManager startMonitoringForRegion:region];
                
                }
                
            }
            
            
        } failure:^(NSError *error) {
        
           
        }];
        
        
    } failure:^(NSError *error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
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


- (UIButton *)openGeoFenceButton {
    if (!_openGeoFenceButton) {
        _openGeoFenceButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_openGeoFenceButton setTitle:@"Open Geo Fcene" forState:UIControlStateNormal];
        [_openGeoFenceButton setTintColor:[UIColor whiteColor]];
        _openGeoFenceButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
        _openGeoFenceButton.backgroundColor = [UIColor orangeColor];
        [_openGeoFenceButton addTarget:self action:@selector(openGeofenceButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openGeoFenceButton;
}

- (TYSecurityHomePersonGeofenceViewController *)geoServiceVC {
    if (!_geoServiceVC) {
        _geoServiceVC = [[TYSecurityHomePersonGeofenceViewController alloc] init];
    }
    return _geoServiceVC;
}


- (UITextField *)lonTextFiled {
    if (!_lonTextFiled) {
        _lonTextFiled = [UITextField new];
        _lonTextFiled.font = [UIFont systemFontOfSize:14.0];
        _lonTextFiled.textColor = [UIColor blackColor];
        _lonTextFiled.placeholder = @"enter longitude.";
        
        _lonTextFiled.layer.borderColor = UIColor.orangeColor.CGColor;
        _lonTextFiled.layer.borderWidth = 1.0;
        
    }
    return _lonTextFiled;
}

- (UITextField *)radiusTextField {
    if (!_radiusTextField) {
        _radiusTextField = [UITextField new];
        _radiusTextField.font = [UIFont systemFontOfSize:14.0];
        _radiusTextField.textColor = [UIColor blackColor];
        _radiusTextField.placeholder = @"enter radius.";
        
        _radiusTextField.layer.borderColor = UIColor.orangeColor.CGColor;
        _radiusTextField.layer.borderWidth = 1.0;
    }
    return _radiusTextField;
}


- (UITextField *)latTextField {
    if (!_latTextField) {
        _latTextField = [UITextField new];
        _latTextField.font = [UIFont systemFontOfSize:14.0];
        _latTextField.textColor = [UIColor blackColor];
        _latTextField.placeholder = @"enter latitude.";
        
        _latTextField.layer.borderColor = UIColor.orangeColor.CGColor;
        _latTextField.layer.borderWidth = 1.0;
    }
    return _latTextField;
}

@end
