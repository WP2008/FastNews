//
//  SDUserInfo.m
//  新闻速递
//
//  Created by WP on 15/10/28.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "SDUserInfo.h"

#define UserKey @"user"
#define PwdKey  @"pwd"
#define LoginStatusKey @"loginStatus"

@implementation SDUserInfo

singleton_implementation(SDUserInfo)

/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.user = [defaults objectForKey:UserKey];
    self.pwd = [defaults objectForKey:PwdKey];
    self.loginStatus = [defaults boolForKey:LoginStatusKey];
}
/**
 *  保存用户数据到沙盒
 
 */
-(void)saveUserInfoToSanbox {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.user forKey:UserKey];
    [defaults setObject:self.pwd forKey:PwdKey];
    [defaults setBool:self.loginStatus forKey:LoginStatusKey];
    [defaults synchronize]; // 保证实时 就一定要同步
    
}

@end
