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
- (void)getCartGoodCount{

    /*
     https://123.56.192.182:8443</item>
     <item>/app/shopCart/</item>
     <item>countShopCartNum?
     */
    NSString * idStr = [LoginStatus sharedManager].idStr;
//    NSString * idStr  = @"37";
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/shopCart/countShopCartNum?" parameters:@{@"userId":idStr} isShowHUD:YES httpToolSuccess:^(id json) {
        if ([json[@"status"] boolValue]) {
            
            self.totalNum = @([json[@"count"] integerValue]);
        }
        
} failure:^(NSError *error) {
//    TTAlert(@"网络请求失败");
    [FYTXHub toast:@"网络请求失败"];
    }];
}
- (void)addGood:(GoodModel *)modelToCart{
    
}
- (void)updateCartGoodNum:(NSString *)number ID:(NSString *)ID :(void(^)(void))success :(void(^)(void))failure{
    /*
     <item>https://123.56.192.182:8443</item>
     <item>/app/shopCart/</item>
     <item>updateShopCartNum?</item>
     
     id, num
     id为购物车列表的id，不是商品id
     num是数量
     */
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:TTKeyWindow() animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"请求中";
    NSDictionary * para = @{@"id":ID,@"num":number};
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/shopCart/updateShopCartNum?" parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
        [self getCartGoodCount];
        if (success) {
            success();
        }
          [MBProgressHUD hideHUDForView:TTKeyWindow() animated:YES];
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}
- (void)deleteWholeGoodWith:(NSString *)ID :(void(^)(void))success :(void(^)(void))failure{
    /*
     <item>https://123.56.192.182:8443</item>
     <item>/app/shopCart/</item>
     <item>deleteShopCart?</item>
     id
     */
  
    NSDictionary * para = @{@"id":ID};
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/shopCart/deleteShopCart?" parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
        [self getCartGoodCount];
        if (success) {
            success();
        }
      
    } failure:^(NSError *error) {
        if (failure) {
            failure();
        }
    }];
}

- (void)followActionType:(FollowType)type ID:(NSString *)Id isFollow:(BOOL)isFollow :(void(^)(id))success :(void(^)(id))failure{
    /*
     关注商品   goodsId，userId
     <item>https://123.56.192.182:8443</item>
     <item>/app/favorite/</item>
     <item>saveFavoriteGoods?</item>
     取消关注 商品
     <item>https://123.56.192.182:8443</item>
     <item>/app/favorite/</item>
     <item>deleteFavoriteGoods?</item>
     
     
     关注shop   shopId，userId
     <item>https://123.56.192.182:8443</item>
     <item>/app/favorite/</item>
     <item>saveFavoriteShop?</item>
     取消关注 shop
     <item>https://123.56.192.182:8443</item>
     <item>/app/favorite/</item>
     <item>deleteFavoriteShop?</item>
     */
    NSString         * urlString;
    NSDictionary     * parameter;
    NSString * userID = [LoginStatus sharedManager].idStr;
//    NSString * userID = @"37";
    if (type == FollowTypeGood) {
        parameter = @{@"goodsId":Id,@"userId":userID};
        urlString =isFollow? @"https://123.56.192.182:8443/app/favorite/saveFavoriteGoods?":@"https://123.56.192.182:8443/app/favorite/deleteFavoriteGoods?";
        
    }else{
         parameter = @{@"shopId":Id,@"userId":userID};
         urlString =isFollow? @"https://123.56.192.182:8443/app/favorite/saveFavoriteShop?":@"https://123.56.192.182:8443/app/favorite/deleteFavoriteShop?";
    }
    
    
    [QSCHttpTool get:urlString parameters:parameter isShowHUD:YES httpToolSuccess:^(id json) {
        if (success) {
            success(json);
        }
//        [FYTXHub success:@"关注成功" delayClose:1.5];
    } failure:^(NSError *error) {
//           [FYTXHub toast:@"关注失败"];
        if (failure) {
            failure(error);
        }
        
    }];
}
//暂不实现
- (void)deleteGoodWithID:(NSString *)goodId{
    
}
@end
