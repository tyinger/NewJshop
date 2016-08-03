//
//  FYTXGuide.m
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import "FYTXGuide.h"
#import "FYTXGERecordModel.h"

@implementation FYTXGuide


+(BOOL) isHiddenFYTXGuide
{
        return [FYTXGERecordModel isHiddenFYTXGuide];
}
//无url 和 通知消息

+(NSString *)version{
    
    return @"isHiddenFYTXGuide_version_v1.0.1";
    
}


@end




































































