//
//  SDDetailViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDDetailViewController.h"
#import "SDNewsModel.h"
#import "SDDetailModel.h"
#import "SDDetailImgModel.h"

#import "SDHTTPManager.h"
#import "MBProgressHUD+MJ.h"
#import "SDCount.h"

#import "SDReplyModel.h"

@interface SDDetailViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *replyCountBtn;
@property(nonatomic,strong) SDDetailModel *detailModel;

@property(nonatomic,strong) NSMutableArray *replyModels;

@end

@implementation SDDetailViewController

#pragma mark -  懒加载

- (NSMutableArray *)replyModels
{
    if (_replyModels == nil) {
        _replyModels = [NSMutableArray array];
    }
    return _replyModels;
}

//- (NSArray *)news
//{
//    if (_news == nil) {
//        _news = [NSArray array];
//        _news = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
//    }
//    return _news;
//}


#pragma mark -  返回按钮
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    
      self.automaticallyAdjustsScrollViewInsets = NO;
    
    // http://c.m.163.com/nc/article/AHHQIG5B00014JB6/full.html
    self.webView.delegate = self;
     NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",self.newsModel.docid];
    
    [[SDHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.detailModel = [SDDetailModel detailWithDict:responseObject[self.newsModel.docid]];
        [self showInWebView];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [MBProgressHUD showError:@"加载失败，请稍候再试"];

        
    }];
  
     NSString *docID = self.newsModel.docid;
     CGFloat count =  [self.newsModel.replyCount intValue];
    NSString *displayCount = nil;
    if (count > 10000) {
        displayCount = [NSString stringWithFormat:@"%.1f万跟帖",count/10000];
    }else{
        displayCount = [NSString stringWithFormat:@"%.0f跟帖",count];
    }
    
    [self.replyCountBtn setTitle:displayCount forState:UIControlStateNormal];
    
    
    Log(@"%@----%@",self.newsModel.boardid,docID);
    
    // 假数据
    //    NSString *url2 = @"http://comment.api.163.com/api/json/post/list/new/hot/photoview_bbs/PHOT1ODB009654GK/0/10/10/2/2";
    
    // 真数据
    NSString *url2 = [NSString stringWithFormat:@"http://comment.api.163.com/api/json/post/list/new/hot/%@/%@/0/10/10/2/2",self.newsModel.boardid,docID];
    [self sendRequestWithUrl2:url2];

    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 提前把评论的请求也发出去 得到评论的信息 */ 
- (void)sendRequestWithUrl2:(NSString *)url
{
    [[SDHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        if (responseObject[@"hotPosts"] != [NSNull null]) {
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
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}




#pragma mark -  拼接html语言  此处不懂 学习
- (void)showInWebView
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    
    [html appendString:@"<body>"];
    [html appendString:[self touchBody]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    [self.webView loadHTMLString:html baseURL:nil];
}

- (NSString *)touchBody
{
    NSMutableString *body = [NSMutableString string];
    [body appendFormat:@"<div class=\"title\">%@</div>",self.detailModel.title];
    [body appendFormat:@"<div class=\"time\">%@</div>",self.detailModel.ptime];
    if (self.detailModel.body != nil) {
        [body appendString:self.detailModel.body];
    }
    // 遍历img
    for (SDDetailImgModel *detailImgModel in self.detailModel.img) {
        NSMutableString *imgHtml = [NSMutableString string];
        
        // 设置img的div
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        // 数组存放被切割的像素
        NSArray *pixel = [detailImgModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject]floatValue];
        CGFloat height = [[pixel lastObject]floatValue];
        // 判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width * 0.96;
        if (width > maxWidth) {
            height = maxWidth / width * height;
            width = maxWidth;
        }
        
        NSString *onload = @"this.onclick = function() {"
        "  window.location.href = 'sx:src=' +this.src;"
        "};";
        [imgHtml appendFormat:@"<img onload=\"%@\" width=\"%f\" height=\"%f\" src=\"%@\">",onload,width,height,detailImgModel.src];
        // 结束标记
        [imgHtml appendString:@"</div>"];
        // 替换标记
        [body replaceOccurrencesOfString:detailImgModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, body.length)];
        
    }
    return body;
}
@end
