//
//  CartManager.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//
typedef NS_ENUM(NSUInteger, FollowType) {
    FollowTypeGood  = 0,
    FollowTypeShop  = 1,
    
};
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
/**
 *      更新购物车中的商品数量
 *
 *  @param number  the number after update
 *  @param ID      ID of the good
 *  @param success call back when success
 *  @param faile   like up ...
 */
- (void)updateCartGoodNum:(NSString *)number ID:(NSString*)ID :(void(^)(void))success :(void(^)(void))failure ;
/**
 *  查询购物车数量 
 */
- (void)getCartGoodCount;
//删除整个商品
- (void)deleteWholeGoodWith:(NSString *)ID :(void(^)(void))success :(void(^)(void))failure;
/**
 *  关注或取消关注
 *
 *  @param type     关注的类型 ： FollowTypeGood  or  FollowTypeShop
 *  @param Id       关注的ID
 *  @param isFollow  关注（True） or 取消关注（False）
 *  成功返回json  失败返回error  如无需操作 可以传nil
 *  没有加入HUD 可在block中添加
 */
- (void)followActionType:(FollowType)type ID:(NSString*)Id isFollow:(BOOL)isFollow :(void(^)(id))success :(void(^)(id))failure;


//加入购物车方法
- (void)addGood:(GoodModel*)modelToCart;


//根据ID删除某一个商品
- (void)deleteGoodWithID:(NSString *)goodId;



@end
