//
//  WPSettingGroup.h
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WPSettingGroup : NSObject

@property (nonatomic, copy) NSString *headerTitle;

@property (nonatomic, copy) NSString *footerTitle;;

@property (nonatomic, strong) NSArray *items ;

@end
