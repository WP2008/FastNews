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
#import "SDHTTPManager.h"

#import "Masonry.h"
#import "UIView+Extension.h"
#import "SDCount.h"


#import "SDWeatherModel.h"
#import "SDWeatherView.h"
#import "SDWeatherDetailVC.h"

#import "MJExtension.h"

#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"

@interface SDMainViewController ()<UIScrollViewDelegate , SDWeatherViewDelegate,UIGestureRecognizerDelegate>

/** 标题栏 */
@property (weak, nonatomic)  UIScrollView *smallScrollView;

/** 下面的内容栏 */
@property (weak, nonatomic)  UIScrollView *bigScrollView;

/** 新闻接口的数组 */
@property(nonatomic,strong) NSArray *arrayLists;

@property (nonatomic, strong) UIButton *rightItemBtn;

/** 天气部分 */
@property(nonatomic,strong)SDWeatherModel *weatherModel;
@property(nonatomic,assign,getter=isWeatherShow)BOOL weatherShow;
@property(nonatomic,strong)SDWeatherView *weatherView;
@property(nonatomic,strong)UIImageView *showAtHere;



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
        _smallScrollView.backgroundColor = [UIColor whiteColor];
        _smallScrollView.bounces = NO;
        
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
        _bigScrollView.bounces = NO;
        _bigScrollView.backgroundColor = [UIColor colorWithWhite:0.947 alpha:1.000];
    }
    
    return _bigScrollView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
  
    [self addNaviItem];
    
    [self setupLeftMenuButton];
    
    
    [self addNewsController];
    [self addLable];
    [self setScrollView];
    // 获取天气数据
    [self sendWeatherRequest];
    
    
    self.title = @"新闻速递";

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark  -  设置控件

- (void)addNaviItem {
    
    UIView *customView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:customView];
    UIButton *rightItem = [[UIButton alloc]init];
     rightItem.width = 35 ;
     rightItem.height = 35;
    [customView addSubview:rightItem];
    [rightItem addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightItem setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];

    self.rightItemBtn = rightItem;
 

}

-(void)setupLeftMenuButton{
    MMDrawerBarButtonItem * leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}


/** 添加子控制器 */
- (void)addNewsController {
    for (int i=0 ; i<self.arrayLists.count ; i++){
        SDNewsTableViewController *newsVC  = [[UIStoryboard storyboardWithName:@"SDNews" bundle:[NSBundle mainBundle]] instantiateInitialViewController];
;
        newsVC.title = self.arrayLists[i][@"title"];
        newsVC.urlString = self.arrayLists[i][@"urlString"];
        newsVC.index = i;
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
        CGFloat topH = self.topLayoutGuide.length;
        
#warning TODO 怎么获取导航的高度
        make.top.equalTo(@(64));
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
    
    
    //添加手势
    UISwipeGestureRecognizer *swipeGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeToShowLeftView:)];
    swipeGestureRecognizer.delegate = self;
    swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [vc.view addGestureRecognizer:swipeGestureRecognizer];
    
    //设置label
    SDTitleLabel *lable = [self.smallScrollView.subviews firstObject];
    lable.scale = 1.0;
  
}

/** 向右拖的效果 */
- (void)swipeToShowLeftView:(UISwipeGestureRecognizer *)swipe {

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

// 代理完成 多个手势并存
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}



/** 标题栏label的点击事件 */
- (void)lblClick:(UITapGestureRecognizer *)recognizer
{
    SDTitleLabel *titlelable = (SDTitleLabel *)recognizer.view;
    
    CGFloat offsetX = titlelable.tag * self.bigScrollView.width;
    
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
    
    // 当前要滚动到的地方
    CGFloat offsetX =  titleLable.centerX - _smallScrollView.centerX;
    CGFloat offsetMax = _smallScrollView.contentSize.width - _smallScrollView.width;
    if (offsetX < 0) {
        offsetX = 0;
    } else if (offsetX > offsetMax)
    {
        offsetX = offsetMax;
    }

    CGPoint offset = CGPointMake(offsetX, 0);
    [_smallScrollView setContentOffset:offset animated:YES];
    
    
    
    // 添加控制器的视图
    SDNewsTableViewController *newsVC = self.childViewControllers[index];
    if(newsVC.view.superview != nil) return;
    newsVC.view.frame = scrollView.bounds; // bounds 时当时 scrollView显示 的区域
    [self.bigScrollView addSubview:newsVC.view];
    
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
    
   // Log(@"value = %f,leftIndex = %lu,rightIndex = %lu",value,leftIndex,(unsigned long)rightIndex);
   // Log(@"scaleRight = %f",scaleRight);
    // 取出要操控的对象
    SDTitleLabel *labelLeft = self.smallScrollView.subviews[leftIndex];
    labelLeft.scale = scaleLeft;
    
    // 考虑到最后一个板块，如果右边已经没有板块了
    if (rightIndex < self.smallScrollView.subviews.count) {
        SDTitleLabel *labelRight = self.smallScrollView.subviews[rightIndex];
        labelRight.scale = scaleRight;
    }


}


