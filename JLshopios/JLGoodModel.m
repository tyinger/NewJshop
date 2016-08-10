//
//  JLGoodModel.m
//  JLshopios
//
//  Created by imao on 16/8/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLGoodModel.h"

@implementation JLGoodModel



+(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    JLGoodModel *model = [[JLGoodModel alloc]init];
    
    model.brand = dic[@"brand"];
    model.createDate = [dic[@"createDate"] longLongValue];
    model.description_Goods = dic[@"description"];
    
    model.firstSpelling = dic[@"firstSpelling"];
    model.goodsClass = dic[@"goodsClass"];
    
    model.goodsDetail = dic[@"goodsDetail"];
    
    model.goodsType = [dic[@"goodsType"] longLongValue];
    
    model.icon = dic[@"icon"];
    
    model.userid = [dic[@"id"] longLongValue];
    model.name = dic[@"name"];
    
    model.postage = dic[@"postage"];
    
    
    model.previewImgs = dic[@"previewImgs"];
    
    model.price = [dic[@"price"] floatValue];
    
    model.recommendState = [dic[@"recommendState"] longLongValue];
    
    model.shop = dic[@"shop"];
    
    
    model.soldNum = [dic[@"soldNum"] longLongValue];
    
    model.status =  [dic[@"status"] longLongValue];
    
    model.updateDate = [dic[@"updateDate"] longLongValue];
    
    model.video = dic[@"video"];
    
    
    model.parent = dic[@"parent"];
    
    
    return model;
    
    
}




@end
