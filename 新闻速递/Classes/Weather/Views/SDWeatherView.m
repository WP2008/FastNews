//
//  SDWeatherView.m

//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SDWeatherView.h"
#import "SDWeatherModel.h"
#import "UIView+Extension.h"
#import "SDCount.h"
#import "SDAnimationView.h"


@interface SDWeatherView ()

@property (weak, nonatomic) IBOutlet UIView *bottomView;


@property (weak, nonatomic) IBOutlet UILabel *tempLbl;
@property (weak, nonatomic) IBOutlet UILabel *nowTempLbl;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImg;
@property (weak, nonatomic) IBOutlet UILabel *dateWeekLbl;
@property (weak, nonatomic) IBOutlet UILabel *airPMLbl;
@property (weak, nonatomic) IBOutlet UILabel *climateLbl;
@property (weak, nonatomic) IBOutlet UILabel *localLbl;

@end
@implementation SDWeatherView


/**加载完成后调用*/
- (void)awakeFromNib{

    SDAnimationView *btn1 = [SDAnimationView buttonWithTitle:@"搜索" IconImageName:@"204" BackgroundColor:[UIColor orangeColor]];
    
    SDAnimationView *btn2 = [SDAnimationView buttonWithTitle:@"上头条" IconImageName:@"202" BackgroundColor:[UIColor redColor]];
    
    SDAnimationView *btn3 = [SDAnimationView buttonWithTitle:@"离线" IconImageName:@"203" BackgroundColor:WPColor(213, 22, 71)];
    
    SDAnimationView *btn4 = [SDAnimationView buttonWithTitle:@"夜间" IconImageName:@"205" BackgroundColor:WPColor(58, 153, 208)];
    
    SDAnimationView *btn5 = [SDAnimationView buttonWithTitle:@"扫一扫" IconImageName:@"204" BackgroundColor:WPColor(70, 95, 176)];
    
    SDAnimationView *btn6 = [SDAnimationView buttonWithTitle:@"邀请好友" IconImageName:@"201" BackgroundColor:WPColor(80, 192, 70)];
    
    [self.bottomView addSubview:btn1];
    [self.bottomView addSubview:btn2];
    [self.bottomView addSubview:btn3];
    [self.bottomView addSubview:btn4];
    [self.bottomView addSubview:btn5];
    [self.bottomView addSubview:btn6];
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat w = self.width/3;
    CGFloat h = self.bottomView.height/2;
    for (int i = 0; i < self.bottomView.subviews.count; i ++) {
        int cols = i%3;
        int rows = i/3;
        SDAnimationView *btn = self.bottomView.subviews[i];
        btn.width = w;
        btn.height = h;
        btn.x = cols * w;
        btn.y = rows * h;
       
        
        Log(@"%@",NSStringFromCGRect( btn.frame));
    
    }
}

+ (instancetype)view{
    return [[NSBundle mainBundle]loadNibNamed:@"SDWeatherView" owner:nil options:nil].firstObject;
}


- (IBAction)clickedWeatherButton:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickWeatherView:)]) {
        [self.delegate didClickWeatherView:self];
    }
    
    
    
}


- (void)setWeatherModel:(SDWeatherModel *)weatherModel
{
    _weatherModel = weatherModel;
    
    self.nowTempLbl.text = [NSString stringWithFormat:@"%d",weatherModel.rt_temperature];
    SDWeatherDetailM *weatherDetail = weatherModel.detailArray[0];
    
    NSMutableString *temp = [weatherDetail.temperature mutableCopy];
    [temp replaceOccurrencesOfString:@"C" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, temp.length)];
    
    self.tempLbl.text = temp;
    self.dateWeekLbl.text = [NSString stringWithFormat:@"%@  %@",weatherModel.dt,weatherDetail.week];
    
    NSString *desc;
    int pm = weatherModel.pm2d5.pm2_5.intValue;
    if (pm < 50) {
        desc = @"优";
    }else if (pm < 100){
        desc = @"良";
    }else{
        desc = @"差";
    }
    self.airPMLbl.text = [NSString stringWithFormat:@"PM2.5 %d %@",pm,desc];
    self.localLbl.text = @"北京";
    
    self.climateLbl.text = [NSString stringWithFormat:@"%@ %@",weatherDetail.climate,weatherDetail.wind];
    
    
    if ([weatherDetail.climate isEqualToString:@"雷阵雨"]) {
        self.weatherImg.image = [UIImage imageNamed:@"thunder_mini"];
    }else if ([weatherDetail.climate isEqualToString:@"晴"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun_mini"];
    }else if ([weatherDetail.climate isEqualToString:@"多云"]){
        self.weatherImg.image = [UIImage imageNamed:@"sun_and_cloud_mini"];
    }else if ([weatherDetail.climate isEqualToString:@"阴"]){
        self.weatherImg.image = [UIImage imageNamed:@"nosun_mini"];
    }else if ([weatherDetail.climate hasSuffix:@"雨"]){
        self.weatherImg.image = [UIImage imageNamed:@"rain_mini"];
    }else if ([weatherDetail.climate hasSuffix:@"雪"]){
        self.weatherImg.image = [UIImage imageNamed:@"snow_heavyx_mini"];
    }else{
        self.weatherImg.image = [UIImage imageNamed:@"sand_float_mini"];
    }
}


- (void)addAnimate{
    for (int i = 0; i < self.bottomView.subviews.count; i ++) {

        SDAnimationView *btn = self.bottomView.subviews[i];
        btn.animation = YES;
    }

}





@end
