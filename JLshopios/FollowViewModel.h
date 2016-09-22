//
//  FollowViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//
typedef NS_ENUM(NSUInteger, VCType) {
    VCTypeGood = 0,
    VCTypeShop = 1,
};
#import "FollowGoodModel.h"
#import <Foundation/Foundation.h>
@class MyFollowViewController;
@interface FollowViewModel : NSObject
@property (nonatomic, weak)MyFollowViewController * followViewController;

@property (nonatomic, strong)NSMutableArray <FollowGoodModel*>* followGoodData;
@property (nonatomic, strong)NSMutableArray <FollowGoodModel*>* followShopData;

- (RACSignal*)goToDetailWithID:(NSString *)goodID AndIconUrl:(NSString *)goodImg;
- (RACSignal*)getData:(VCType)type andPage:(NSInteger)page;
@end
