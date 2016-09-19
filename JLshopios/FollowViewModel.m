
//
//  FollowViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "FollowViewModel.h"
#import "DetailsViewController.h"
@implementation FollowViewModel


- (void)goToDetailWithID:(NSString *)goodID{
    DetailsViewController * detail = [[DetailsViewController alloc] init];
    detail.productIDStr = goodID;
    [((UIViewController*)self.followViewController).navigationController pushViewController:detail animated:YES];
}
- (void)getData:(void (^)(id))comlicated{
    /*
    https://123.56.192.182:8443/app/favorite/listFavoriteGoods?userId=37&pageNo=1
     */
    [FYTXHub progress:@"正在加载"];
    [self.followGoodData removeAllObjects];
    //https://123.56.192.182:8443/app/shopCart/listShopCart?&userid=37
    NSString *  urlString = @"https://123.56.192.182:8443/app/favorite/listFavoriteGoods?";
//    NSString * idStr = [LoginStatus sharedManager].idStr;
         NSString * idStr =@"37";
    [QSCHttpTool get:urlString parameters:@{@"userid":idStr} isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        __block NSInteger totalCount = 0;
//        NSMutableArray * arr =[[[((NSArray*)json) rac_sequence map:^id(id value) {
//            GoodModel* model =  [[GoodModel alloc] initWithData:value];
//            totalCount += [model.num integerValue];
//            return model;
//        }] array] mutableCopy];
//        
//        self.followGoodData = arr;
        [CartManager sharedManager].totalNum = @(totalCount);
        //计算数量
        
//        comlicated?comlicated():nil;
//        
    } failure:^(NSError *error) {
        [FYTXHub dismiss];
        //        TTAlert(@"网络请求出错");
    }];
}
@end
