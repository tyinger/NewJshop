//
//  FYTXGuide.h
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYTXGuideFactory.h"
#import "FYTXGEViewProtocol.h"


@interface FYTXGuide : NSObject


/**
 *  隐藏功能介绍页
 *
 *  @return yes 表示不用加载功能介绍页  NO表示要显示
 */
+(BOOL) isHiddenFYTXGuide;


+(NSString *)version;

@end


