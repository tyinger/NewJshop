//
//  JLShopModel.h
//  JLshopios
//
//  Created by daxiongdi on 16/8/7.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLShopModel : NSObject


//
//{
//    adId = 6;
//    id = 40;
//    image = "http://123.56.192.182/http_resource/image/ad/201606132134556884753.jpg";
//    info = 11;
//    resourceType = 1;
//    url = "";
//},


@property (nonatomic,assign) long long adId;

@property (nonatomic,assign) long long userId;

@property (nonatomic,copy) NSString *image;

@property (nonatomic,copy) NSString *info;

@property (nonatomic,assign) long long resourceType;

@property (nonatomic,copy) NSString *url;

@property (nonatomic,strong) NSDictionary *infoDic;

+(instancetype)initWithDictionary:(NSDictionary *)dic;








@end
