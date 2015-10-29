//
//  SDNewsCell.h
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDNewsModel;

@interface SDNewsCell : UITableViewCell

@property(nonatomic,strong) SDNewsModel *NewsModel;

+ (NSString *)idForRow:(SDNewsModel *)NewsModel;

+ (CGFloat)heightForRow:(SDNewsModel *)NewsModel;

@end
