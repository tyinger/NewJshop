//
//  CategoryMeunModel.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/14.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CategoryMeunModel.h"

@implementation CategoryMeunModel

#pragma mark 根据字典初始化对象
-(CategoryMeunModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.Id=[dic[@"id"] intValue];
        self.menuName=dic[@"name"];
        self.menuLevel = dic[@"level"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(CategoryMeunModel *)statusWithDictionary:(NSDictionary *)dic{
    CategoryMeunModel *categoryMeun=[[CategoryMeunModel alloc]initWithDictionary:dic];
    return categoryMeun;
}
@end

@implementation CategoryRightMeunModel

#pragma mark 根据字典初始化对象
-(CategoryRightMeunModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.Id=[dic[@"id"] intValue];
        self.menuNameOfRight=dic[@"name"];
        self.urlNameOfRight = dic[@"icon"];
        self.menuLevelOfRight = dic[@"level"];
    }
    return self;
}

#pragma mark 初始化对象（静态方法）
+(CategoryRightMeunModel *)statusWithDictionary:(NSDictionary *)dic{
    CategoryRightMeunModel *categoryRightMeun=[[CategoryRightMeunModel alloc]initWithDictionary:dic];
    return categoryRightMeun;
}
@end