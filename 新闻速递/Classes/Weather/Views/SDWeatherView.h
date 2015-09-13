//
//  SDWeatherView.h
//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDWeatherModel;
@interface SDWeatherView : UIView
@property(nonatomic,strong)SDWeatherModel *weatherModel;

+ (instancetype)view;
- (void)addAnimate;

@end
