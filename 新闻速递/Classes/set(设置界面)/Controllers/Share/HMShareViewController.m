//
//  HMShareViewController.m
//  Demo_彩票_HM
//
//  Created by tarena on 15/8/17.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HMShareViewController.h"
#import <MessageUI/MessageUI.h>

@interface HMShareViewController ()<MFMessageComposeViewControllerDelegate,MFMailComposeViewControllerDelegate>

@end

@implementation HMShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self addGroup0]; 
    
}

- (void)addGroup0 {
    
    // 🐷设置跳转的控制器
    WPSettingArrowItem *sina = [WPSettingArrowItem itemWithTitle:@"新浪分享" icon:@"WeiboSina"];
    WPSettingArrowItem *sms = [WPSettingArrowItem itemWithTitle:@"短信分享" icon:@"SmsShare"];
    

    // block 循环引用 
    __weak typeof (self)share = self;
    sms.option = ^{
        
        if (![MFMessageComposeViewController canSendText]) return ;
        // 发送短信🐷
        MFMessageComposeViewController *vc = [[MFMessageComposeViewController alloc]init];
        // 设置短信内容
        vc.body = @"吃饭了没？";
        // 设置收件人列表
        vc.recipients = @[@"10010", @"02010010"];
        // 设置代理
        vc.messageComposeDelegate = share;
        
        // 显示控制器
        [share presentViewController:vc animated:YES completion:nil];

    };
    
    
    WPSettingArrowItem *mail = [WPSettingArrowItem itemWithTitle:@"邮件分享" icon:@"MailShare" ];
    
    mail.option = ^{
    
      //   用自带的邮件客户端，发完邮件后不会自动回到原应用
        NSURL *url = [NSURL URLWithString:@"mailto://10010@qq.com"];
        [[UIApplication sharedApplication] openURL:url];

        if (![MFMailComposeViewController canSendMail]) return ;
        MFMailComposeViewController *vc = [[MFMailComposeViewController alloc]init];
        // 主题
        [vc setSubject:@"会议"];
        // 邮件内容
        [vc setMessageBody:@"今天下午开会吧" isHTML:NO];
        // 设置收件人列表
        [vc setToRecipients:@[@"1137974218@qq.com"]];
        // 设置抄送人
        [vc setCcRecipients:@[@"1137974218@qq.com"]];
        // 设置密抄送人
        [vc setBccRecipients:@[@"1137974218@qq.com"]];
        // 设置代理
        vc.mailComposeDelegate = self;
        
        
        //添加附件   －－ 》 NSData
        UIImage *image = [UIImage imageNamed:@"sdaf"];
        NSData *data = UIImagePNGRepresentation(image);
        [vc addAttachmentData:data mimeType:@"image/png" fileName:@"sdaf"];
        
        
    
    };
    
    
    WPSettingGroup *group0 = [WPSettingGroup new];
    group0.items = @[sina,sms,mail];
    [self.dataList addObject:group0];
    
}


// 当取消发送短信的时候就会调用
- (void) messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

// 邮件发送后的代理方法回调，发完后会自动回到原应用
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // 关闭邮件界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    if (result == MFMailComposeResultCancelled) {
        NSLog(@"取消发送");
    } else if (result == MFMailComposeResultSent) {
        NSLog(@"已经发出");
    } else {
        NSLog(@"发送失败");
    }
}

@end
