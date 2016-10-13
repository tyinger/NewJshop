//
//  PayManager.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "PayManager.h"
#import <AlipaySDK/AlipaySDK.h>
//#import "APAuthV2Info.h"
#import "DataSigner.h"
#import "Order.h"
@implementation PayManager

+ (instancetype )manager{
    
    static PayManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedManager = [[self alloc] init];
    });
    
    return sharedManager;
    
    
    
}
- (RACSignal *)getTheOrderFace{
    return nil;
}
- (RACSignal *)getTheOrderCurrent{
    /*
    （2）如果是直接购买：
    需传入setOrderType=0，setUser，setOrderDetails（SysOrderDetail实体），setShop（SysShop实体）
     */
    SysOrder * sysOrder = [[SysOrder alloc] init];
    sysOrder.user = [LoginStatus sharedManager];
    NSMutableArray <SysOrderDetail*>*orderDetails = [NSMutableArray array];
    
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }];
    return result;
}
- (RACSignal*)getTheOrderCartArray:(NSMutableArray<GoodModel*>*)array shop:(ShopCellModel*)shop{
//    <item>https://123.56.192.182:8443</item>
//    <item>/app/appOrderController/</item>
//    <item>appCreateOrder?</item>
    /*
     数据传递方式：post
     参数名：arg0
     参数：SysOrder实体的json串
     说明：
     （1）如果是当面付：
     只需传入setOrderType=4，setUser，setMoney，setShop，其中setShop为SysShop实体。
     （2）如果是直接购买：
     需传入setOrderType=0，setUser，setOrderDetails（SysOrderDetail实体），setShop（SysShop实体）
     （3）如果是购物车结算：
     和（2）一样，不同的是购物车结算要先传入商品，然后跳转到选择店铺页面，再选择店铺，传入店铺后生成订单。
     */
    SysOrder * sysOrder = [[SysOrder alloc] init];
    
//    NSMutableArray <SysOrderDetail*>*orderDetails = [NSMutableArray array];
    NSMutableArray <SysOrderDetail*>*orderDetails = [[[array.rac_sequence map:^id(GoodModel* value) {
        SysOrderDetail * orderDetail = [[SysOrderDetail alloc] init];
        orderDetail.goodsNum = value.num;
//        orderDetail.goods = value;
        orderDetail.goods = [[GoodModel alloc] init];
        orderDetail.goods.Id = value.goodid;
        orderDetail.goods.goodName = value.goodName;
        return orderDetail;
    }] array] mutableCopy];
    //sysOrder 的4个参数 1：orderDetail 2：orderType 3：user 4：shop
//    [GoodModel referenceReplacedKeyWhenCreatingKeyValues:YES];
    sysOrder.user = [LoginStatus sharedManager];
    sysOrder.orderDetails = orderDetails;
    sysOrder.orderType = @"0";
    sysOrder.shop = shop;
    
//    NSDictionary * sysOrderJson =  [sysOrder JSONObject];
    NSString * sysOrderJsonStr =  [sysOrder JSONString];
    NSDictionary * para = @{@"arg0":sysOrderJsonStr};
//    NSString * paraString = [para JSONString];
     NSString *  urlString = @"https://123.56.192.182:8443/app/appOrderController/appCreateOrder?";
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [QSCHttpTool post:urlString parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
            [subscriber sendNext:json];
            [subscriber sendCompleted];
            NSLog(@"%@",json);
        } failure:^(NSError *error) {
               [subscriber sendError:error];
             [subscriber sendCompleted];
            NSLog(@"%@",error);
        }];
        return nil;
    }];
    return result;
}

