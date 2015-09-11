//
//  SDTitleLabel.h
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.


/** 
  新闻中导航下的scrollView 中的label   
   
  带 伸缩效果  scale  默认 0
*/
#import <UIKit/UIKit.h>

@interface SDTitleLabel : UILabel


/** 通过scale的改变改变多种参数 */
@property (nonatomic,assign) CGFloat scale;

@end
