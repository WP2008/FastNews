//
//  SDPhotosDetail.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SDPhotosDetail.h"

@implementation SDPhotosDetail

+ (instancetype)photoDetailWithDict:(NSDictionary *)dict
{
    SDPhotosDetail *photoDetail = [[SDPhotosDetail alloc]init];
    [photoDetail setValuesForKeysWithDictionary:dict];
    
    return photoDetail;
}

MJCodingImplementation
@end
