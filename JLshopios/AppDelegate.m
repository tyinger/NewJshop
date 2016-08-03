//
//  AppDelegate.m
//  JLshopios
//
//  Created by daxiongdi on 16/6/4.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+FYTXDataBase.h"
#import "AppDelegate+FYTXEntrance.h"
#import "AppDelegate+FYTXUI.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    {
//        //统计
//        
//        [self openAppWithAPNS:[launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey]];
//    }
//    
//    
//    //启动个推
//    {
//        [FYPushNotification startWithLaunchOptions:launchOptions];
//    }
//    
//    //友盟启动
//    {
//        [FYTXAnalytics start];
//    }
//    
//    
//    {
//        //启动网络
//        _internetReachability = [Reachability reachabilityWithHostname:FYTXC_DefaultConfig_CheckNetAddress];
//        [_internetReachability startNotifier];
//    }
//    
//    //启动友盟
//    {
//        [FYTXSNSShare start];
//    }
//    
//    
//    //启动 bugly
//    {
//        [self openBugly];
//    }
//    
//    
//    
//    //清理 WebView Cache
//    {
//        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    }
//    
//    //设置UA
//    {
//        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
//        NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
//        NSString *newAgent = [oldAgent stringByAppendingString:@" /FangYanTianXia/1.0.3"];
//        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:newAgent, @"UserAgent", nil];
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//    }
//
//    
//    [self loadBaseService];
//    //APP入口 从加载导航开始
//    [self loadAppGuide];
//    [self initAppUI];
//    
//    {
//        //把没上传完的视频 加入
//        FYTXDBUserInfoModel *userinfoDB=[FYTXDBUserInfoModel currentUserInfo];
//        NSString *userid= userinfoDB.userId;
//        [FYTXUVReUploadManager reUploadWithUserid:userid];
//    }
//    
//    
//    //启动IM
//    [FYTXMessageSystem start];
//
//    
//    
//#pragma mark 统计启动
//    [FYTXStatisticsInfoReport appStart];
//    
//    
    [self loadAppGuide];
    
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
