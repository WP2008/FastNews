//
//  SDNetWorkTool.h
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface SDNetWorkTool : AFHTTPSessionManager

+ (instancetype)sharedNetworkTool;



@end
