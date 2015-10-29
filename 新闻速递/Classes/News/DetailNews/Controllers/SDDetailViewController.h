//
//  SDDetailViewController.h
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDNewsModel;


@interface SDDetailViewController : UIViewController

@property(nonatomic,strong) SDNewsModel *newsModel;

@property (nonatomic,assign) NSInteger index;

@end
