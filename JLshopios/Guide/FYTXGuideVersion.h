//
//  FYTXGuideVersion.h
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FYTXGuideVersion : NSObject

/**
 *  给外面看的版本
 *
 *  @return
 */
+(NSString *)version;


/**
 *  内部判断业务逻辑用的版本     这个版本会递增 而且是整形, 这个版本只有产品要求用户看心的产品介绍的时候才会递增。
 *
 *  @return
 */
+(NSInteger )guideVersion;


@end


