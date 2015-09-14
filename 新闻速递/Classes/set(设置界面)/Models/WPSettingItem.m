//
//  WPSettingItem.m
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "WPSettingItem.h"

@implementation WPSettingItem

+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon {
    WPSettingItem *item = [[self alloc]init];
    item.icon = icon;
    item.title = title;
    return item;
}
@end
