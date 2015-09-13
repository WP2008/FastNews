//
//  SDReplyViewController.m
//  新闻速递
//
//  Created by tarena on 15/9/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "SDReplyViewController.h"
#import "SDReplyCell.h"
#import "SDReplyHeader.h"
#import "SDCount.h"

@interface SDReplyViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *navigationBar;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (nonatomic, strong) SDReplyCell *prototypeCell;

@end

@implementation SDReplyViewController

static NSString *const identifier = @"replyCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.backgroundColor = GlobalColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}



- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark -  返回按钮
- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.replys.count == 0) {
        return 1;
    }
    return self.replys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   SDReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (self.replys.count == 0) {
        UITableViewCell *cell2 = [[UITableViewCell alloc]init];
        cell2.textLabel.text = @"     暂无跟帖数据";
        return cell2;
    }else{
        SDReplyModel *model = self.replys[indexPath.row];
        cell.replyModel = model;
    }
    
    return cell;

  
}

//* 返回一个view来当tbv的header 
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
        return [SDReplyHeader replyViewFirst];
  
}
//
///** 通过提前计算来返回行高 */
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if(self.replys.count == 0){
//        return 40;
//    }else{
//        
//        
//        SDReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier ];
//
//
//        SDReplyModel *model = self.replys[indexPath.row];
//        
//        cell.replyModel = model;
//        
//        [cell layoutIfNeeded];
//        //获取自动布局后的尺寸
//        CGSize size = [cell.sayLabel systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//        
//        return cell.sayLabel.frame.origin.y + size.height + 10;
//    }
//}

/** 预估行高，这个方法可以减少上面方法的调用次数，提高性能 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 130;
}

@end
