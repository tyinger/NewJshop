//
//  ShopCellModel.h
//  JLshopios
//
//  Created by mymac on 16/9/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopCellModel : NSObject

@property(assign,nonatomic) int ID;
@property(strong,nonatomic) NSDictionary *shopClass;
@property(copy,nonatomic) NSString *logo;
@property(copy,nonatomic) NSString *name;
@property(copy,nonatomic) NSString *info;
@property(copy,nonatomic) NSString *video;
@property(copy,nonatomic) NSString *businessTime;
@property(copy,nonatomic) NSString *business;
@property(copy,nonatomic) NSString *address;
@property(assign,nonatomic) CGFloat locationLng;
@property(assign,nonatomic) CGFloat locationLat;
@property(copy,nonatomic) NSString *phone;			//联系方式
@property(copy,nonatomic) NSString *contact;			//联系人
@property(copy,nonatomic) NSString *servicePhone;	//客服电话
@property(assign,nonatomic) int status;
@property(copy,nonatomic) NSString *createTime;

@property(assign,nonatomic) NSInteger commentStars;	//用户评价商铺的总星数
@property(assign,nonatomic) NSInteger commentsNum;	//用户评价商铺的总次数

@property(assign,nonatomic) NSInteger shopStatus;	//关注用

@property(assign,nonatomic) NSInteger shopId;//关注用
@property(copy,nonatomic) NSString *shopName;//关注用
@property(assign,nonatomic) NSInteger type;//关注用

@property(assign,nonatomic) BOOL isCollectioned;

@property(copy,nonatomic) NSString *discount;

@property(assign,nonatomic) NSInteger fullYoufei;
@property(assign,nonatomic) NSInteger noFullYoufei;


#pragma mark 根据字典初始化对象
-(ShopCellModel *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化对象（静态方法）
+(ShopCellModel *)statusWithDictionary:(NSDictionary *)dic;
@end
