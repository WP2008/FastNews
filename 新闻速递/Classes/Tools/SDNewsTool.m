//
//  SDNewsTool.m
//  新闻速递
//
//  Created by tarena on 15/9/17.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDNewsTool.h"
#import "FMDB.h"
#import "NSString+Extension.h"

 NSString * const dateFormat = @"yyyy-MM-dd HH:mm:ss";
 NSString * const firstPtime = @"firstPtime";
 NSString * const lastPtime = @"lastPtime";
 NSString * const newsType = @"newsType";

@implementation SDNewsTool

static FMDatabase *_db;
+ (void)initialize
{
    NSLog(@"%@", [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"news.sqlite"]);
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"news.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_news (id integer PRIMARY KEY, news blob NOT NULL, newsType text NOT NULL ,ptime text NOT NULL);"];
}

+ (NSArray *)newsWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    
    if (params[firstPtime]) {
            // 加载最新
        NSString *timestamp = [NSString timestampWithString:params[firstPtime] andDateFormat:dateFormat];

        sql = [NSString stringWithFormat:@"SELECT * FROM t_news WHERE newsType = %@ AND ptime > %@ ORDER BY ptime DESC LIMIT 20;",params[newsType] ,timestamp];
        
    } else if (params[lastPtime]) {
        // 加载更多
        NSString *timestamp = [NSString timestampWithString:params[lastPtime] andDateFormat:dateFormat];

        sql = [NSString stringWithFormat:@"SELECT * FROM t_news WHERE newsType = %@ AND ptime <= %@ ORDER BY ptime DESC LIMIT 20;",params[newsType] ,timestamp];
        
    } else {
        //第一次进入程序
        sql = [NSString stringWithFormat:@"SELECT * FROM t_news WHERE newsType = (%@)  ORDER BY ptime DESC LIMIT 20;",params[newsType] ];
        
    } 
    
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    NSMutableArray *newses = [NSMutableArray array];
    while (set.next) {
        NSData *newsData = [set objectForColumnName:@"news"];
        
        NSDictionary *news = [NSKeyedUnarchiver unarchiveObjectWithData:newsData];
        [newses addObject:news];
    }
    return newses;
}




+ (void)saveNews:(NSArray *)newses NewsType:(NSString *)newsType
{
    
    // 要将一个对象存进数据库的blob字段,最好先转为NSData
    // 一个对象要遵守NSCoding协议,实现协议中相应的方法,才能转成NSData
    for (NSDictionary *news in newses) {
        // NSDictionary --> NSData
        NSData *newsData = [NSKeyedArchiver archivedDataWithRootObject:news];
        
#warning TODO ----
// 新闻的发布时间   这是个字符串 怎么比较新闻的发布时间
       // 这是个时间戳
        NSString *ptime = [NSString timestampWithString:news[@"ptime"] andDateFormat:dateFormat];
        
        [_db executeUpdateWithFormat:@"INSERT INTO t_news(news ,newsType ,ptime) VALUES (%@ ,%@,%@);", newsData,newsType,ptime];
    }
}



@end
