//
//  SXPhotoSet.m
//  81 - 网易新闻
//
//  Created by 董 尚先 on 15/2/3.
//  Copyright (c) 2015年 ShangxianDante. All rights reserved.
//

#import "SDPhotoSet.h"
#import "SDPhotosDetail.h"
#import "MJExtension.h"
@implementation SDPhotoSet

+ (instancetype)photoSetWith:(NSDictionary *)dict
{
    SDPhotoSet *photoSet = [[SDPhotoSet alloc]init];
    [photoSet setValuesForKeysWithDictionary:dict];
    
    NSArray *photoArray = photoSet.photos;
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:photoArray.count];
    
    for (NSDictionary *dict in photoArray) {
        SDPhotosDetail *photoModel = [SDPhotosDetail photoDetailWithDict:dict];
        [temArray addObject:photoModel];
    }
    photoSet.photos = temArray;
    
    return photoSet;
}
MJCodingImplementation
@end
