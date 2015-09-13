//
//  SDAnimationBtn.m
//  新闻速递
//
//  Created by tarena on 15/9/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDAnimationBtn.h"

@implementation SDAnimationBtn
- (instancetype)initWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color {
    self = [super init];
    if (self) {
        
        
        
        
    }
    return self;

}

+ (instancetype)buttonWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color {
  return [[self alloc]initWithTitle:title  IconImageName:imageName BackgroundColor:color];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
