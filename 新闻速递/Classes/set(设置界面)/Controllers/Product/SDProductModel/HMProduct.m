//
//  HMProduct.m
//  Demo_彩票_HM
//
//  Created by tarena on 15/8/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HMProduct.h"

@implementation HMProduct

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;

}

+ (instancetype)productWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];

}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"ID"];
    }
}


@end
