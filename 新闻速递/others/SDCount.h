//
//  SDCount.h
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef  DEBUG
#define  Log(...) NSLog(__VA_ARGS__)
#else
#define  Log(...)
#endif


// RGB颜色
#define WPColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
// 随机色
#define RandomColor WPColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

