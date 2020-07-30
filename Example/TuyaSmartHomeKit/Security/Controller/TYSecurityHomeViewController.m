//
//  TYSecurityHomeViewController.m
//  TuyaSmartHomeKit_Example
//
//  Created by Wei Zhang on 2020/7/18.
//  Copyright © 2020 xuchengcheng. All rights reserved.
//

#import "TYSecurityHomeViewController.h"
#import <Masonry/Masonry.h>
#import <TYFoundationKit/TYFoundationKit.h>
#import "TYSecurityHomeGeofenceViewController.h"
#import "TYArmedHomeViewController.h"

typedef void (^DidSelect)(UITableView *tableView, NSIndexPath *indexPath);

@interface TYSecurityItemModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) DidSelect didSelect;

@end


@implementation TYSecurityItemModel


@end


@interface TYSecurityItemCell : UITableViewCell

@end


@implementation TYSecurityItemCell

@end

@interface TYSecurityHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *functionTableView;
@property (nonatomic, strong) NSArray<TYSecurityItemModel *> *functionList;

@end

@implementation TYSecurityHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.centerTitleItem.title = @"Security";
    self.topBarView.centerItem = self.centerTitleItem;
    
    [self.view addSubview:self.functionTableView];
    [self.functionTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.topBarView.mas_bottom).offset(0);
        make.bottom.equalTo(self.view).offset(0);
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.functionList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identify = @"identify";
    TYSecurityItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[TYSecurityItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    TYSecurityItemModel *itemModel = [self.functionList objectAtIndex:indexPath.row];
    cell.textLabel.text = itemModel.title;
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TYSecurityItemModel *item = [self.functionList objectAtIndex:indexPath.row];
    if (item.didSelect) {
        item.didSelect(tableView, indexPath);
    }
}


- (NSArray<TYSecurityItemModel *> *)functionList {
    if (!_functionList) {
        
        NSMutableArray *list = [[NSMutableArray alloc] init];
        
        TYSecurityItemModel *armItem = [[TYSecurityItemModel alloc] init];
        armItem.title = @"Arm";
        ty_weakify(self);
        armItem.didSelect = ^(UITableView *tableView, NSIndexPath *indexPath) {
            ty_strongify(self);
            TYArmedHomeViewController *armedVC = [TYArmedHomeViewController new];
            [self.navigationController pushViewController:armedVC animated:YES];
        };
        [list addObject:armItem];
        
        
        TYSecurityItemModel *geofenceItem = [[TYSecurityItemModel alloc] init];
        geofenceItem.title = @"Home Geofence";
        geofenceItem.didSelect = ^(UITableView *tableView, NSIndexPath *indexPath) {
            
            TYSecurityHomeGeofenceViewController *vc = [[TYSecurityHomeGeofenceViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            
        };
        [list addObject:geofenceItem];
        
        
        TYSecurityItemModel *eventRecording = [[TYSecurityItemModel alloc] init];
        eventRecording.title = @"Event Recording";
        eventRecording.didSelect = ^(UITableView *tableView, NSIndexPath *indexPath) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"developing" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        };
        [list addObject:eventRecording];
        
        _functionList = list.copy;
    
    }
    return _functionList;
}
- (UITableView *)functionTableView {
    if (!_functionTableView) {
        _functionTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                          style:UITableViewStylePlain];
        _functionTableView.rowHeight = 60.0;
        
        _functionTableView.delegate = self;
        _functionTableView.dataSource = self;
    }
    return _functionTableView;
}

@end
