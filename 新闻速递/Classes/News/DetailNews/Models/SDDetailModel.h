//
//  SDDetailModel.h
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDDetailModel : NSObject

/** 新闻标题 */
@property (nonatomic, copy) NSString *title;
/** 新闻发布时间 */
@property (nonatomic, copy) NSString *ptime;
/** 新闻内容 */
@property (nonatomic, copy) NSString *body;
/** 新闻配图(希望这个数组中以后放SDNewsDetailImg模型) */
@property (nonatomic, strong) NSArray *img;


+ (instancetype)detailWithDict:(NSDictionary *)dict;

@end
