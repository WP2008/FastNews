//
//  SDNewsTableViewController.h
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDNewsTableViewController : UITableViewController

/**
 *  url端口
 */
@property(nonatomic,copy) NSString *urlString;

/**
 *  vc在scrollView 中的索引
 */
@property (nonatomic,assign) NSInteger index;


@end
