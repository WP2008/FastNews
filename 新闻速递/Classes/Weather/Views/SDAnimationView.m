//
//  SDAnimationView.m
//  新闻速递
//
//  Created by tarena on 15/9/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDAnimationView.h"
#import "SDCount.h"

@implementation SDAnimationView
- (instancetype)initWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color {
    self = [super init];
    if (self) {
        
        UIButton *btn = [[UIButton alloc]init];
       
        btn.layer.masksToBounds = YES;
        btn.backgroundColor = color;
        [self addSubview:btn];
        _button = btn;
        
        
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:imageName];
        [self addSubview:img];
        _iconImage = img;

        UILabel *titleLbl = [[UILabel alloc]init];
        titleLbl.font = [UIFont fontWithName:@"HYQiHei" size:16];
        titleLbl.text = title;
        titleLbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:titleLbl];
        _titleLbl = titleLbl;
      
        
         // 测试用
        self.backgroundColor = RandomColor;
        
    }
    return self;

}

+ (instancetype)buttonWithTitle:(NSString *)title IconImageName:(NSString *)imageName BackgroundColor:(UIColor *)color {
  return [[self alloc]initWithTitle:title  IconImageName:imageName BackgroundColor:color];

}


-(void)setFrame:(CGRect)frame {
 
#warning  TODO  计算布局   动画的block  点击 的代理 ？？？？
    
    [super setFrame:frame];
    
     _button.frame  = frame;
    _button.layer.cornerRadius = frame.size.width/2;
    _button.layer.masksToBounds = YES;
    
    _iconImage.frame = frame;

    // 改
    _titleLbl.frame = frame;
    
}


- (void)setAnimation:(BOOL)animation {
    _animation = animation;
    if (animation) {
        [self addAnimation];
    _animation = !animation;
    }
}


-(void)addAnimation {
    
    self.button.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.iconImage.transform = CGAffineTransformMakeScale(1.4, 1.4);
    
        [UIView animateWithDuration:0.2 animations:^{
        self.button.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.iconImage.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 animations:^{
            self.button.transform = CGAffineTransformIdentity;
            self.iconImage.transform = CGAffineTransformIdentity;
        }];
        
    }];

}






@end
