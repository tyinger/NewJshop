//
//  JLShopTypeModel.h
//  JLshopios
//
//  Created by daxiongdi on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLShopTypeModel : NSObject

@property (nonatomic,assign) long long createTime;

@property (nonatomic,copy) NSString *description_type;

@property (nonatomic,copy) NSString *firstSpelling;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,assign) long long id_type;

@property (nonatomic,assign) long long level;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) long long state;

@property (nonatomic,assign) long long type;

@property (nonatomic,strong) NSDictionary *parent;


+(instancetype)initWithDictionary:(NSDictionary *)dic;


@end


//{
//    createTime = 1453704801000;
//    description = "\U4e3a\U4eba\U60c5\U54732132";
//    firstSpelling = bld;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112005481182413.png";
//    id = 1;
//    level = 1;
//    name = "\U4fbf\U5229\U5e97";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = ms;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006407983898.png";
//    id = 2;
//    level = 1;
//    name = "\U7f8e\U98df";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453778013000;
//    description = "";
//    firstSpelling = gw;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006542878810.png";
//    id = 3;
//    level = 1;
//    name = "\U8d2d\U7269";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = 111;
//    firstSpelling = xxy;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112007099135125.png";
//    id = 4;
//    level = 1;
//    name = "\U4f11\U95f2\U5a31\U4e50";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = mrmf;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112007233850451.png";
//    id = 5;
//    level = 1;
//    name = "\U7f8e\U5bb9\U7f8e\U53d1";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453778007000;
//    description = "";
//    firstSpelling = wb;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112007406081891.png";
//    id = 6;
//    level = 1;
//    name = "\U7f51\U5427";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = 2121212121;
//    firstSpelling = ktv;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112007553927135.png";
//    id = 7;
//    level = 1;
//    name = KTV;
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = xyhz;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112008107871714.png";
//    id = 8;
//    level = 1;
//    name = "\U6d17\U6d74\U6c57\U84b8";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = 1231231;
//    firstSpelling = dy;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006112098987.png";
//    id = 9;
//    level = 1;
//    name = "\U7535\U5f71";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = shfw;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112008228046055.png";
//    id = 10;
//    level = 1;
//    name = "\U751f\U6d3b\U670d\U52a1";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = jd;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112008407913090.png";
//    id = 11;
//    level = 1;
//    name = "\U9152\U5e97";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = jd;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201607182031293353847.png";
//    id = 12;
//    level = 1;
//    name = "\U666f\U70b9";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = ydjs;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112010064594253.png";
//    id = 13;
//    level = 1;
//    name = "\U8fd0\U52a8\U5065\U8eab";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = ac;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112010221201816.png";
//    id = 14;
//    level = 1;
//    name = "\U7231\U8f66";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = yljk;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112010417885258.png";
//    id = 15;
//    level = 1;
//    name = "\U533b\U7597\U5065\U5eb7";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1453704801000;
//    description = "";
//    firstSpelling = cw;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112010537477595.png";
//    id = 16;
//    level = 1;
//    name = "\U5ba0\U7269";
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750445000;
//    description = "";
//    firstSpelling = yh;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112011112068368.png";
//    id = 41;
//    level = 2;
//    name = "\U94f6\U884c";
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = shfw;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112008228046055.png";
//        id = 10;
//        level = 1;
//        name = "\U751f\U6d3b\U670d\U52a1";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750494000;
//    description = "\U6d4b\U8bd5\U7528\U5c0f\U5356\U94fa";
//    firstSpelling = xmp;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601251637055855599.jpg";
//    id = 63;
//    level = 2;
//    name = "\U5c0f\U5356\U94fa";
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = shfw;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112008228046055.png";
//        id = 10;
//        level = 1;
//        name = "\U751f\U6d3b\U670d\U52a1";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750496000;
//    description = "\U514d\U8d39\U7f51\U5427";
//    firstSpelling = fs;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601261546492354157.jpg";
//    id = 68;
//    level = 2;
//    name = "\U98de\U901f\U7f51\U5427";
//    parent =     {
//        createTime = 1453778007000;
//        description = "";
//        firstSpelling = wb;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112007406081891.png";
//        id = 6;
//        level = 1;
//        name = "\U7f51\U5427";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750497000;
//    description = "\U7231\U5403\U9762\U98df\U548c\U751c\U98df\U7684\U4eba\U4f18\U9009";
//    firstSpelling = D;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/20160229155529891245.jpg";
//    id = 92;
//    level = 2;
//    name = "\U86cb\U7cd5\U3001\U9762\U5305\U574a";
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = ms;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006407983898.png";
//        id = 2;
//        level = 1;
//        name = "\U7f8e\U98df";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750498000;
//    description = "\U82b1\U574a";
//    firstSpelling = H;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201602261511385381067.jpg";
//    id = 94;
//    level = 2;
//    name = "\U82b1\U574a";
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = shfw;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112008228046055.png";
//        id = 10;
//        level = 1;
//        name = "\U751f\U6d3b\U670d\U52a1";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750499000;
//    description = "";
//    firstSpelling = "";
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201602291555568817824.jpg";
//    id = 95;
//    level = 2;
//    name = "\U8336\U5f0f\U9910\U5385";
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = ms;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006407983898.png";
//        id = 2;
//        level = 1;
//        name = "\U7f8e\U98df";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750500000;
//    description = sdfsdfsd;
//    firstSpelling = sdfdsfsdf;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201607161917287740161.jpg";
//    id = 119;
//    level = 2;
//    name = esfsdgsg;
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = ms;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006407983898.png";
//        id = 2;
//        level = 1;
//        name = "\U7f8e\U98df";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750504000;
//    description = asdasdas;
//    firstSpelling = asdsadas;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201607161918091916966.jpg";
//    id = 120;
//    level = 2;
//    name = sdsadsa;
//    parent =     {
//        createTime = 1453778013000;
//        description = "";
//        firstSpelling = gw;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006542878810.png";
//        id = 3;
//        level = 1;
//        name = "\U8d2d\U7269";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750505000;
//    description = asdasdas;
//    firstSpelling = asdasdasd;
//    icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201607161919231714091.jpg";
//    id = 121;
//    level = 2;
//    name = asdasdas;
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = ms;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112006407983898.png";
//        id = 2;
//        level = 1;
//        name = "\U7f8e\U98df";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//},
//{
//    createTime = 1470750510000;
//    description = 111;
//    firstSpelling = 11;
//    icon = 11;
//    id = 129;
//    level = 2;
//    name = 111;
//    parent =     {
//        createTime = 1453704801000;
//        description = "";
//        firstSpelling = cw;
//        icon = "http://123.56.192.182/http_resource/image/sysClassIcon/201601112010537477595.png";
//        id = 16;
//        level = 1;
//        name = "\U5ba0\U7269";
//        state = 0;
//        type = 1;
//    };
//    state = 0;
//    type = 1;
//}
//)
