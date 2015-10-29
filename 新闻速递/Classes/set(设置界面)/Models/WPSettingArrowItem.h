//
//  WPSettingArrowItem.h
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.


/**
 *  右侧是箭头的 item  有推出基面的功能
 */
#import "WPSettingItem.h"

@interface WPSettingArrowItem : WPSettingItem

/**
 *  跳转的控制器的类名
 */
@property (nonatomic, strong) Class  destVcClass;

+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon destVcClass:(Class)destVcClass;


@end
