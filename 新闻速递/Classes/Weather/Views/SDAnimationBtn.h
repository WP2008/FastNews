//
//  SDAnimationBtn.h
//  新闻速递
//
//  Created by tarena on 15/9/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAnimationBtn : UIView

@property (nonatomic, strong, readonly) UIButton *button;
@property (nonatomic, strong, readonly) UIImageView *iconImage;

- (instancetype)initWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color;
+ (instancetype)buttonWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color;


@end
