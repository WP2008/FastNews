//
//  SXWeatherModel.m
//  81 - 网易新闻
//
//  Created by dongshangxian on 15/8/1.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SDWeatherModel.h"
#import "MJExtension.h"


@implementation SDWeatherModel
/**
 *  数组中需要转换的模型类
 *
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class（Class类型或者NSString类型）
 */
+ (NSDictionary *)objectClassInArray {

    return @{@"detailArray":[SDWeatherDetailM class]};
}

/**
 *  将属性名换为其他key去字典中取值
 *
 *  @return 字典中的key是属性名，value是从字典中取值用的key
 */
+ (NSDictionary *)replacedKeyFromPropertyName {

    return @{
             @"detailArray" : @"北京|北京"
             };
}


@end
