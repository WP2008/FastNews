//
//  SDPhoneLoginViewController.m
//  新闻速递
//
//  Created by WP on 15/10/28.
//  Copyright © 2015年 tarena. All rights reserved.
//

#import "SDPhoneLoginViewController.h"
#import "SDCount.h"
#import "MBProgressHUD+MJ.h"

@interface SDPhoneLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@end

@implementation SDPhoneLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)phoneNumTFExit:(id)sender {
    
    [self.pwdTF becomeFirstResponder];
    
}

- (IBAction)pwdTFExit:(id)sender {
    [self loginBtn:sender];
    
}


- (IBAction)loginBtn:(id)sender {
    
    
    // 0.判断用户名密码是否符合要求
    if (self.phoneNumTF.text.length < 11 || self.pwdTF.text.length <= 6) {
        [MBProgressHUD showError:@"请输入正确的用户名或密码"];
        return;
    }
    
    // 1.隐藏键盘
    [self.view endEditing:YES];
    
    // 2.将帐号密法 发送给server  并给出提示  这个也可以调用 工具类进行操作
    [MBProgressHUD showMessage:@"正在登录中...." toView:self.view];
    
    
    
    // 3.判断登录状态
    /*
     成功 记录登录状态 到单例user 保存到沙盒 
         切换的 主界面 注意线程
     */
    
    
    
}

@end
