//
//  TYSelectSensorsViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/29.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYSelectSensorsViewController.h"
#import "TYSmartHomeManager.h"
#import <Masonry/Masonry.h>
#import <TYUIKit/TYUIKit.h>
#import <TYFoundationKit/TYFoundationKit.h>
#import <TuyaSmartSecurityBaseKit/TuyaSmartSecurityArmedRuleSetting.h>

@interface TYSelectSensorsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectedDeviceArray;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation TYSelectSensorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initPage];
    [self loadData];
}

#pragma mark -
#pragma mark - delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    TuyaSmartSecurityArmedRuleDeviceModel *model = self.dataSource[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = model.name;
    if ([self _shouldCheck:model]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    TuyaSmartSecurityArmedRuleDeviceModel *model = self.dataSource[indexPath.row];
    if (model.fixed) {
        [TPProgressUtils showSuccess:@"Not Allow Selected" toView:self.view];
        return;
    }
    TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:model.deviceId];
    
    //移除选中设备
    if ([self _shouldCheck:model]) {
        //如果是网关设备，则单独处理
        if ([self _isGatewayDeviceWith:device.deviceModel.deviceType]) {
            [self dealData:model];
            return;
        }
        [self.selectedDeviceArray removeObject:model];
        cell.accessoryType = UITableViewCellAccessoryNone;
        //校验网关下所有的子设备是否都被移除
//        [self checkGatewaySubDevices];
    }else {
        
        //如果子设备，则单独处理
        if (![self _isGatewayDeviceWith:device.deviceModel.deviceType]) {
            [self addSubDeviceLogic:model];
        }else {
            [self.selectedDeviceArray addObject:model];
        }
    }
    [self.tableView reloadData];
}

//添加子设备
- (void)addSubDeviceLogic:(TuyaSmartSecurityArmedRuleDeviceModel *)model {
    TuyaSmartDevice *subDevice = [TuyaSmartDevice deviceWithDeviceId:model.deviceId];
    TuyaSmartDevice *superDevice = [TuyaSmartDevice deviceWithDeviceId:subDevice.deviceModel.parentId];
    
    if (superDevice) {
        BOOL superSelected = NO;
        for (TuyaSmartSecurityArmedRuleDeviceModel *selectedModel in self.selectedDeviceArray) {
            if ([selectedModel.deviceId isEqualToString:superDevice.deviceModel.devId]) {
                superSelected = YES;
            }
        }
        
        if (!superSelected) {
            for (TuyaSmartSecurityArmedRuleDeviceModel *targetModel in self.dataSource) {
                if ([targetModel.deviceId isEqualToString:superDevice.deviceModel.devId]) {
                    [self.selectedDeviceArray addObject:targetModel];
                    [self.selectedDeviceArray addObject:model];
                }
            }
        }else {
            [self.selectedDeviceArray addObject:model];
        }
    }
}

- (void)checkGatewaySubDevices {
    for (TuyaSmartSecurityArmedRuleDeviceModel *model in self.dataSource) {
        TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:model.deviceId];
        if ([self _isGatewayDeviceWith:device.deviceModel.deviceType]) {
            [self _gatewayCheck:model];
        }
    }
}

- (void)_gatewayCheck:(TuyaSmartSecurityArmedRuleDeviceModel *)model {
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.selectedDeviceArray];
    BOOL hasSubDevice = NO;
    if ([self _shouldCheck:model]) {
        for (TuyaSmartSecurityArmedRuleDeviceModel *targetModel in tempArray) {
            TuyaSmartDevice *subDevice = [TuyaSmartDevice deviceWithDeviceId:targetModel.deviceId];
            if (![targetModel.deviceId isEqualToString:model.deviceId]) {
                if ([subDevice.deviceModel.parentId isEqualToString:model.deviceId]) {
                    hasSubDevice = YES;
                    break;
                }
            }
        }
    }
    
    if (!hasSubDevice && [self _shouldCheck:model]) {
        for (TuyaSmartSecurityArmedRuleDeviceModel *targetModel in tempArray) {
            if ([targetModel.deviceId isEqualToString:model.deviceId]) {
                [self.selectedDeviceArray removeObject:model];
            }
        }
    }
    
    [self.tableView reloadData];
}
#pragma mark -
#pragma mark - action
- (void)dealData:(TuyaSmartSecurityArmedRuleDeviceModel *)model {
    TuyaSmartDevice *deviceM = [TuyaSmartDevice deviceWithDeviceId:model.deviceId];
    if (!model.sub && [self _isGatewayDeviceWith:deviceM.deviceModel.deviceType]) {
        [self.selectedDeviceArray removeObject:model];
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.selectedDeviceArray];
        for (TuyaSmartSecurityArmedRuleDeviceModel *selectedDevicce in tempArray) {
            TuyaSmartDevice *selectedDevice = [TuyaSmartDevice deviceWithDeviceId:selectedDevicce.deviceId];
            if ([selectedDevice.deviceModel.parentId isEqualToString:model.deviceId]) {
                [self.selectedDeviceArray removeObject:selectedDevicce];
            }
        }
    }
    [self.tableView reloadData];
}

