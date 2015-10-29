//
//  SDUserInfo.h
//  新闻速递
//
//  Created by WP on 15/10/28.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface SDUserInfo : NSObject

/**
 *  单例
 */
singleton_interface(SDUserInfo)
/**
 *  用户名
 */
@property (nonatomic, strong)NSString *user;
/**
 *  密码
 */
@property (nonatomic, strong)NSString *pwd;
/**
 *  登录的状态 YES 登录过/NO 注销
 */
@property (nonatomic, assign)BOOL loginStatus;


/**
 *  从沙盒里获取用户数据
 */
-(void)loadUserInfoFromSanbox;

/**
 *  保存用户数据到沙盒
 
 */
-(void)saveUserInfoToSanbox;

@end
