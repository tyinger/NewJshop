//
//  JLShopTypeModel.m
//  JLshopios
//
//  Created by daxiongdi on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLShopTypeModel.h"

@implementation JLShopTypeModel

+(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    JLShopTypeModel *model = [[JLShopTypeModel alloc]init];
    model.createTime = [dic[@"createTime"] longLongValue];
    model.description_type = dic[@"description"];
    model.firstSpelling = dic[@"firstSpelling"];
    model.icon = dic[@"icon"];
    model.id_type = [dic[@"id"] longLongValue];
    model.level = [dic[@"level"] longLongValue];
    model.name = dic[@"name"];
    model.state = [dic[@"state"] longLongValue];
    model.type = [dic[@"type"] longLongValue];
    model.parent = dic[@"parent"];
    
    return model;
}


@end