- (BOOL)_shouldCheck:(TuyaSmartSecurityArmedRuleDeviceModel *)model {
    for (TuyaSmartSecurityArmedRuleDeviceModel *subModel in self.selectedDeviceArray) {
        if ([subModel.deviceId isEqualToString:model.deviceId]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark -
#pragma mark - public method


#pragma mark -
#pragma mark - private method
- (void)rightItemAction {
    [[TuyaSmartSecurityArmedRuleSetting sharedInstance]
     saveDeviceListWithMode:self.currentMode
     homeId:[TYSmartHomeManager sharedInstance].currentHome.homeModel.homeId
     deviceRuleList:[self _getSaveParams]
     success:^(id result) {
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        if (error) {
            [TPProgressUtils showError:error];
        }
    }];
}
- (NSArray *)_getSaveParams {
//    @{@"deviceIds" : @"xxx",
//      @"gatewayId" : @"xxx"
//    };
    
    NSMutableArray *params = [[NSMutableArray alloc] init];
    NSMutableArray *gatewayIds = [[NSMutableArray alloc] init];
    for (TuyaSmartSecurityArmedRuleDeviceModel *model in self.selectedDeviceArray) {
        TuyaSmartDevice *device = [TuyaSmartDevice deviceWithDeviceId:model.deviceId];
        if ([self _isGatewayDeviceWith:device.deviceModel.deviceType]) {
            [gatewayIds addObject:model.deviceId];
        }
    }
    
    for (NSString *gatewayDeviceId in gatewayIds) {
        NSMutableDictionary *mapper = [NSMutableDictionary new];
        [mapper setObject:gatewayDeviceId forKey:@"gatewayId"];
        NSMutableArray *subDeviceIds = [[NSMutableArray alloc] init];
        for (TuyaSmartSecurityArmedRuleDeviceModel *model in self.selectedDeviceArray) {
            TuyaSmartDevice *subDevice = [TuyaSmartDevice deviceWithDeviceId:model.deviceId];
            if (model.sub && [subDevice.deviceModel.parentId isEqualToString:gatewayDeviceId]) {
                [subDeviceIds addObject:model.deviceId];
            }
        }
        [mapper setObject:subDeviceIds forKey:@"deviceIds"];
        
        [params addObject:mapper];
    }
    
    return params;
}

#pragma mark - network load


#pragma mark -  update


#pragma mark -  p_private


#pragma mark -
#pragma mark - getter and setter
- (UITableView *)tableView {
    if (!_tableView ) {
        _tableView = [UITableView new];
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.rowHeight = 54;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.allowsSelection = YES;
    }
    return _tableView;
}

- (NSMutableArray *)selectedDeviceArray {
    if (!_selectedDeviceArray) {
        _selectedDeviceArray = [NSMutableArray new];
    }
    return _selectedDeviceArray;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray new];
    }
    return _dataSource;
}

#pragma mark -
#pragma mark - init

- (void)initPage {
    [self initTopBarView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBarView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view).offset(-TY_ScreenSafeBottom());
    }];
}

- (void)initTopBarView {
    [self.view addSubview:self.topBarView];
    self.view.backgroundColor = [UIColor ty_colorWithHex:0xF8F8F8];
    self.centerTitleItem.title = @"Security Mode";
    self.topBarView.centerItem = self.centerTitleItem;
    self.leftBackItem.title = @"Back";
    self.topBarView.leftItem = self.leftBackItem;
    
    self.topBarView.rightItem = self.rightTitleItem;
    self.rightTitleItem.title = @"Save";
    self.rightTitleItem.target = self;
    self.rightTitleItem.action = @selector(rightItemAction);
    self.topBarView.rightItem = self.rightTitleItem;
}

- (void)loadData {

    if ([TYSmartHomeManager sharedInstance].currentHome.deviceList.count == 0) {
        return;
    }
    long long homeId = [TYSmartHomeManager sharedInstance].currentHome.homeModel.homeId;
    
    [TPProgressUtils showMessag:nil toView:self.view];
    
    ty_weakify(self);

    [[TuyaSmartSecurityArmedRuleSetting sharedInstance]
     getDeviceListWithMode:self.currentMode
     homeId:homeId
     success:^(NSArray<TuyaSmartSecurityArmedRuleDeviceModel *> * _Nullable nDeviceList) {
        ty_strongify(self);
        [TPProgressUtils hideHUDForView:self.view animated:YES];
        if (nDeviceList.count == 0) {
            return ;
        }
        for (TuyaSmartSecurityArmedRuleDeviceModel *model in nDeviceList) {
            for (TuyaSmartDeviceModel *deviceModel in [TYSmartHomeManager sharedInstance].currentHome.deviceList) {
                if ([model.productId isEqualToString:deviceModel.productId]) {
                    [self.dataSource addObject:model];
                    if (model.selected && !model.fixed) {
                        [self.selectedDeviceArray addObject:model];
                    }
                }
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        ty_strongify(self);
        [TPProgressUtils hideHUDForView:self.view animated:YES];
        [TPProgressUtils showError:error];
    }];
}

- (void)dealData:(NSArray<TuyaSmartDeviceModel *> *)homeDevices
      ruleDevice:(NSArray *)ruleDevcies {
    for (TuyaSmartDeviceModel *deviceModel in homeDevices) {
        if (![self _isGatewayDeviceWith:deviceModel.deviceType]) {
            continue;
        }
        [self.dataSource addObject:deviceModel.devId];
        
        
    }
}

- (BOOL)_isGatewayDeviceWith:(TuyaSmartDeviceModelType)deviceType {
    
    switch (deviceType) {
        case TuyaSmartDeviceModelTypeZigbeeGateway:
        case TuyaSmartDeviceModelTypeInfraredGateway:
        case TuyaSmartDeviceModelTypeWifiGateway:
        case TuyaSmartDeviceModelTypeSIGMeshGateway:
            return YES;
            break;
        default:
            break;
            
    }
    return NO;
}
@end
