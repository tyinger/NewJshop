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
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/shopCart/countShopCartNum?" parameters:@{@"userId":[LoginStatus sharedManager].userId} isShowHUD:YES httpToolSuccess:^(id json) {
        if ([json[@"status"] boolValue]) {
            
            self.totalNum = @([json[@"count"] integerValue]);
        }
        
} failure:^(NSError *error) {
        
    }];
}
- (void)addGood:(GoodModel *)modelToCart{
    
}
@end
