//
//  NSString+Extension.m
//  新闻速递
//
//  Created by tarena on 15/9/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

#warning TODO 这个有性能问题 待优化

+ (NSString *)timestampWithString:(NSString *)string andDateFormat:(NSString *)format {
    //用来转换时间字符串 ptime
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = format;
    NSTimeZone *zone = [NSTimeZone timeZoneWithName:@"Aisa/beijing"];
    dateFormatter.timeZone = zone;
    NSDate *date = [dateFormatter dateFromString:string];
    return [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
}


@end
