//
//  SDWeatherDetailVC.h
//
//  Created by dongshangxian on 15/8/8.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SDWeatherModel;

@interface SDWeatherDetailVC : UIViewController

@property(nonatomic,strong)SDWeatherModel *weatherModel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;
@end
