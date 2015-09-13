//
//  SDWeatherModel.h

//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDWeatherDetailM.h"
#import "SDWeatherBgM.h"
//@class SDWeatherBgM;
//@class SDWeatherDetailM;

@interface SDWeatherModel : NSObject

/** 数组里面装的是SDWeatherDetailM模型*/
@property(nonatomic,strong)NSArray *detailArray;

@property(nonatomic,strong)SDWeatherBgM *pm2d5;

// 时间
@property(nonatomic,copy)NSString *dt;

@property(nonatomic,assign)int rt_temperature;

@end
