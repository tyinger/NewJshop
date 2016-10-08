//
//  ShopDetailModel.h
//  JLshopios
//
//  Created by mymac on 16/10/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShopDetailModel : NSObject

@property(copy,nonatomic) NSString *imagePath;
@property(copy,nonatomic) NSString *shopName;
@property(copy,nonatomic) NSString *shopAddInfo;
@property(copy,nonatomic) NSString *shopPhone;
@property(copy,nonatomic) NSString *shopAddress;
@property(assign,nonatomic) long long shopId;
@property(assign,nonatomic) BOOL isCollectioned;
@property(assign,nonatomic) CGFloat cellHeight;

-(ShopDetailModel *)initWithDictionary:(NSDictionary *)dic;

#pragma mark 初始化对象（静态方法）
+(ShopDetailModel *)statusWithDictionary:(NSDictionary *)dic;

@end
