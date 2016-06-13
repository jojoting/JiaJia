//
//  AppDelegate.m
//  JiaJia
//
//  Created by jojoting on 16/4/7.
//  Copyright © 2016年 jojoting. All rights reserved.
//

#import "AppDelegate.h"

//View Controller
#import "JJHomeViewController.h"
#import "JJGuideViewController.h"
//vendor
#import <AMapNaviKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import <BmobSDK/Bmob.h>

//configuration
#import "JJMapAPIKey.h"
#import "JJBmobKey.h"
#import "JJGlobal.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/**
 *  配置高德地图API
 */
- (void)configureMapAPI{
    
    if (0 == [APIKey length]) {
        NSLog(@"找不到map api key");
        return;
    }
    
    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
    [AMapSearchServices sharedServices].apiKey = (NSString *)APIKey;
    [AMapNaviServices sharedServices].apiKey = (NSString *)APIKey;
}

/**
 *  配置bmob
 */
- (void)configureBmobKey{
//    if (0 == [BmobKey length]) {
//        NSLog(@"找不到bmob key");
//        return;
//    }
//    
    [Bmob registerWithAppKey:@"085551f4764d18bb2e895a81ad0f378c"];
}

- (void)showHomeViewController:(NSNotification *)notify{
    JJHomeViewController *homeViewController = [[JJHomeViewController alloc] init];
    UINavigationController *mainNavigationController = [[UINavigationController alloc] initWithRootViewController:homeViewController];
    [mainNavigationController.navigationBar setTintColor:[UIColor whiteColor]];
    mainNavigationController.navigationBar.barTintColor = MAIN_COLOR;
    mainNavigationController.navigationBar.translucent = YES;
    mainNavigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = mainNavigationController;
    [self.window makeKeyAndVisible];

}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self configureMapAPI];
    [self configureBmobKey];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHomeViewController:) name:NOTIFICATION_GUIDE object:nil];
    
    NSString * key = @"CFBundleVersion";
    NSString * lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    NSString * currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
//    
//    if([currentVersion isEqualToString:lastVersion]) {
//        //加载首页
//        [self showHomeViewController:nil];
////    } else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.rootViewController = [[JJGuideViewController alloc]init];
        [self.window makeKeyAndVisible];
//    }

    
    // Override point for customization after application launch.
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
