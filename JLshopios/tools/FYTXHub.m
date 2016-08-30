//
//  NDHub.m
//  uulife
//
//  Created by lenew on 15/10/13.
//  Copyright © 2015年 danniu. All rights reserved.
//

#import "FYTXHub.h"


static UIImage *defaultErrorImage;
static UIImage *defaultSuccessImage;
static UIImage *defaultInfoImage;

@implementation FYTXHub


+(void)load{
    
    NSBundle *bundle = [NSBundle bundleForClass:[SVProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"SVProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    defaultInfoImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"info" ofType:@"png"]];
    defaultSuccessImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]];
    defaultErrorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
}

+(void)toast:(NSString *)message{
    if (message == nil) {
        message = @"";
    }
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, [UIScreen mainScreen].bounds.size.width * .4 )];
    [SVProgressHUD setErrorImage:nil];
    [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    [SVProgressHUD showErrorWithStatus:message];
}

+(void)progress:(NSString *)message{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    [SVProgressHUD setOffsetFromCenter:UIOffsetMake(0, 0 )];
    
    [SVProgressHUD showProgress:-1 status:message maskType:SVProgressHUDMaskTypeBlack];
}

+(void)dismiss{
    
    [SVProgressHUD dismiss];
}

+(void)success:(NSString *)message delayClose:(NSInteger)section{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, section * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}
+(void)successDarkStyle:(NSString *)message delayClose:(NSInteger)second{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:message];
//    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, second * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

+(void)success:(NSString *)message delayClose:(NSInteger)section compelete:(void(^)())compelete{
    
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:message];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, section * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (compelete) {
            compelete();
        }
    });
}

@end
