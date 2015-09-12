//
//  SDDetailModel.m
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDDetailModel.h"
#import "SDDetailImgModel.h"


@implementation SDDetailModel
/** 便利构造器 */
+ (instancetype)detailWithDict:(NSDictionary *)dict
{
    SDDetailModel *detail = [[self alloc]init];
    detail.title = dict[@"title"];
    detail.ptime = dict[@"ptime"];
    detail.body = dict[@"body"];
    
    NSArray *imgArray = dict[@"img"];
    NSMutableArray *temArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
    for (NSDictionary *dict in imgArray) {
        SDDetailImgModel *imgModel = [SDDetailImgModel detailImgWithDict:dict];
       [temArray addObject:imgModel];
    }
    detail.img = temArray;
    
    
    return detail;
}
@end
