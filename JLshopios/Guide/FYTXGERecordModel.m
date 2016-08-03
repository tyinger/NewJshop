//
//  FYTXGERecordModel.m
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import "FYTXGERecordModel.h"
#import "FYTXGuideVersion.h"
#import "FYTXGuideConst.h"



@implementation FYTXGERecordModel



+(void) saveOpenFlag
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:FYTXGuide_HiddenFlag];
    [userDefaults synchronize];
}




+(BOOL) isHiddenFYTXGuide
{
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL result = [userDefaults boolForKey:FYTXGuide_HiddenFlag];
    return result;
}






@end


