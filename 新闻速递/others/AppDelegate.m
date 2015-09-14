//
//  AppDelegate.m
//  新闻速递
//
//  Created by tarena on 15/9/11.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "SDNavigationController.h"
#import "SDMainViewController.h"
#import "SDLeftViewController.h"
#import "MMDrawerController.h"

@interface AppDelegate ()

@property (nonatomic,strong) MMDrawerController * drawerController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.window makeKeyAndVisible];
    
    
    SDMainViewController *mainVC = [[SDMainViewController alloc]init];
    SDNavigationController *mainNavi = [[SDNavigationController alloc]initWithRootViewController:mainVC];
 
    
    SDLeftViewController *leftVC = [[SDLeftViewController alloc]init];
    SDNavigationController *leftNavi = [[SDNavigationController alloc]initWithRootViewController:leftVC];

    self.drawerController  = [[MMDrawerController alloc] initWithCenterViewController:mainNavi leftDrawerViewController:leftNavi];
    
    [self.drawerController setShowsShadow:YES];
    [self.drawerController setMaximumRightDrawerWidth:200.0];
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

    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.drawerController;
    
    
    return YES;
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
