
//
//  SDNewsCell.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
/**
 cell 的高度计算不太好
 
 storyBoard 的 cell  不同样式统一创建 比较🐂
 
 */

#import "SDNewsCell.h"
#import "SDNewsModel.h"
#import "UIImageView+WebCache.h"


static NSString *const placeholderImage = @"302";

@interface SDNewsCell ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgIcon;

/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

/**
 *  回复数
 */
@property (weak, nonatomic) IBOutlet UILabel *lblReply;


/**
 *  描述
 */
@property (weak, nonatomic) IBOutlet UILabel *lblSubtitle;

/**
 *  第二张图片（如果有的话）
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgOther1;
/**
 *  第三张图片（如果有的话）
 */
@property (weak, nonatomic) IBOutlet UIImageView *imgOther2;



@end


@implementation SDNewsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


- (void)setNewsModel:(SDNewsModel *)NewsModel {
    _NewsModel = NewsModel;
    
    [self.imgIcon sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgsrc] placeholderImage:[UIImage imageNamed:placeholderImage]];
    self.lblTitle.text = self.NewsModel.title;
    self.lblSubtitle.text = self.NewsModel.digest;
    
   // 如果回复太多就改成几点几万
   CGFloat count =  [self.NewsModel.replyCount intValue];
   NSString *displayCount = nil;
    if (count) { // 数字不为0
        if (count < 10000) { // 不足10000：直接显示数字，比如786、7986
            displayCount = [NSString stringWithFormat:@"%f", count];
        } else { // 达到10000：显示xx.x万，不要有.0的情况
            double wan = count / 10000.0;
            displayCount = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            displayCount = [displayCount stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
    }
    self.lblReply.text = displayCount;
    
    // 多图cell
    if (self.NewsModel.imgextra.count == 2) {
        
        [self.imgOther1 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[0][@"imgsrc"]] placeholderImage:[UIImage imageNamed:placeholderImage]];
        [self.imgOther2 sd_setImageWithURL:[NSURL URLWithString:self.NewsModel.imgextra[1][@"imgsrc"]] placeholderImage:[UIImage imageNamed:placeholderImage]];
    }


}

#pragma mark -  类方法返回可重用ID
+ (NSString *)idForRow:(SDNewsModel *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID) {
        return @"TopImageCell";
    }else if (NewsModel.hasHead){
        return @"TopTxtCell";
    }else if (NewsModel.imgType){
        return @"BigImageCell";
    }else if (NewsModel.imgextra){
        return @"ImagesCell";
    }else{
        return @"NewsCell";
    }
}

#pragma mark -  类方法返回行高
+ (CGFloat)heightForRow:(SDNewsModel *)NewsModel
{
    if (NewsModel.hasHead && NewsModel.photosetID){
        return 245;
    }else if(NewsModel.hasHead) {
        return 245;
    }else if(NewsModel.imgType) {
        return 170;
    }else if (NewsModel.imgextra){
        return 130;
    }else{
        return 80;
    }
}



@end
