//
//  CartManager.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodModel.h"
@interface CartManager : NSObject
{
    @public
    NSNumber * _cartGoodNum;
}
+ (CartManager *)sharedManager;
//商品种类数
@property (nonatomic, strong) NSNumber * cartGoodNum;

//购物车总数 ： 每种商品个数 * 种类数 （后台返回，即购物车总数）
@property (nonatomic, strong) NSNumber * totalNum;

//加入购物车方法
- (void)addGood:(GoodModel*)modelToCart;
@end
