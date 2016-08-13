//
//  CategoryMeunModel.h
//  jdmobile
//
//  Created by 丁博洋 on 15/6/14.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CategoryMeunModel : NSObject

#pragma mark - 属性

@property(assign,nonatomic) int Id;//菜单ID
@property(copy,nonatomic) NSString * menuName;//菜单名
@property(copy,nonatomic) NSString * urlName;//菜单图片名
@property(strong,nonatomic) NSNumber * menuLevel;//菜单等级为1

/**
 *  下一级菜单
 */
@property(strong,nonatomic) NSArray * nextArray;

/**
 *  菜单层数
 */
@property(assign,nonatomic) NSInteger meunNumber;

@property(assign,nonatomic) float offsetScorller;

#pragma mark - 方法
#pragma mark 根据字典初始化对象
-(CategoryMeunModel *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化对象（静态方法）
+(CategoryMeunModel *)statusWithDictionary:(NSDictionary *)dic;
@end

@interface CategoryRightMeunModel : NSObject

#pragma mark - 属性

@property(assign,nonatomic) int Id;//菜单ID
@property(copy,nonatomic) NSString * menuNameOfRight;//右侧菜单名
@property(copy,nonatomic) NSString * urlNameOfRight;//右侧菜单图片名
@property(strong,nonatomic) NSDictionary *parent;//所属父类
@property(copy,nonatomic) NSString * menuLevelOfRight;//右侧菜单等级为2


/**
 *  菜单层数
 */
@property(assign,nonatomic) NSInteger meunNumber;

@property(assign,nonatomic) float offsetScorller;

#pragma mark - 方法
#pragma mark 根据字典初始化对象
-(CategoryRightMeunModel *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化对象（静态方法）
+(CategoryRightMeunModel *)statusWithDictionary:(NSDictionary *)dic;
@end
