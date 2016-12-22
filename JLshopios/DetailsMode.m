//
//  DetailsMode.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "DetailsMode.h"

@implementation DetailsMode

#pragma mark 根据字典初始化商品对象
-(DetailsMode *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        self.Id = [dic[@"goods"][@"id"] longValue];
        self.detailsName = dic[@"goods"][@"name"];
        self.detailsDescription = dic[@"goods"][@"description"];
        self.detailsPrice = dic[@"goods"][@"price"];
        self.previewImgs = dic[@"goods"][@"previewImgs"];
        self.detailsIsFoucs = [NSString stringWithFormat:@"%@",dic[@"isCollectioned"]];
        self.detailsImgZX = dic[@"goods"][@"goodsDetail"];
        self.shopid = dic[@"goods"][@"shop"][@"id"];
      
        self.shop = [ShopCellModel objectWithKeyValues:dic[@"goods"][@"shop"]];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(DetailsMode *)commodityWithDictionary:(NSDictionary *)dic{
    DetailsMode *details=[[DetailsMode alloc]initWithDictionary:dic];
    return details;
}


-(NSString *)detailsPrice{
    
    return [NSString stringWithFormat:@"%0.1f",[_detailsPrice doubleValue]];
}

@end
