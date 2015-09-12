//
//  SDDetailImgModel.m
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDDetailImgModel.h"

@implementation SDDetailImgModel
/** 便利构造器方法 */
+ (instancetype)detailImgWithDict:(NSDictionary *)dict
{
    SDDetailImgModel *imgModel = [[self alloc]init];
    imgModel.ref = dict[@"ref"];
    imgModel.pixel = dict[@"pixel"];
    imgModel.src = dict[@"src"];
    
    return imgModel;
}

@end
