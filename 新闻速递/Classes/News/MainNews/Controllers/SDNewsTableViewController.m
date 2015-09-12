//
//  SDNewsTableViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDNewsTableViewController.h"
#import "SDNetWorkTool.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"
#import "SDCount.h"

#import "SDNewsModel.h"
#import "SDNewsCell.h"

#import "SDDetailViewController.h"

typedef NS_ENUM(NSUInteger, SDLoadDataType) {
    SDLoadNewData,
    SDLoadMoreData,
};


@interface SDNewsTableViewController ()

/**   */
@property(nonatomic,strong) NSMutableArray *arrayList;

@property(nonatomic,getter=isFirstUpload)BOOL firstUpload;

@end

@implementation SDNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
//    [self.tableView setHeaderPullToRefreshText:@"拉我, 要文速递"];
    [self.tableView setHeaderRefreshingText:@"正在搜索新鲜资讯"];
//    [self.tableView setHeaderReleaseToRefreshText:@""];
     [self.tableView setFooterRefreshingText:@"给你讲以前的故事"];

    self.firstUpload = YES;
    
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
#warning  第一次滑动到这个view时 才调用
  
    if (self.isFirstUpload) {
        [self.tableView headerBeginRefreshing];
        self.firstUpload = NO;
        
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark -  刷新数据的方法
// ------下拉刷新
- (void)loadData
{
    
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataForType:SDLoadNewData WithURLString:allUrlstring];

}

// ------上拉加载
- (void)loadMoreData
{
    NSString *allUrlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
    [self loadDataForType:SDLoadMoreData WithURLString:allUrlstring];
}

// ------公共方法
- (void)loadDataForType:(SDLoadDataType)type WithURLString:(NSString *)urlStr {

    // http://c.m.163.com//nc/article/list/T1348649654285/0-20.html
    // http://c.m.163.com/photo/api/set/0096/57255.json
    // http://c.m.163.com/photo/api/set/54GI0096/57203.html
 
[[SDNetWorkTool sharedNetworkTool]GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
    
    NSString *key = [responseObject.keyEnumerator nextObject]; // 获取字典中得 key
    NSArray *temArray = responseObject[key];
    
    NSMutableArray *arrayM = [SDNewsModel objectArrayWithKeyValuesArray:temArray];
    
    
#warning 注意线程  主线程
    
    if (type == SDLoadNewData) {
        self.arrayList = arrayM;
        [self.tableView headerEndRefreshing];
        [self.tableView reloadData];
    }else if(type == SDLoadMoreData){
        [self.arrayList addObjectsFromArray:arrayM];
        [self.tableView footerEndRefreshing];
        [self.tableView reloadData];
    }
    
} failure:^(NSURLSessionDataTask *task, NSError *error) {
    
        [MBProgressHUD showError:@"加载失败，请稍候再试"];
}];


}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDNewsModel *newsModel = self.arrayList[indexPath.row];
    
    // 获取对应的cellID
    NSString *ID = [SDNewsCell idForRow:newsModel];
    
    if ((indexPath.row%20 == 0) && (indexPath.row != 0)) {
        ID = @"NewsCell";
    }
    
    SDNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    cell.NewsModel = newsModel;
    
    return cell;
    
}


#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    SDNewsModel *newsModel = self.arrayList[indexPath.row];
    
    CGFloat rowHeight = [SDNewsCell heightForRow:newsModel];
    
    if ((indexPath.row%20 == 0)&&(indexPath.row != 0)) {
        rowHeight = 80;
    }
    
    return rowHeight;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
     NSInteger x = self.tableView.indexPathForSelectedRow.row;
    SDNewsModel *selectedNews = self.arrayList[x];

    if ([segue.destinationViewController isKindOfClass:[SDDetailViewController class]]) {
        SDDetailViewController *detailVC =  segue.destinationViewController;
        detailVC.newsModel = selectedNews;
        detailVC.index = self.index;
        
        if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
        }
    } else {
    
    
    
    }

    
}





@end
