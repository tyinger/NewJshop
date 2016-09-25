//
//  PayManager.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "GoodModel.h"
@interface PayManager : NSObject
+ (instancetype)manager;
- (RACCommand*)doAlipayPayWithGood:(GoodModel *)good;
@end
