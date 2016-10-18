//
//  ShopCellModel.m
//  JLshopios
//
//  Created by mymac on 16/9/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShopCellModel.h"

@implementation ShopCellModel
/*
    noFullYoufei = 2,
	status = 0,
	shopClass = {
	id = 1
 },
	locationLng = 126.569085,
	locationLat = 43.867116,
	isCollectioned = 0,
	commentStars = 0,
	video = ,
	contact = 三哥,
	fullYoufei = 30,
	name = 社区便利店,
	info = 亚泰二期社区便利店,
	id = 2,
	servicePhone = 0432-62550636,
	commentsNum = 0,
	phone = 15656966789,
	businessTime = 24小时,
	createTime = 1473775998000,
	logo = http://123.56.192.182/http_resource/image/shop/logo/201609132212452964402.jpg,
	address = 吉林省吉林市昌邑区运河路
 */
#pragma mark 根据字典初始化对象
-(ShopCellModel *)initWithDictionary:(NSDictionary *)dic{
    if (self==[self init]) {
        self.ID = [dic[@"id"] intValue];
        self.status = [dic[@"status"] intValue];
        self.locationLng = [dic[@"locationLng"] doubleValue];
        self.locationLat = [dic[@"locationLat"] doubleValue];
        self.isCollectioned = [dic[@"isCollectioned"] intValue];
        self.commentStars = [dic[@"commentStars"] intValue];
        self.video = dic[@"video"];
        self.contact = dic[@"contact"];
        self.fullYoufei = [dic[@"fullYoufei"] intValue];
        self.noFullYoufei = [dic[@"noFullYoufei"] intValue];
        self.name = dic[@"name"];
        self.servicePhone = dic[@"servicePhone"];
        self.commentsNum = [dic[@"commentsNum"] integerValue];
        self.phone = dic[@"phone"];
        self.businessTime = dic[@"businessTime"];
        self.createTime = dic[@"createTime"];
        self.logo = dic[@"logo"];
        self.address = dic[@"address"];
        self.info = dic[@"info"];
        self.distance = dic[@"distance"];
    }
    return self;
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}
#pragma mark 初始化对象（静态方法）
+(ShopCellModel *)statusWithDictionary:(NSDictionary *)dic{
    ShopCellModel *categoryMeun=[[ShopCellModel alloc]initWithDictionary:dic];
    return categoryMeun;
}
@end
