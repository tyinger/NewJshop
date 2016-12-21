//
//  CommodityModel.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/22.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityModel.h"

@implementation CommodityModel


#pragma mark 根据字典初始化商品对象
-(CommodityModel *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
//        NSLog(@"%@",dic[@"shop"][@"name"]);
        self.needShowShopName = ([dic[@"shopid"] intValue] != 1);
        self.shopName = dic[@"shop"][@"name"];
        
        
        self.Id=[dic[@"id"] longLongValue];
        self.commodityImageUrl=dic[@"icon"];
        self.commodityName=dic[@"name"];
        self.commodityPrice=dic[@"price"];
        self.commodityCartNum=dic[@"cartNum"];
//        self.commodityZX=dic[@"commodityZX"];
//        self.commodityPraise=dic[@"commodityPraise"];
//        self.commodityPerson=dic[@"commodityPerson"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(CommodityModel *)commodityWithDictionary:(NSDictionary *)dic{
    CommodityModel *commodity=[[CommodityModel alloc]initWithDictionary:dic];
    return commodity;
}

//-(NSString *)praise{
//    return [NSString stringWithFormat:@"好评%@ %@人",_commodityPraise,_commodityPerson];
//}
-(NSString *)commodityCartNum{
    if (!_commodityCartNum) {
        return @"0";
    }
    return [NSString stringWithFormat:@"%@",_commodityCartNum];
}

-(NSString *)commodityPrice{
    return [NSString stringWithFormat:@"%0.1f",[_commodityPrice doubleValue]];
}

@end
