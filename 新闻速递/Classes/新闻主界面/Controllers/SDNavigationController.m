//
//  SDNavigationController.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDNavigationController.h"

@interface SDNavigationController ()

@end

@implementation SDNavigationController

+ (void)initialize {
    // 设置导航栏的主题
    UINavigationBar *navBar = [UINavigationBar appearance];
    [navBar setBarTintColor:[UIColor redColor]];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
