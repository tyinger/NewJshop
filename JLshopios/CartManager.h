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
    NSNumber * _totalNum;
}
+ (CartManager *)sharedManager;
#pragma mark - PROPERTY
//商品种类数
@property (nonatomic, strong) NSNumber * cartGoodNum;

//购物车总数 ： 每种商品个数 * 种类数 （后台返回，即购物车总数）
@property (nonatomic, strong) NSNumber * totalNum;
#pragma mark - METHOD
//查询购物车数量
- (void)getCartGoodCount;
//加入购物车方法
- (void)addGood:(GoodModel*)modelToCart;
//删除整个商品
- (void)deleteWholeGoodWith:(NSString *)ID :(void(^)(void))success :(void(^)(void))faile;
//根据ID删除某一个商品
- (void)deleteGoodWithID:(NSString *)goodId;
//更新购物车中的商品数量
- (void)updateCartGoodNum:(NSString *)number ID:(NSString*)ID :(void(^)(void))success :(void(^)(void))faile ;


@end
