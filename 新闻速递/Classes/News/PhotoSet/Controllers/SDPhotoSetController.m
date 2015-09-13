//
//  SDPhotoSetController.m
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDPhotoSetController.h"
#import "SDNewsModel.h"
#import "SDHTTPManager.h"
#import "SDPhotoSet.h"
#import "SDPhotosDetail.h"
#import "SDReplyModel.h"
#import "UIImageView+WebCache.h"
#import "UIView+Extension.h"
#import "SDReplyViewController.h"
#import "SDCount.h"


@interface SDPhotoSetController ()

@property (weak, nonatomic) IBOutlet UIScrollView *photoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentText;
@property (weak, nonatomic) IBOutlet UIButton *replayBtn;






@property(nonatomic,strong) SDPhotoSet *photoSet;
@property(nonatomic,strong) SDReplyModel *replyModel;
@property(nonatomic,strong) NSMutableArray *replyModels;
@property(nonatomic,strong) NSArray *news;





@end

@implementation SDPhotoSetController

#pragma mark -  懒加载

- (NSMutableArray *)replyModels
{
    if (_replyModels == nil) {
        _replyModels = [NSMutableArray array];
    }
    return _replyModels;
}

- (NSArray *)news
{
    if (_news == nil) {
        _news = [NSArray array];
        _news = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _replyModels;
}


#pragma mark -  返回按钮
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    

    // 取出关键字
    NSString *one  = self.newsModel.photosetID;
    NSString *two = [one substringFromIndex:4];
    NSArray *three = [two componentsSeparatedByString:@"|"];

    
    // 设置转发数量
    CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    [self.replayBtn setTitle:displayCount forState:UIControlStateNormal];
    
    
    NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/photo/api/set/%@/%@.json",[three firstObject],[three lastObject]];
    // 发请求
    [self sendRequestWithUrl:url];
    
    // 假数据
    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    [self sendRequestWithUrl2:url2];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    
}


#pragma mark -  发请求
- (void)sendRequestWithUrl:(NSString *)url
{
    [[SDHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        SDPhotoSet *photoSet = [SDPhotoSet photoSetWith:responseObject];
        self.photoSet = photoSet;
        
        [self setLabelWithModel:photoSet];
        
        [self setImageViewWithModel:photoSet];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
    
}

/** 提前把评论的请求也发出去 得到评论的信息 */
- (void)sendRequestWithUrl2:(NSString *)url
{
    [[SDHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        NSArray *dictarray = responseObject[@"hotPosts"];
        //        NSLog(@"%ld",dictarray.count);
        for (int i = 0; i < dictarray.count; i++) {
            NSDictionary *dict = dictarray[i][@"1"];
            SDReplyModel *replyModel = [[SDReplyModel alloc]init];
            replyModel.name = dict[@"n"];
            if (replyModel.name == nil) {
                replyModel.name = @"火星网友";
            }
            replyModel.address = dict[@"f"];
            replyModel.say = dict[@"b"];
            replyModel.suppose = dict[@"v"];
            [self.replyModels addObject:replyModel];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}


#pragma mark -  设置页面的文字和图片

/** 设置页面文字 */
- (void)setLabelWithModel:(SDPhotoSet *)photoSet
{
    // 设置新闻标题
    self.titleLabel.text = photoSet.setname;
    
    // 设置新闻内容
    [self setContentWithIndex:0];
    
    // 设置新闻图片 指示
    NSString *countNum = [NSString stringWithFormat:@"1/%ld",photoSet.photos.count];
    self.countLabel.text = countNum;
}

/** 设置页面imgView */
- (void)setImageViewWithModel:(SDPhotoSet *)photoSet
{
    // 设置scrollView
    NSUInteger count = self.photoSet.photos.count;
    
    CGFloat scrollViewW = self.photoScrollView.width;
    CGFloat scrollViewH = self.photoScrollView.height;
    self.photoScrollView.contentOffset = CGPointZero;
    self.photoScrollView.contentSize = CGSizeMake(self.photoScrollView.width * count, 0);
    self.photoScrollView.showsHorizontalScrollIndicator = NO;
    self.photoScrollView.showsVerticalScrollIndicator = NO;
    self.photoScrollView.pagingEnabled = YES;

 // 添加imageView  有几张就添加几张imageView
    for (int i = 0; i < count; i++) {
        UIImageView *photoImgView = [[UIImageView alloc]init];
        photoImgView.height = scrollViewH;
        photoImgView.width = scrollViewW;
        photoImgView.y = -82;
        photoImgView.x = i * photoImgView.width;
        
        // 图片的显示格式为合适大小   不拉伸 全部显示
        photoImgView.contentMode= UIViewContentModeCenter;
        photoImgView.contentMode= UIViewContentModeScaleAspectFit;
        
        [self.photoScrollView addSubview:photoImgView];
        
    }
    
    // 因为scroll尼玛默认就有两个子控件好吧
    [self setImgWithIndex:0];
    
  }


/** 滚动完毕时调用 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int index = self.photoScrollView.contentOffset.x / self.photoScrollView.width;
    
    // 添加图片
    [self setImgWithIndex:index];
    
    // 添加文字
    NSString *countNum = [NSString stringWithFormat:@"%d/%ld",index+1,self.photoSet.photos.count];
    self.countLabel.text = countNum;
    
    // 添加内容
    [self setContentWithIndex:index];
}


/** 添加内容 */
- (void)setContentWithIndex:(NSUInteger)index
{
    NSString *content = [self.photoSet.photos[index] note];
    NSString *contentTitle = [self.photoSet.photos[index] imgtitle];
    if (content.length != 0) {
        self.contentText.text = content;
    }else{
        self.contentText.text = contentTitle;
    }
}


/** 懒加载添加图片！这里才是设置图片 */
- (void)setImgWithIndex:(NSUInteger)index
{
    UIImageView *photoImgView = nil;
    
    photoImgView = self.photoScrollView.subviews[index];
    
    
    NSURL *purl = [NSURL URLWithString:[self.photoSet.photos[index] imgurl]];
    
    // 如果这个相框里还没有照片才添加
    if (photoImgView.image == nil) {
        [photoImgView sd_setImageWithURL:purl placeholderImage:[UIImage imageNamed:@"photoview_image_default_white"]];
    }
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SDReplyViewController *replyvc = segue.destinationViewController;
    replyvc.replys = self.replyModels;
}




@end
