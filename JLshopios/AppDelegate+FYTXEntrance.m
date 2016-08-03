//
//  AppDelegate+FYTXEntrance.m
//  FYTXMain
//
//  Created by tiger on 15/6/12.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import "AppDelegate+FYTXEntrance.h"
//#import "FYTXMainNavigationController.h"
#import "JLTabMainController.h"
#import "JLHomeViewController.h"

#import "JLGuideViewController.h"
#import "FYTXGuide.h"


@interface AppDelegate ()

@end

@implementation AppDelegate(FYTXEntrance)


-(void) loadAppGuide
{
    [self loadNotice];
    //开屏页
//    self.window.rootViewController = (UIViewController *)[FYTXFlashFactory flashView];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[JLTabMainController alloc]init];
    
    if ([FYTXGuide isHiddenFYTXGuide]) {
        self.window.rootViewController = [[JLTabMainController alloc]init];

    }else{
        self.window.rootViewController = [[JLGuideViewController alloc]init];
    }
    [self.window makeKeyAndVisible];
}

-(void)loadNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToMain) name:@"JLShopGuideFinishGoToMain" object:nil];
}

-(void)jumpToMain{
    self.window.rootViewController = [[JLTabMainController alloc]init];

}






















































@end
