//
//  SDLoginAndRegisterTool.h
//  新闻速递
//
//  Created by WP on 15/10/28.
//  Copyright © 2015年 tarena. All rights reserved.
/*
 登录  注册 的操作
 
 
 */

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef NS_ENUM(NSUInteger, SDResultType){
    SDResultTypeLoginSuccess,//登录成功
    SDResultTypeLoginFailure,//登录失败
    SDResultTypeNetErr,//网络不给力
    SDResultTypeRegisterSuccess,//注册成功
    SDResultTypeRegisterFailure//注册失败

};

typedef void (^SDResultBlock)(SDResultType type);// XMPP请求结果的block

@interface SDLoginAndRegisterTool : NSObject

singleton_interface(SDLogInAndRegisterTool)


/**
 *  注册标识 YES 注册 / NO 登录
 */
@property (nonatomic, assign,getter=isRegisterOperation) BOOL  registerOperation;//注册操作

/**
 *  用户注销
 */
-(void)Userlogout;
/**
 *  用户登录
 */
-(void)UserLogin:(SDResultBlock)resultBlock;

/**
 *  用户注册
 */
-(void)UserRegister:(SDResultBlock)resultBlock;


@end
