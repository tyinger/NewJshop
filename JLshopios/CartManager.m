//
//  CartManager.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "CartManager.h"

@implementation CartManager
+ (CartManager *)sharedManager{
    
    static CartManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
}
@end
