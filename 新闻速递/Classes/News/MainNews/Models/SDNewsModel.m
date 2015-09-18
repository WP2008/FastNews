//
//  SXNewsModel.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDNewsModel.h"
#import "MJExtension.h"

@implementation SDNewsModel

+ (instancetype)newsModelWithDict:(NSDictionary *)dict
{
    SDNewsModel *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

MJCodingImplementation

@end
