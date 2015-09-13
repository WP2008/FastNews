//
//  SDAnimationBtn.h
//  新闻速递
//
//  Created by tarena on 15/9/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDAnimationView : UIView

@property (nonatomic, weak, readonly) UILabel *titleLbl;
@property (nonatomic, weak, readonly) UIButton *button;
@property (nonatomic, weak, readonly) UIImageView *iconImage;
@property (nonatomic, assign,getter=isAnimation) BOOL animation;



- (instancetype)initWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color;
+ (instancetype)buttonWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color;


@end
