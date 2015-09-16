//
//  SDLeftViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDLeftViewController.h"
#import "MBProgressHUD+MJ.h"
#import "Masonry.h"
#import "UIImage+Tool.h"
#import "UIView+Extension.h"
#import "SDCount.h"
#import "UIViewController+MMDrawerController.h"



#import "SDSettingViewController.h"

@interface SDLeftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UIView *headerView;

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, weak) UIView *buttomView;

@end

@implementation SDLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    // 添加约束
    [self addConstraints];
    [self addHeaderButton];
    
     self.navigationController.navigationBarHidden = YES;

  
    
}

#pragma mark - lazy loading 

- (UIView *)headerView {
    if ( _headerView == nil) {
        UIView *view = [[UIView alloc]init];
        [self.view addSubview:view];
        _headerView.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.400];
        _headerView = view;

    }
    return _headerView;
}

//- (UIView *)buttomView {
//    if ( _buttomView == nil) {
//        UIView *view = [[UIView alloc]init];
//        [self.view addSubview:view];
//        
//        _buttomView = view;
//        _buttomView.backgroundColor = [UIColor redColor];
//    }
//    return _buttomView;
//}

- (UITableView *)tableView {
    if ( _tableView == nil) {
        UITableView *tableView = [[UITableView alloc]init];
        [self.view addSubview:tableView];
        _tableView = tableView;
        _tableView.opaque = YES;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
    }
    return _tableView;
}

#pragma mark - setView 

- (void)addConstraints {
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@120);
        
    }];
    
//    [self.buttomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.view.mas_left);
//        make.right.equalTo(self.view.mas_right);
//        make.bottom.equalTo(self.view.mas_bottom);
//        make.height.equalTo(@80);
//        
//    }];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.headerView.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        
        
    }];

}


- (void)addHeaderButton {
    
    
    /** 封装内部block 函数私有 */
    void(^myBlock)(NSString *,CGRect) = ^(NSString *imageName,CGRect frame){
        
        UIImage *image =[UIImage imageWithName:imageName border:0.5 borderColor:[UIColor grayColor]];
        UIButton *button = [[UIButton alloc]initWithFrame:frame];
        [button setImage:image forState:UIControlStateNormal];
        [self.headerView addSubview:button];
    
    };
    
    NSUInteger btnCount = 4;
    CGFloat btnW = leftDrawerWidth /btnCount;
    CGFloat btnH = btnW;
    CGFloat topMargin = 20;
    myBlock(@"pay_logo_weixin",CGRectMake(0, topMargin, btnH, btnW));
    myBlock(@"personal_qq",CGRectMake(btnW * 1, topMargin, btnH, btnW));
    myBlock(@"personal_sina",CGRectMake(btnW * 2, topMargin, btnH, btnW));
    myBlock(@"personal_weibo",CGRectMake(btnW * 3, topMargin, btnH , btnW));

    
    
}




#pragma mark - tabView delegate



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   static NSString *const identifier = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.opaque = YES;
    }
    
    
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"   新闻";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_news_highlight"];
            break;
        case 1:
            cell.textLabel.text = @"   阅读";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_reader_highlight"];
            break;
        case 2:
            cell.textLabel.text = @"   视听";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_media_highlight"];
            break;
        case 3:
            cell.textLabel.text = @"   发现";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_found_highlight"];
            break;
        case 4:
            cell.textLabel.text = @"   我";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_me_highlight"];
            break;
        case 5:
            cell.textLabel.text = @"   设置";
            cell.imageView.image = [UIImage imageNamed:@"tabbar_icon_me_highlight"];
            break;
            
        default:
            break;

    }
    
    return cell;
}



#warning TODO  推出的模式不是我想要的  自定义吗 ？
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 5) {
        SDSettingViewController *setingVC = [[SDSettingViewController alloc]init] ;
        
        UINavigationController *navi = (UINavigationController *)self.mm_drawerController.centerViewController;
        
        // self.modalTransitionStyle =
        
        
        [navi  pushViewController:setingVC animated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];

    }
    
//    UINavigationController *new = [[UINavigationController alloc]init];
//    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;

//    self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
//    [self presentViewController:setingVC animated:YES completion:nil];
}




@end
