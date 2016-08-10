//
//  JLGoodModel.h
//  JLshopios
//
//  Created by imao on 16/8/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLGoodModel : NSObject

@property (nonatomic,strong) NSDictionary *brand;

@property (nonatomic,assign) long long createDate;

@property (nonatomic,copy) NSString *description_Goods;

@property (nonatomic,copy) NSString *firstSpelling;

@property (nonatomic,strong) NSDictionary *goodsClass;

@property (nonatomic,strong) NSString *goodsDetail;

@property (nonatomic,assign) long long goodsType;

@property (nonatomic,strong) NSString *icon;

@property (nonatomic,assign) long long userid;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,strong) NSDictionary *postage;

/**
 *  图片数组
 */
@property (nonatomic,strong) NSArray *previewImgs;

//价格
@property (nonatomic,assign) CGFloat price;

@property (nonatomic,assign) long long recommendState;

//商铺
@property (nonatomic,strong) NSDictionary *shop;
//出售号码
@property (nonatomic,assign) long long soldNum;

@property (nonatomic,assign) long long status;

@property (nonatomic,assign) long long updateDate;

@property (nonatomic,copy) NSString *video;


@property (nonatomic,strong) NSDictionary *parent;


+(instancetype)initWithDictionary:(NSDictionary *)dic;



@end
//<__NSCFArray 0x7f879845aa00>(
//{
//    brand =     {
//        id = 3;
//        name = "\U8bb8\U7559\U5c71";
//    };
//    createDate = 1456761600000;
//    description = "\U597d\U5403";
//    firstSpelling = X;
//    goodsClass =     {
//        firstSpelling = phsp;
//        id = 32;
//        name = "\U81a8\U5316\U98df\U54c1";
//        parent =         {
//            id = 20;
//        };
//    };
//    goodsDetail = "<p><img src=\"http://123.56.192.182/http_resource/image/ueditor/201603011456797610863066228.jpg\" style=\"\" title=\"201603011456797610863066228.jpg\"/></p><p><img src=\"http://123.56.192.182/http_resource/image/ueditor/201603011456797610983042237.jpg\" style=\"\" title=\"201603011456797610983042237.jpg\"/></p><p>\U6025\U6025\U6025\U6025\U6025\U6025\U6025\U6025\U6025<br/></p><p>";
//    goodsType = 1;
//    icon = "http://123.56.192.182/http_resource/image/goods/icon/201603010959249086176.jpg";
//    id = 14;
//    name = "\U9999\U828b/\U9999\U8549/\U8c46\U6c99\U6d3e";
//    postage =     {
//        id = 4;
//        money = 500;
//        name = "\U6ee1500\U5143\U514d\U914d\U9001\U8d39";
//        reachMoney = 500;
//        type = 2;
//    };
//    previewImgs =     (
//                       {
//                           path = "http://123.56.192.182/http_resource/image/goods/preview/201603010959276979898.jpg";
//                       },
//                       {
//                           path = "http://123.56.192.182/http_resource/image/goods/preview/201603010959361177415.jpg";
//                       }
//                       );
//    price = 12;
//    recommendState = 1;
//    shop =     {
//        id = 28;
//        isCollectioned = 0;
//        name = "\U8bb8\U7559\U5c71";
//    };
//    soldNum = 2;
//    status = 3;
//    updateDate = 1465883033000;
//    video = "http://v.youku.com/v_show/id_XNzMxNzQ5NzIw.html?from=s1.8-3-3.1";
//},
//{
//    brand =     {
//        id = 3;
//        name = "\U8bb8\U7559\U5c71";
//    };
//    createDate = 1456675200000;
//    description = 123456;
//    firstSpelling = "";
//    goodsClass =     {
//        firstSpelling = phsp;
//        id = 32;
//        name = "\U81a8\U5316\U98df\U54c1";
//        parent =         {
//            id = 20;
//        };
//    };
//    goodsDetail = "<p><img src=\"http://123.56.192.182/http_resource/image/ueditor/201602291456745168770007113.jpg\" title=\"201602291456745168770007113.jpg\" alt=\"X2.jpg\"/></p><p>\U5bb6\U53e3\U8def\U4ea4\U53e3\U5c311111111111111111111111111111111111111111111111</p><p>\U4eba\U4eba\U4eba\U4eba\U7279</p><p><br/></p><p>\U513f\U7ae5\U6c83\U5c14\U7279\U7279\U52a1\U5929\U5929\U5929\U5929\U5929\U5929\U5929\U5929\U5929\U5929</p>";
//    goodsType = 1;
//    icon = "http://123.56.192.182/http_resource/image/goods/icon/201602291924495296668.jpg";
//    id = 11;
//    name = "\U8c46\U6c99/\U829d\U9ebb/\U9999\U828b\U6c64\U5706";
//    postage =     {
//        id = 3;
//        money = 5;
//        name = "5\U5143\U914d\U9001";
//        type = 1;
//    };
//    previewImgs =     (
//                       {
//                           path = "http://123.56.192.182/http_resource/image/goods/preview/20160229192457515150.jpg";
//                       }
//                       );
//    price = 18;
//    recommendState = 1;
//    shop =     {
//        id = 28;
//        isCollectioned = 0;
//        name = "\U8bb8\U7559\U5c71";
//    };
//    soldNum = 20;
//    status = 3;
//    updateDate = 1461312368000;
//    video = "";
//}
//                             )