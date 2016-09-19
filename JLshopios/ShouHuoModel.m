//
//  ShouHuoModel.m
//  JLshopios
//
//  Created by 陈霖 on 16/9/19.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShouHuoModel.h"

@implementation ShouHuoModel

#pragma mark 根据字典初始化商品对象
-(ShouHuoModel *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
//        @property (copy, nonatomic) NSString *name;//收货人
//        @property (copy, nonatomic) NSString *phone;//电话
//        @property (copy, nonatomic) NSString *detailedAdd;//详细地址
//        @property (copy, nonatomic) NSString *userId;//用户id
//        @property (copy, nonatomic) NSString *isDefault;//是否默认地址
//        @property (copy, nonatomic) NSString *areaAdds;//区域
//        @property (copy, nonatomic) NSString *areaId;//id  列表id
        self.name = dic[@"name"];
        self.phone = dic[@"phone"];
        self.detailedAdd=dic[@"detailedAdd"];
        self.userId = [dic[@"userId"] integerValue];
        self.isDefault=dic[@"isDefault"];
        self.areaAdds = dic[@"areaAdds"];
        self.areaId=[dic[@"id"] integerValue];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(ShouHuoModel *)shouhuoWithDictionary:(NSDictionary *)dic{
    ShouHuoModel *shouhuo=[[ShouHuoModel alloc]initWithDictionary:dic];
    return shouhuo;
}

@end
