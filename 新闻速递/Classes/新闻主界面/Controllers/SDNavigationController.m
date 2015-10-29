//
//  SDNavigationController.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDNavigationController.h"
#import "SDCount.h"
#import "UIViewController+MMDrawerController.h"
@interface SDNavigationController ()

@end

@implementation SDNavigationController

+ (void)initialize {
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:GlobalColor];
    NSShadow *shadow = [[NSShadow alloc]init];
    shadow.shadowColor = [UIColor yellowColor];
    shadow.shadowOffset = CGSizeMake(0, 2);
    
    NSDictionary *dict = @{
                           NSForegroundColorAttributeName:[UIColor whiteColor],
                           NSFontAttributeName:[UIFont systemFontOfSize:22],
                       
                           };
    [navBar setTitleTextAttributes:dict];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    if(self.mm_drawerController.showsStatusBarBackgroundView){
        return UIStatusBarStyleLightContent;
    }
    else {
        return UIStatusBarStyleLightContent;
    }
}



@end
