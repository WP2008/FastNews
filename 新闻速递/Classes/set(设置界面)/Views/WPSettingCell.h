//
//  WPSettingCell.h
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WPSettingItem;

@interface WPSettingCell : UITableViewCell

@property (nonatomic, strong) WPSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
