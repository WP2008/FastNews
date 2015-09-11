//
//  SDNewsTableViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDNewsTableViewController.h"
#import "SDNetWorkTool.h"
#import "SDNewsModel.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "MBProgressHUD+MJ.h"

typedef NS_ENUM(NSUInteger, SDLoadDataType) {
    SDLoadNewData,
    SDLoadMoreData,
};


@interface SDNewsTableViewController ()

/**   */
@property(nonatomic,strong) NSMutableArray *arrayList;
@end

@implementation SDNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
   
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

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//
//    return self.arrayList.count;;
//}


//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
