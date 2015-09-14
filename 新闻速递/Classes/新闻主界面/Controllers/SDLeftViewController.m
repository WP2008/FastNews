//
//  SDLeftViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDLeftViewController.h"
#import "MBProgressHUD+MJ.h"

@interface SDLeftViewController ()


@end

@implementation SDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 //  self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
   
    [self addFirstGroup];
    
    [self addSecondGroup];

    
}

- (void)addFirstGroup {
    
    // 🐷设置跳转的控制器
    WPSettingArrowItem *item1 = [WPSettingArrowItem itemWithTitle:@"推送和通知" icon:@"MorePush" destVcClass:[UIViewController class]];
    
    WPSettingSwitchItem *item2 = [WPSettingSwitchItem  itemWithTitle:@"摇一摇机选" icon:@"handShake"];
    WPSettingSwitchItem *item3 = [WPSettingSwitchItem itemWithTitle:@"声音效果" icon:@"sound_Effect" ];
    WPSettingGroup *firstGroup = [WPSettingGroup new];
    firstGroup.items = @[item1,item2,item3];
    firstGroup.headerTitle = @"通知";
    firstGroup.footerTitle = @"结束";
    
    
    [self.dataList addObject:firstGroup];
    
}

- (void)addSecondGroup {
    
    WPSettingItem *item4 = [WPSettingArrowItem itemWithTitle:@"检查新版本 " icon:@"MoreUpdate"];
    //🐷添加一段功能
    item4.option = ^{
        // 1.  显示蒙板
        [MBProgressHUD showMessage:@"正在检查更新..."];
        
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 2. 掩藏蒙板
            [MBProgressHUD hideHUD];
            
            // 3. 提示用户
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"有更新版本" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
            [alertView show];
            
        });
    };
    
    
    
    WPSettingItem *item5 = [WPSettingArrowItem itemWithTitle:@"帮助" icon:@"MoreHelp" destVcClass:[UIViewController class]];
    WPSettingItem *item6 = [WPSettingArrowItem itemWithTitle:@"分享" icon:@"MoreShare" destVcClass:[UITableViewController class]];
    WPSettingArrowItem *item7 = [WPSettingArrowItem itemWithTitle:@"产品推荐" icon:@"MoreNetease" destVcClass:[UITableViewController class]];
    WPSettingArrowItem *item8 = [WPSettingArrowItem itemWithTitle:@"关于" icon:@"MoreAbout" destVcClass:[UITableViewController class]];
    
    
    WPSettingGroup *secondGroup = [WPSettingGroup new];
    secondGroup.items = @[item4,item5,item6,item7,item8];
    secondGroup.headerTitle = @"abc";
    secondGroup.footerTitle = @"abc";
    
    [self.dataList addObject:secondGroup];
    
}

#pragma mark - Table view data source   父类去做



@end
