//
//  WPSettingItem.h
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^WPSettingItemOption)();

@interface WPSettingItem : NSObject

@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy) NSString *subTitle ;

/** 保存一段功能在点击时调用 */
@property (nonatomic, copy) WPSettingItemOption option;


+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon;

@end
