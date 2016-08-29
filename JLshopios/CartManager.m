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
    TTAlert(@"网络请求失败");
    }];
}
- (void)addGood:(GoodModel *)modelToCart{
    
}
- (void)updateCartGoodNum:(NSString *)number ID:(NSString *)ID :(void(^)(void))success :(void(^)(void))faile{
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
        if (faile) {
            faile();
        }
    }];
}
- (void)deleteWholeGoodWith:(NSString *)ID :(void(^)(void))success :(void(^)(void))faile{
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
        if (faile) {
            faile();
        }
    }];
}
@end
