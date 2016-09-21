
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
- (NSMutableArray *)followGoodData{
    if (!_followGoodData) {
        _followGoodData = [NSMutableArray array];
    }
    return _followGoodData;
}

- (RACSignal*)goToDetailWithID:(NSString *)goodID{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        DetailsViewController * detail = [[DetailsViewController alloc] init];
        detail.productIDStr = goodID;
        [((UIViewController*)self.followViewController).navigationController pushViewController:detail animated:YES];
        [subscriber sendCompleted];
        return nil;
    }];
    return result;
  
}
- (RACSignal*)getData:(VCType)type andPage:(NSInteger)page{
    /*
    https://123.56.192.182:8443/app/favorite/listFavoriteGoods?userId=37&pageNo=1
     */
    [FYTXHub progress:@"正在加载"];
  
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        if (page == 1&&type ==0) {
            self.followGoodData = [NSMutableArray array] ;
        }
        if (page == 1&&type ==1) {
            self.followShopData = [NSMutableArray array];
        }
         NSString *  urlString = @"https://123.56.192.182:8443/app/favorite/listFavoriteGoods?";
        //    NSString * idStr = [LoginStatus sharedManager].idStr;
        NSString * idStr = @"6";
       
        [QSCHttpTool get:urlString parameters:@{@"userId":idStr,@"pageNo":[NSString stringWithFormat:@"%ld",(long)page]} isShowHUD:YES httpToolSuccess:^(id json) {
            [FYTXHub dismiss];
          
            NSMutableArray * arr =[[[((NSArray*)json).rac_sequence map:^id(id value) {
                        FollowGoodModel* model =  [[FollowGoodModel alloc] initWithData:value];
                        return model;
                    }] array] mutableCopy];
            if (type == 0) {
              [self.followGoodData addObjectsFromArray:arr];
            }
          
//            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
            
            } failure:^(NSError *error) {
            [FYTXHub dismiss];
            [subscriber sendError:error];
        }];

        return nil;
    }];
    return result;
  }
@end
