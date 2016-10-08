//
//  ShopDetailModel.m
//  JLshopios
//
//  Created by mymac on 16/10/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShopDetailModel.h"

@implementation ShopDetailModel

#pragma mark 根据字典初始化对象
-(ShopDetailModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.isCollectioned = [dic[@"isCollectioned"] intValue];
        self.shopName = dic[@"name"];
        self.shopPhone = dic[@"phone"];
        self.shopAddress = dic[@"address"];
        self.shopAddInfo = dic[@"info"];
        self.shopId = [dic[@"id"] longLongValue];
        self.imagePath = [dic[@"pictures"] count] ? dic[@"pictures"][0][@"path"] : nil;
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(ShopDetailModel *)statusWithDictionary:(NSDictionary *)dic{
    ShopDetailModel *categoryMeun=[[ShopDetailModel alloc]initWithDictionary:dic];
    return categoryMeun;
}

@end
