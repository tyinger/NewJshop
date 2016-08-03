//
//  FYTXGERecordModel.h
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

/**
 *  这里存储 打开过的日志和版本
 */

#import <Foundation/Foundation.h>

@interface FYTXGERecordModel : NSObject


/**
 *  记录打开过的标志(保存了被打开过的版本号)
 */
+(void) saveOpenFlag;

+(BOOL) isHiddenFYTXGuide;

@end




