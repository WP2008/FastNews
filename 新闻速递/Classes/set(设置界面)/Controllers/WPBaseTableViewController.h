//
//  WPBaseTableViewController.h
//  新闻速递
//
//  Created by tarena on 15/9/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
/**
 
  设置界面的基类  
     WPBaseTableViewController
 
 所用的Model
     WPSettingGroup.h
     
     WPSettingItem.h
     
     WPSettingLabelItem.h
     
     WPSettingSwitchItem.h
 
 所用的View
 
     WPSettingCell.h
 
 */

#import <UIKit/UIKit.h>
#import "WPSettingGroup.h"
#import "WPSettingLabelItem.h"
#import "WPSettingSwitchItem.h"
#import "WPSettingArrowItem.h"
#import "WPSettingCell.h"

@interface WPBaseTableViewController : UITableViewController

/**用于填入 每行的信息*/
@property (nonatomic, strong) NSMutableArray *dataList;

@end
