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
- (void)getTheOrder{
//    <item>https://123.56.192.182:8443</item>
//    <item>/app/appOrderController/</item>
//    <item>appCreateOrder?</item>
}

- (RACCommand *)doAlipayPayWithGood:(GoodModel *)good{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

//TODO: 商户信息

            NSString *appID = @"2016071401617406";
            NSString *privateKey = @"";
           
            /*
             *生成订单信息及签名
             */
            //将商品信息赋予AlixPayOrder的成员变量
            Order* order = [Order new];
            
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
            order.biz_content.subject = good.goodName;
            order.biz_content.out_trade_no = good.goodid; //订单ID（由商家自行制定）
            order.biz_content.timeout_express = @"30m"; //超时时间设置
            order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [good.price floatValue]]; //商品价格
            
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
                NSString *appScheme = @"alisdkdemo";
                
                // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
                NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
                                         orderInfoEncoded, signedString];
                
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
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
