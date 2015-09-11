//
//  SDMainViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDMainViewController.h"

@interface SDMainViewController ()<UIScrollViewDelegate>

/** 标题栏 */
@property (weak, nonatomic) UIScrollView *smallScrollView;

/** 下面的内容栏 */
@property (weak, nonatomic) UIScrollView *bigScrollView;

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

-  (UIScrollView *)smallScrollView {
    if ( _smallScrollView == nil) {
        UIScrollView *scrollView = [UIScrollView new];
        [self.view addSubview:scrollView];
        _smallScrollView = scrollView;
        _smallScrollView.delegate = self;
        _smallScrollView.showsHorizontalScrollIndicator = NO;
        _smallScrollView.showsVerticalScrollIndicator = NO;
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
    self.view.backgroundColor = [UIColor grayColor];
    
    [self setScrollView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/** 设置scrollView */
- (void)setScrollView {


}



@end
