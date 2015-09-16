//
//  HMAboutViewController.m
//  Demo_彩票_HM
//
//  Created by tarena on 15/8/17.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HMAboutViewController.h"
#import "ILAboutHeaderView.h"

@interface HMAboutViewController ()
@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HMAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addGroup0];
    
    // 控制器会alloc 会自动寻找 xib  view 要自己加载
    self.tableView.tableHeaderView = [ILAboutHeaderView headerView];
    
}

  
- (void)addGroup0 {
    
    // 🐷设置跳转的控制器
    WPSettingArrowItem *score = [WPSettingArrowItem itemWithTitle:@"评分支持" icon:nil];
    score.option = ^{
    
        //如何跳转到AppStore，并且展示自己的应用

        NSString *appid = @"725296055";
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

      
    };
    
    
    WPSettingArrowItem *tel = [WPSettingArrowItem itemWithTitle:@"客服电话 " icon:nil];
    tel.subTitle = @"138-1120-4084";
    tel.option = ^{
        // 1 拨打电话  电话打完后，不会自动回到原应用，直接停留在通话记录界面
//        NSURL *url = [NSURL URLWithString:@"tel://10010"];
//        [[UIApplication sharedApplication] openURL:url];
//        
//        // 2 拨号之前会弹框询问用户是否拨号，拨完后能自动回到原应用
//        // 因为是私有API，所以可能不会被审核通过
//         NSURL *url1 = [NSURL URLWithString:@"telprompt://10010"];
//        [[UIApplication sharedApplication] openURL:url1];
//
//       //  3 创建一个UIWebView来加载URL，拨完后能自动回到原应用
        if (_webView == nil) {
            _webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        }
        [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10010"]]];
//
//     // 拨号之前会弹框询问用户是否拨号，拨完后能自动回到原程序
//      
//     //🐷   注意：这个webView千万不要设置尺寸，不然会挡住其他界面，他只是用来打电话，不需要显示
//

    };
    
    
    WPSettingGroup *group0 = [WPSettingGroup new];
    group0.items = @[score,tel];
    [self.dataList addObject:group0];
    
}



@end
