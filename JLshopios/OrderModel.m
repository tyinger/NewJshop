//
//  OrderModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "OrderModel.h"

@implementation OrderModel
- (instancetype)initWithData:(id)data{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:data];
    }
    return self;
}
@end
