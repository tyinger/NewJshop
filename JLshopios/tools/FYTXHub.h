//
//  NDHub.h
//  uulife
//
//  Created by lenew on 15/10/13.
//  Copyright © 2015年 danniu. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <SVProgressHUD/SVProgressHUD.h>

@interface FYTXHub : NSObject

+(void)progress:(NSString *)message;
+(void)toast:(NSString *)message;
+(void)success:(NSString *)message delayClose:(NSInteger)section;
+(void)success:(NSString *)message delayClose:(NSInteger)section compelete:(void(^)())compelete;
+(void)dismiss;

@end
