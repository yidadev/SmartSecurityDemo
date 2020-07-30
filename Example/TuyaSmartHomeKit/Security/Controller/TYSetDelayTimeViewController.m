//
//  TYSetDelayTimeViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by MokZF on 2020/7/29.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYSetDelayTimeViewController.h"
#import <Masonry/Masonry.h>
#import "TYSmartHomeManager.h"
#import <TYFoundationKit/TYFoundationKit.h>

@interface TYSetDelayTimeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger sTime;

@end

@implementation TYSetDelayTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initPage];
    self.sTime = self.isAlarming ? self.alarmTime : self.currentTime;
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (indexPath.row == (self.sTime/30)) {
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row) * 30];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",(indexPath.row) * 30];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.sTime = (indexPath.row) * 30;
    [self.tableView reloadData];
}
#pragma mark -
#pragma mark - action


#pragma mark -
#pragma mark - public method


#pragma mark -
#pragma mark - private method
- (void)rightItemAction {
    TuyaSmartSecurityArmedRuleDelayTimeModel *timeModel = [TuyaSmartSecurityArmedRuleDelayTimeModel new];
    timeModel.mode = self.currentMode;
    if (self.isAlarming) {
        timeModel.alarmDelayTime = self.sTime;
        timeModel.enableDelayTime = self.currentTime;
    }else {
        timeModel.enableDelayTime = self.sTime;
        timeModel.alarmDelayTime = self.alarmTime;
    }
    
    long long homeId = [TYSmartHomeManager sharedInstance].currentHome.homeModel.homeId;
    ty_weakify(self);
    [[TuyaSmartSecurityArmedRuleSetting sharedInstance] saveDelayTimeWithDelayRule:timeModel homeId:homeId success:^(BOOL result) {
        ty_strongify(self);
        if (result) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        ty_strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
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
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

#pragma mark -
#pragma mark - init

- (void)initPage {
    [self initTopBarView];
}

- (void)initTopBarView {
    [self.view addSubview:self.topBarView];
    self.centerTitleItem.title = @"Security";
    self.topBarView.centerItem = self.centerTitleItem;
    self.leftBackItem.title = @"Back";
    self.topBarView.leftItem = self.leftBackItem;
    
    self.topBarView.rightItem = self.rightTitleItem;
    self.rightTitleItem.title = @"Save";
    self.rightTitleItem.target = self;
    self.rightTitleItem.action = @selector(rightItemAction);
    self.topBarView.rightItem = self.rightTitleItem;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topBarView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

@end
