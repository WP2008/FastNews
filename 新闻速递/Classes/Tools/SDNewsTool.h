//
//  SDNewsTool.h
//  新闻速递
//
//  Created by tarena on 15/9/17.
//  Copyright (c) 2015年 tarena. All rights reserved.
//   谁能告述我  应该存什么字段

#import <Foundation/Foundation.h>

@interface SDNewsTool : NSObject
/**
 *  根据请求参数去沙盒中加载缓存的新闻数据
 *
 *  @param params 请求参数
 */
+ (NSArray *)newsWithParams:(NSDictionary *)params;

/**
 *  存储新闻数据到沙盒中
 *
 *  @param statuses 需要存储的新闻数据
 */
+ (void)saveNews:(NSArray *)newses NewsType:(NSString *)newsType;

extern NSString * const dateFormat;
extern NSString * const firstPtime;
extern NSString * const lastPtime;
extern NSString * const newsType;
@end
