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


@interface SDNewsTableViewController ()

/**   */
@property(nonatomic,strong) NSMutableArray *arrayList;
@end

@implementation SDNewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView addHeaderWithTarget:self action:@selector(loadData)];
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreData)];
    self.tableView.backgroundColor = [UIColor redColor];
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
    
    NSString *urlstring = [NSString stringWithFormat:@"/nc/article/%@/0-20.html",self.urlString];
    [self loadDataWithURLString:urlstring];

}

// ------上拉加载
- (void)loadMoreData
{
    NSString *urlstring = [NSString stringWithFormat:@"/nc/article/%@/%ld-20.html",self.urlString,(self.arrayList.count - self.arrayList.count%10)];
   [self loadDataWithURLString:urlstring];
}

// ------公共方法
- (void)loadDataWithURLString:(NSString *)urlStr {
    
    NSLog(@"%@",urlStr);
    // http://c.m.163.com//nc/article/list/T1348649654285/0-20.html
    // http://c.m.163.com/photo/api/set/0096/57255.json
    // http://c.m.163.com/photo/api/set/54GI0096/57203.html
    
    [[[AFHTTPSessionManager alloc]init]GET:@"c.m.163.com//nc/article/list/T1348649654285/0-20.html" parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        responseObject;
        
        NSString *key = [responseObject.keyEnumerator nextObject];
        NSArray *temArray = responseObject[key];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];

    
//    
//[[SDNetWorkTool sharedNetworkTool]GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//
//        responseObject;
//        
//        NSString *key = [responseObject.keyEnumerator nextObject];
//        NSArray *temArray = responseObject[key];
//    
//} failure:^(NSURLSessionDataTask *task, NSError *error) {
//    
//    
//}];


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
