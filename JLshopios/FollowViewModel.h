//
//  FollowViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//
typedef NS_ENUM(NSUInteger, VCType) {
    VCTypeGood = 1,
    VCTypeShop = 2,
};
#import <Foundation/Foundation.h>
@class MyFollowViewController;
@interface FollowViewModel : NSObject
@property (nonatomic, weak)MyFollowViewController * followViewController;
@property (nonatomic, strong)NSMutableArray * followGoodData;
@property (nonatomic, strong)NSMutableArray * followShopData;

- (void)goToDetailWithID:(NSString *)goodID;
- (RACSignal*)getData:(void(^)(id))comlicated;
@end
