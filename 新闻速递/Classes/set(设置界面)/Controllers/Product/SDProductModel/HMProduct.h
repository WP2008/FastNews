//
//  HMProduct.h
//  Demo_彩票_HM
//
//  Created by tarena on 15/8/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMProduct : NSObject
/**
 "title": "网易电影票",
 "id": "com.netease.movie",
 "url": "http://itunes.apple.com/app/id583784224?mt=8",
 "icon": "movie@2x.png",
 "customUrl": "movieticket163"
 
 */
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *customUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)productWithDict:(NSDictionary *)dict;


@end
