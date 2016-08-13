//
//  JLShopModel.m
//  JLshopios
//
//  Created by daxiongdi on 16/8/7.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLShopModel.h"

@implementation JLShopModel

//{
//    adId = 6;
//    id = 40;
//    image = "http://123.56.192.182/http_resource/image/ad/201606132134556884753.jpg";
//    info = 11;
//    resourceType = 1;
//    url = "";
//},

+(instancetype)initWithDictionary:(NSDictionary *)dic{
    
    JLShopModel *model = [[JLShopModel alloc]init];
    
    model.adId = [dic[@"adId"] longLongValue];
    model.userId = [dic[@"id"] longLongValue];
    model.image = dic[@"image"];
    model.info = dic[@"info"];
    model.resourceType = [dic[@"resourceType"] longLongValue];
    model.url = dic[@"url"];
    model.infoDic = dic;
    
    return model;
}










-(void)netWorkTest{
    //获取验证码的
    //    NSDictionary *dic = @{@"phoneNum":@"18643212316"};
    //    //loginName=18643212316 password=
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getRegisterYzm?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
    //        NSLog(@"json = msg %@",json[@"msg"]);
    //    } failure:^(NSError *error) {
    //
    //    }];
    
    //注册接口
    //123.56.192.182:8443/app/user/registNewUser?
    
    /**
     *  phoneNum,checkCode
     pwd(MD5大写),recommendCode
     
     手机号 验证码 md5  推荐码
     */
    
    //    NSDictionary *dic = @{@"phoneNum":@"13631564265",@"checkCode":@"123123",@"pwd":@"IUOIJIWJEIWJEWOEJOWIEJWOIEJIWJEWIEJIWEQQQQ",@"recommendCode":@""};
    //    //loginName=18643212316 password=
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/registNewUser?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
    //        NSLog(@"json = msg %@",json[@"msg"]);
    //    } failure:^(NSError *error) {
    //
    //    }];
    
    //    //首页轮播的接口
    //    NSDictionary *dic = @{@"adType":@"1"};
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/ad/getAdResource?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
    //    } failure:^(NSError *error) {
    //    }];
    
    
    
    //推荐商品接口 //begin=0
    //    NSDictionary *dic = @{@"begin":@"0"};
    //    //https://123.56.192.182:8443/app/product/recommendGoods?
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/recommendGoods?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
    //        
    //            } failure:^(NSError *error) {
    //    }];
    
    
    
}











@end