- (RACCommand *)doAlipayPayWithGood:(SysOrderReturn *)good{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

//TODO: 商户信息

            NSString *appID = @"2016071401617406";
            NSString *privateKey = @"MIICXAIBAAKBgQDdOO8LdvqkZ0xFZuPLpW//rqPoi4Ve3tTiOFtMw/9m3D1Z4AF9lw8knBLt/65lECQ7OXmdKuMLj7YL3uZVhZ6itSxkRKfnU8bVbWONKtLtrKOK83xGH+/HoUU4W2UxuryDrWnnTPA7ZTAu8eMKjAfPIUSA7ev2bhs+zEBCUoHh6wIDAQABAoGAVrNalH6z6r0FWmnhu02CYI28dYZA5halDmgR+DsUnOaSMOgnDWanq6xzis1bNwalfIShEiTdyQkwyuQ4F6p/qgCP0t6BjdC2kj5pwgsZm1YmgFyycOwHsN7IbuqlQk2TfF/4K21nED9TikM7U+0oB965kCaz/QX0McCgIE4dpHkCQQDyc7wFinw5nmO/aoz3phSZZsy00usXEU+5nvNiNKNYTWzSQ1DVheg/VrFzYZJHrkUfJXD0mYEABk8uwcfrMlvfAkEA6ZWCdW4qw1zANYCs/NRB+rC+LEtkMxKgTlXjqmthon5MnO6PUIJ1SmPvRMgQVlSa7z1c74sNtHnS7qfhoN67dQJAJRkocACcuYRO5v86yroS9NYSBKkxZ7oyZMi5nRFI3T4bpKDAQavXubleNbV8WJOF6Bomiobigkp020azfH2cKQJASGjMlFKedwldnDhTZ9z0xx3bFigY26w+fYoqlT3Mem7kmRFq4+5NJc5s8cmDJv/7N4ayNJ/Kk9PgC5OHYjMpsQJBAIJTFwvL7H+ZqsMt/OLWFJjtfMf4bLFhb3q+Xol2oQ0f2dsO79ZOLru6BGFtVeLL/8Xp86Y5qy3MEVnGq5NEF8o=";
           
            /*
             *生成订单信息及签名
             */
            //将商品信息赋予AlixPayOrder的成员变量
            Order* order = [Order new];
            
            order.biz_content.seller_id = @"119863563@qq.com";
            // NOTE: app_id设置
            order.app_id = appID;
            
            // NOTE: 支付接口名称
            order.method = @"alipay.trade.app.pay";
            
            // NOTE: 参数编码格式
            order.charset = @"utf-8";
            
            // NOTE: 当前时间点
            NSDateFormatter* formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            order.timestamp = [formatter stringFromDate:[NSDate date]];
            
            // NOTE: 支付版本
            order.version = @"1.0";
            
            // NOTE: sign_type设置
            order.sign_type = @"RSA";
            
            // NOTE: 商品数据
            order.biz_content = [BizContent new];
            //描述 好像没有
            //order.biz_content.body = good.description;
            order.biz_content.subject = good.order.orderDesc;
            order.biz_content.out_trade_no = good.serialNumber; //订单ID（由商家自行制定）
            order.biz_content.timeout_express = @"30m"; //超时时间设置
//TODO:价格修改
//            order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [good.price floatValue]]; //商品价格
            order.biz_content.total_amount = @"0.01";
            //将商品信息拼接成字符串
            NSString *orderInfo = [order orderInfoEncoded:NO];
            NSString *orderInfoEncoded = [order orderInfoEncoded:YES];
            NSLog(@"orderSpec = %@",orderInfo);
            
            // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
            //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
            id<DataSigner> signer = CreateRSADataSigner(privateKey);
            NSString *signedString = [signer signString:orderInfo];
            
            // NOTE: 如果加签成功，则继续执行支付
            if (signedString != nil) {
                
                
// TODO:appScheme
                //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
                NSString *appScheme = @"JLshopios";
                
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                         orderInfoEncoded, signedString];
                
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    int  staute =[resultDic[@"resultStatus"] intValue];
                    switch (staute) {
                        case 9000:
                            TTAlert(@"支付成功!");
                            break;
                        case 8000:
                            TTAlert(@"正在处理中");
                           
                            break;
                        case 4000:
                            TTAlert(@"订单支付失败");
                           
                            break;
                        case 6001:
                            TTAlert(@"用户中途取消");
                           
                            break;
                        case 6002:
                            TTAlert(@"网络连接出错");
                           
                            break;
                        default:
                            break;
                   
                 
                    
                }
                    NSLog(@"reslut = %@",resultDic);
                    [subscriber sendNext:resultDic];
                    [subscriber sendCompleted];
                }];
            }
            
                return nil;
        }];
    }];
}

@end




@implementation SysOrderDetail
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}
@end

@implementation SysOrder
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}
@end
@implementation SysOrderReturn

@end