#pragma mark - 天气界面的处理
- (void)sendWeatherRequest
{
    NSString *url =  ;
    [[SDHTTPManager manager]GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        
        //Log(@"%@",responseObject);
        SDWeatherModel *weatherModel = [SDWeatherModel objectWithKeyValues:responseObject];
        
        self.weatherModel = weatherModel;     
       [self addWeather];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"failure %@",error);
    }];
}


/** 添加天气信息 */
- (void)addWeather{
    
    // 设置天气界面
    SDWeatherView *weatherView = [SDWeatherView view];
    weatherView.delegate  =  self;
    weatherView.weatherModel = self.weatherModel;
    self.weatherView = weatherView;
    weatherView.alpha = 0.9;
    
    // 添加到window 的第一个view上 就一定是最上面
    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
    [win addSubview:weatherView];
    weatherView.frame = [UIScreen mainScreen].bounds;
    weatherView.y = 64;
    weatherView.height -= 64;
    self.weatherView.hidden = YES;
    
#warning 这是一个指示器 都放在 最上面
    // 设置一个图标指示器
    UIImageView *showAtHere = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"224"]];
    self.showAtHere = showAtHere;
    showAtHere.width = 7;
    showAtHere.height = 7;
    showAtHere.y = 57;
    showAtHere.x = [UIScreen mainScreen].bounds.size.width - 45;
    [win addSubview:showAtHere];
    
    self.showAtHere.hidden = YES;
       
}      



#pragma mark - Button click
-(void)leftDrawerButtonPress:(id)sender{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


/** 右侧按钮的点击事件*/
- (void)rightItemClick:(UIButton *)button {
    
    if (self.isWeatherShow) {
        // 隐藏天气页面
        self.weatherView.hidden = YES;
        self.showAtHere.hidden = YES;
       
        
        [UIView animateWithDuration:0.1 animations:^{
            button.transform = CGAffineTransformRotate(button.transform, M_1_PI * 5);
            
        } completion:^(BOOL finished) {
            [button setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        }];
    

    } else {
        // 显示天气页面
        self.weatherView.hidden = NO;
        self.showAtHere.hidden = NO;
        
        //点击 后出发动画
        [self.weatherView addAnimate];
        
    [button setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];
        
        [UIView animateWithDuration:0.2 animations:^{
            button.transform = CGAffineTransformRotate(button.transform, -M_1_PI * 6);
            
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                button.transform = CGAffineTransformRotate(button.transform, M_1_PI );
            }];
        }];

        
    }
    
   
     self.weatherShow = !self.isWeatherShow;
}


- (void)setWeatherShow:(BOOL)weatherShow {
    _weatherShow = weatherShow;
    self.navigationItem.leftBarButtonItem.enabled = !_weatherShow;

    
}


#pragma mark - weatherView delegate

- (void)didClickWeatherView:(SDWeatherView *)weatherView {
    
    self.weatherShow = NO;
    SDWeatherDetailVC *wdvc = [[SDWeatherDetailVC alloc]init];
    wdvc.weatherModel = self.weatherModel;
    [self.navigationController pushViewController:wdvc animated:YES];
    
    
    [UIView animateWithDuration:0.1 animations:^{
        self.weatherView.alpha = 0;
    } completion:^(BOOL finished) {
        self.weatherView.alpha = 0.9;
        
        
        // 不用时 hidden
        self.weatherView.hidden = YES;
        self.showAtHere.hidden = YES;
       
        
        // 推出后设置一下按钮的状态
         self.rightItemBtn.transform = CGAffineTransformIdentity;
        [self.rightItemBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        
    }];
    
}



@end
