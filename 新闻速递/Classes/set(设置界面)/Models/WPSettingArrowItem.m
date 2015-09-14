//
//  WPSettingArrowItem.m
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "WPSettingArrowItem.h"

@implementation WPSettingArrowItem

+ (instancetype) itemWithTitle:(NSString *)title icon:(NSString *)icon destVcClass:(Class)destVcClass {
    
    
    WPSettingArrowItem  *item = [super itemWithTitle:title icon:icon];
    item.destVcClass = destVcClass;
    
    return item;
}

@end
