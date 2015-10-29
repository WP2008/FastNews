//
//  AppDelegate.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
/*
 适配ios9
 在info.plist的NSAppTransportSecurity下新增NSAllowsArbitraryLoads并设置为YES，指定所有HTTP连接都可正常请求
 
 <key>NSAppTransportSecurity</key>
 <dict>
   <key>NSAllowsArbitraryLoads</key>
   <true/>
 </dict>
 
 */

#import "AppDelegate.h"
#import "SDNavigationController.h"
#import "SDMainViewController.h"
#import "SDLeftViewController.h"
#import "MMDrawerController.h"
#import "SDCount.h"

#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialQQHandler.h"


#define UmengAppkey @"5630737b67e58e61c2003c41"

#define WeChatAppId @"wxac8c5c31fb2ea998"
#define WeChatAppSecret @"d4624c36b6795d1d99dcf0547af5443d"

#define SinaSSOAppKey @"2665118745"
#define SinaSSOAppSecret @"2a5fed3f0fb0394317b3526edd5a2941"

#define QQAppId @"1104858253"
#define QQappKey @"KnkDAccxURtx56Sn"


@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
    });
    
   
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];

     UIColor * tintColor = [UIColor whiteColor];
    [self.window setTintColor:tintColor];
     self.window.backgroundColor = tintColor;
    
    [self.window makeKeyAndVisible];
    
    SDMainViewController *mainVC = [[SDMainViewController alloc]init];
    SDNavigationController *mainNavi = [[SDNavigationController alloc]initWithRootViewController:mainVC];
    SDLeftViewController *leftVC = [[SDLeftViewController alloc]init];
    
    
    self.drawerController  = [[MMDrawerController alloc] initWithCenterViewController:mainNavi leftDrawerViewController:leftVC];
    
    
    [self.drawerController setShowsShadow:YES];
    
   // [self.drawerController setMaximumRightDrawerWidth:200.0];
    [self.drawerController setMaximumLeftDrawerWidth:leftDrawerWidth];
    //设置 动画效果 不拉伸
    self.drawerController.shouldStretchDrawer = NO;
    // 所有的视图都能打卡关闭抽屉
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
    
    // 设置视觉效果的block
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         UIViewController * sideDrawerViewController = drawerController.leftDrawerViewController;
         
         [sideDrawerViewController.view setAlpha:percentVisible];
       
    
     }];
    
    // 设置可以点击否
//    [self.drawerController setGestureShouldRecognizeTouchBlock:^BOOL(MMDrawerController *drawerController, UIGestureRecognizer *gesture, UITouch *touch) {
//        
//      return YES;
//    }];
//    

    self.window.rootViewController = self.drawerController;
    
    
    
#pragma mark -  集成友盟
    //集成友盟 SDK
    [UMSocialData setAppKey:UmengAppkey];
     // 打开调试log开关 
    [UMSocialData openLog:YES];

    // 设置微信的app ID 设置分享的url 默认使用友盟的网站

    [UMSocialWechatHandler setWXAppId:WeChatAppId  appSecret:WeChatAppSecret url:@"http://www.umeng.com/social"];
    
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:SinaSSOAppKey RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialQQHandler setQQWithAppId:QQAppId appKey:QQappKey url:@"http://www.umeng.com/social"];
    
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url];
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
