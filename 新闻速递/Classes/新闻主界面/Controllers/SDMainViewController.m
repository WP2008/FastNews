//
//  SDMainViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDMainViewController.h"
#import "SDNewsTableViewController.h"
#import "SDTitleLabel.h"

#import "Masonry.h"
#import "UIView+Extension.h"
#import "SDCount.h"




@interface SDMainViewController ()<UIScrollViewDelegate>

/** 标题栏 */
@property (weak, nonatomic)  UIScrollView *smallScrollView;

/** 下面的内容栏 */
@property (weak, nonatomic)  UIScrollView *bigScrollView;

/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;

@end

@implementation SDMainViewController


#pragma mark  -  懒加载
- (NSArray *)arrayLists
{
    if (_arrayLists == nil) {
        _arrayLists = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
    return _arrayLists;
}


- (UIScrollView *)smallScrollView {
    if ( _smallScrollView == nil) {
        UIScrollView *scrollView = [UIScrollView new];
        [self.view addSubview:scrollView];
        _smallScrollView = scrollView;

        _smallScrollView.showsHorizontalScrollIndicator = NO;
        _smallScrollView.showsVerticalScrollIndicator = NO;
        
        _smallScrollView.backgroundColor = [UIColor purpleColor];
    }
    return _smallScrollView;
}

- (UIScrollView *)bigScrollView {
    if ( _bigScrollView == nil) {
        UIScrollView *scrollView = [UIScrollView new];
        [self.view addSubview:scrollView];
        _bigScrollView = scrollView;
        _bigScrollView.delegate = self;
        _bigScrollView.showsHorizontalScrollIndicator = NO;
        _bigScrollView.pagingEnabled = YES;
    

    }
    return _bigScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    [self addNewsController];
    [self addLable];
    [self setScrollView];

 
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  -  设置控件
/** 添加子控制器 */
- (void)addNewsController {
    for (int i=0 ; i<self.arrayLists.count ; i++){
        SDNewsTableViewController *newsVC  = [[SDNewsTableViewController alloc]init];
        newsVC.title = self.arrayLists[i][@"title"];
        newsVC.urlString = self.arrayLists[i][@"urlString"];
        [self addChildViewController:newsVC];
    }
    
}

/** 添加标题栏 */
- (void)addLable {
    CGFloat lblW = 70;
    CGFloat lblH = 44;
    CGFloat lblY = 0;
    
    for (int i = 0 ; i < self.arrayLists.count ; i++) {
        
        CGFloat lblX = i * lblW;
        SDTitleLabel *titleLabel = [[SDTitleLabel alloc]init];
        UIViewController *vc = self.childViewControllers[i];
        titleLabel.text = vc.title;
        titleLabel.frame = CGRectMake(lblX, lblY, lblW, lblH);
        titleLabel.font = [UIFont fontWithName:@"HYQiHei" size:19];
        [self.smallScrollView addSubview:titleLabel];
        titleLabel.tag = i;
        titleLabel.userInteractionEnabled = YES;
        
        /** 标题栏label的点击事件 */
        [titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(lblClick:)]];
    }
    
    self.smallScrollView.contentSize = CGSizeMake(lblW * self.childViewControllers.count, 0);

}


/** 设置scrollView */
- (void)setScrollView {
  
    //添加约束
    [self.smallScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@44);
        make.top.equalTo(@64);
        make.width.and.centerX.equalTo(self.view);
    
    }];
    
    
    [self.bigScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.top.equalTo(_smallScrollView.mas_bottom);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    
    CGFloat contentX = self.childViewControllers.count * [UIScreen mainScreen].bounds.size.width;
    self.bigScrollView.contentSize = CGSizeMake(contentX, 0);
    
    // 添加默认控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    vc.view.frame = self.bigScrollView.bounds;
    [self.bigScrollView addSubview:vc.view];
    SDTitleLabel *lable = [self.smallScrollView.subviews firstObject];
    lable.scale = 1.0;
  
}


/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SDTitleLabel *titlelable = (SDTitleLabel *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.frame.size.width;
    
    CGFloat offsetY = self.bigScrollView.contentOffset.y;
    CGPoint offset = CGPointMake(offsetX, offsetY);
    
    [self.bigScrollView setContentOffset:offset animated:YES];
    
    
}

#pragma mark -  scrollView代理方法

/** 滚动结束后调用（控制smallscrollView 滚动） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.bigScrollView.frame.size.width;
    // 滚动标题栏
    SDTitleLabel *titleLable = (SDTitleLabel *)self.smallScrollView.subviews[index];
    
    CGFloat offsetMax = self.smallScrollView.contentSize.width - self.smallScrollView.frame.size.width;
    CGFloat offsetx = titleLable.center.x - self.smallScrollView.frame.size.width * 0.5;

    
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

/** 正在滚动 (控制 smallscrollView 中的 label 缩放) */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 取出绝对值 避免最左边往右拉时形变超过1
    CGFloat value = ABS(scrollView.contentOffset.x / scrollView.frame.size.width);
 
    NSUInteger leftIndex = (int)value;
    NSUInteger rightIndex = leftIndex + 1;
    
    //  计算伸缩比例
    CGFloat scaleRight = value - leftIndex;
    CGFloat scaleLeft = 1 - scaleRight;
    
    Log(@"value = %f,leftIndex = %lu,rightIndex = %lu",value,leftIndex,(unsigned long)rightIndex);
    Log(@"scaleRight = %f",scaleRight);
    // 取出要操控的对象
    SDTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    
    // 考虑到最后一个板块，如果右边已经没有板块了
    if (rightIndex < self.smallScrollView.subviews.count) {
        SDTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }


}

@end
