//
//  SDSettingViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDSettingViewController.h"
#import "MBProgressHUD+MJ.h"
#import "SDWebImageManager.h"

#import "HMShareViewController.h"
#import "HMAboutViewController.h"


@interface SDSettingViewController ()

@end

@implementation SDSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self addFirstGroup];
    
    [self addSecondGroup];
    
    
}


- (void)addFirstGroup {
    
    // 🐷设置跳转的控制器
    WPSettingArrowItem *push = [WPSettingArrowItem itemWithTitle:@"推送和通知" icon:@"MorePush" destVcClass:[UIViewController class]];
    
    WPSettingSwitchItem *link = [WPSettingSwitchItem  itemWithTitle:@"省流量模式" icon:@"handShake"];
    WPSettingSwitchItem *sound = [WPSettingSwitchItem itemWithTitle:@"声音效果" icon:@"sound_Effect" ];
    
    
    
  
    // 获取缓存中的image size
    double size = [[SDImageCache sharedImageCache] getSize];
    WPSettingLabelItem *cleckItem = [WPSettingLabelItem itemWithTitle:[NSString stringWithFormat:@" 清除图片缓存 (%.1f M)",(size/1000.0/1000.0)] icon:nil];


    __weak WPSettingLabelItem *instance = cleckItem ;
     cleckItem.option = ^{
         // 1.  显示蒙板
        [MBProgressHUD showMessage:@"正在清除图片缓存"];
         
        [[SDImageCache sharedImageCache] clearDisk];
         
        instance.title = [NSString stringWithFormat:@" 清除图片缓存 (0.0 M)"] ;
      
        [self.view performSelector:@selector(reloadData)];

        [MBProgressHUD hideHUD];
         
    };

    
    
    WPSettingGroup *firstGroup = [WPSettingGroup new];
    firstGroup.items = @[push,link,sound,cleckItem];
    firstGroup.headerTitle = @"基本设置";
    firstGroup.footerTitle = @"一段测试文字";
    
    
    [self.dataList addObject:firstGroup];
    
}


- (void)addSecondGroup {
    
    WPSettingItem *updata = [WPSettingArrowItem itemWithTitle:@"检查新版本 " icon:@"MoreUpdate"];
    //🐷添加一段功能
    updata.option = ^{
        // 1.  显示蒙板
        
       [MBProgressHUD showMessage:@"正在检查更新..."];
       // NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
            NSLog(@"%@",[NSThread currentThread]);

            // 3. 提示用户
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"有更新版本" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"立即更新", nil];
            [alertView show];
            
            [MBProgressHUD hideHUD];
            
        });
    };
    
    
    WPSettingItem *help = [WPSettingArrowItem itemWithTitle:@"帮助" icon:@"MoreHelp" destVcClass:[UITableViewController class]];
    WPSettingItem *share = [WPSettingArrowItem itemWithTitle:@"分享" icon:@"MoreShare" destVcClass:[HMShareViewController class]];
    WPSettingArrowItem *about = [WPSettingArrowItem itemWithTitle:@"关于" icon:@"MoreAbout" destVcClass:[HMAboutViewController class]];
    
    
    WPSettingGroup *secondGroup = [WPSettingGroup new];
    secondGroup.items = @[updata,help,share,about,];
    secondGroup.headerTitle = @"产品信息";
    secondGroup.footerTitle = @"新闻速递 www.sdNews.com";
    
    [self.dataList addObject:secondGroup];
    
}


- (void)dealloc {
    NSLog(@"%s",__func__);
}


@end
