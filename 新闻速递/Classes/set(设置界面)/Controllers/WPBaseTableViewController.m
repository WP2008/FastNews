//
//  WPBaseTableViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "WPBaseTableViewController.h"
#import "UIViewController+MMDrawerController.h"


@interface WPBaseTableViewController ()

@end

@implementation WPBaseTableViewController

- (NSMutableArray *)dataList {
    if ( _dataList == nil) {
        _dataList = [NSMutableArray array];
        
   }
    return _dataList;
}


-(instancetype)init {
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.sectionFooterHeight = 20;
    self.tableView.sectionHeaderHeight = 0;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];


}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    WPSettingGroup *group = self.dataList[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     *  进一步封装cell   cell create  setValue
     */
    WPSettingCell *cell = [WPSettingCell cellWithTableView:tableView];
    WPSettingGroup *group = self.dataList[indexPath.section];
    WPSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    
    return cell;
}

// setting header / footer title

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    WPSettingGroup *group = self.dataList[section];
    return group.headerTitle;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    WPSettingGroup *group = self.dataList[section];
    return group.footerTitle;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WPSettingGroup *group = self.dataList[indexPath.section];
    WPSettingItem *item = group.items[indexPath.row];
    
    /**
     *  如果有操作就调用
     */
    if (item.option) {
        item.option();
    }
    /**
     *  如果时 这样的item 推出控制器
     */
    if ([item isKindOfClass:[WPSettingArrowItem class]]) {// 需要跳转
        WPSettingArrowItem *arrowItem = (WPSettingArrowItem *)item;
        
        if (arrowItem.destVcClass) {
            
            UIViewController *VC = [[arrowItem.destVcClass alloc]init];
            
            //  Class class = NSStringFromClass(@"viewController");
            VC.title = item.title;
   
           UINavigationController *navi =  self.mm_drawerController.centerViewController;
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            [navi pushViewController:VC animated:YES];
            
          
            
        }
        
    }
    
}


@end
