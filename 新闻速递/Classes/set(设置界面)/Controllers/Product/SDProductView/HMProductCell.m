//
//  HMProductCell.m
//  Demo_彩票_HM
//
//  Created by tarena on 15/8/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HMProductCell.h"
#import "HMProduct.h"


@interface HMProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation HMProductCell

- (void)setProduct:(HMProduct *)product {
    _product = product;
    _imageView.image = [UIImage imageNamed:_product.icon];
    _label.text = _product.title;
}

 
/**
 *  加载完成调用  原边效果 
 */
- (void)awakeFromNib {
    _imageView.layer.cornerRadius = 10;
    _imageView.clipsToBounds = YES; // _imageView.layer.masksToBounds
    
}

@end
