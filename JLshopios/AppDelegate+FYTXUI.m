//
//  AppDelegate+FYTXUI.m
//  FYTXMain
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import "AppDelegate+FYTXUI.h"

@implementation AppDelegate(FYTXUI)
-(void) initAppUI
{
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          nil]];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:FYTXConfigImageName_NavigationBar_BackGround] forBarMetrics:UIBarMetricsDefault];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

@end

