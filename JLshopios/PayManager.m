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
- (RACSignal *)getTheOrderCurrent:(GoodModel *)order shop:(ShopCellModel*)shop{
    /*
    （2）如果是直接购买：
    需传入setOrderType=0，setUser，setOrderDetails（SysOrderDetail实体），setShop（SysShop实体）
     */
    
    
    SysOrderDetail * orderDetail = [[SysOrderDetail alloc] init];
    
    orderDetail.goodsNum = order.num;
    orderDetail.goods = [[GoodModel alloc] init];
    orderDetail.goods.Id = order.goodid;
    orderDetail.goods.goodName = order.goodName;
    
    
    SysOrder * sysOrder = [[SysOrder alloc] init];
    sysOrder.user = [LoginStatus sharedManager];
    sysOrder.orderType = @"0";
    sysOrder.orderDetails = [NSMutableArray arrayWithArray:@[orderDetail]];
    sysOrder.shop = shop;
    
 
    NSString * sysOrderJsonStr =  [sysOrder JSONString];
    NSDictionary * para = @{@"arg0":sysOrderJsonStr};

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
- (RACSignal *)judgeTheOrder:(SysOrder *)order{
   
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            TTAlert(@"去评价");
            [subscriber sendCompleted];
            return nil;
        }];
  
}
- (RACSignal *)confirmTheOrder:(SysOrder *)order{
    
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        /*
        
         */
        [FYTXHub progress:@"请稍后"];
        NSString *  url = @"https://123.56.192.182:8443/app/appOrderController/confirmRecevicedGoods?";
        NSDictionary * para = @{@"orderId":order.Id};
     
//        
        [QSCHttpTool post:url parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
            [FYTXHub dismiss];
            [subscriber sendNext:json];
            [subscriber sendCompleted];
            NSLog(@"%@",json);
        } failure:^(NSError *error) {
            [FYTXHub toast:@"网络错误"];
            [subscriber sendError:error];
            [subscriber sendCompleted];
            NSLog(@"%@",error);
        }];
        return nil;
    }];
    return result;

    
}
- (RACSignal *)cancelTheOrder:(SysOrder *)order{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        /*
         <item>https://123.56.192.182:8443</item>
         <item>/app/appOrderController/</item>
         <item>appCancelOrDeleteOrder?</item>
         */
       NSString *  url = @"https://123.56.192.182:8443/app/appOrderController/appCancelOrDeleteOrder?";
        order.showStatus = @"2";
          NSString * sysOrderJsonStr =  [order JSONString];
         NSDictionary * para = @{@"arg0":sysOrderJsonStr};
      
        [QSCHttpTool post:url parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
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
            NSString * partner = @"2088421459616059";
//           NSString *privateKey =  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDAt4DxXTuyRPBy2s63A0JHMOObA0Caa5h9DA+oWEEBqTJwLaevh/PAZDqF+VGPR3V9DuppXQEYIx8cf9PIkAEUu96WYu9JOAn+ohMnEfWIGtxxUUGT+tTBRDj9Rrcj9tRoAPa53BGtbMoG0VqfzSAX17mJI86PMs3sMhQnrsxOQIDAQAB";
//            NSString *privateKey = @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMMC3gPFdO7JE8HLazrcDQkcw45sDQJprmH0MD6hYQQGpMnAtp6+H88BkOoX5UY9HdX0O6mldARgjHxx/08iQARS73pZi70k4Cf6iEycR9Yga3HFRQZP61MFEOP1GtyP21GgA9rncEa1sygbRWp/NIBfXuYkjzo8yzewyFCeuzE5AgMBAAECgYAfOEpK2EXMJKzhDavxFGGR3+T+3BWJGVotnGZM4JEjj9y53/xclZuKDHoiwAiYohgwtJUIp9BXEw3qrmVtSdJtlvxan7axKl84ZNKQ1FFWpZlNQE1lstPGkTyOAkeCkU2q18mZHCb/ArXw3ffZFkK3syZN4APAGdcr/W/ii8BgMQJBAPNNISrrQYekxvHrTtzw+G/05s2jfn+AvJDOM1FfTTv3HAbRF+UXrU7+p58T8tlz4AdXBfdUz3KjkKO6PMKye08CQQDNMIJ26j7h1YRD+nMvbT3AeGzeMNp5a6CUZEg87LqLOU+4IEs2p/eKshJ+hKThrrfRyM1hmUedkf1pF9Z6qEj3AkEAqpjdddupgjQO71iAXrl0agQ9xdkq/LpG/f4ny5nYbQCTHVCFwbQ9aFN1MzzonoL6hgsF+uvz3b1E0RjoO9isTwJACBcZjca+o/jfNi7xy7Tq8mPNJxWWB6OOuUsa7gwHbuXbls7vKECHKhjLUeG4/oz9AnCAaJC6miPfcf1Wn49zEQJAQtbCS108b2SIyObV2ePZwzHTlFl11eIAxT+DTONoumXybJdL6o83uIs5zr7oyp8GPV2VB24vtL91wniKQujsKg==";
//                        NSString *privateKey = @"MIICXQIBAAKBgQCiV3xj9puow/Qe0Oa+3vIacFuTjJHCW3U0Kz5LbhmZfL2H8gV99zyyOujfhEJRu0UbO2CW21SsZXssMGxaQ5ucclNuPv4sBvC24EN9JPwx30pEYRGQdjsW3+4gG6pOkdKwyTURMv0e2VKzz/LzEJOwAq9TP0tkzmqZkIKoxiCvzwIDAQABAoGAO50ovoSWkJi0koRf14ODIBZWao5aECcJmQiwLX7Ww7g82SkUvzcFAOYFEd89g0njjKZ3R65vH4d8fbOidlsRTwIpb4oiISlnV5kLydWX+fRQtl7Vu977F/ZRBt+LdSz2IQf0N4pDOFb71GhCly0DIt4fJTtbpQufGbtLrdmT80ECQQDN7VrnuS3gLtj2dqqXTEFROVY8pGfceQccD8ucxskw6UAmYGAD5ZEDV1SJcasYFhmQGaf1uCFAvRw4OPKkn/sxAkEAydEBidfhtkAqM1/+C7iqyqvITJeYKIB7h0RqUUsURvFVQSUS5OYKhoTFgAAQV1oJ6fqVHRn+OgCTIEcPqcqa/wJBAIp/IU2J2NXXDCqu4srBCYkERACjHgtFBsgTw4BcncGcjn2BAfJ8+kvB92Q9I7IeYvDsoG79eLfeuFUD0AVyZ3ECQCq3wsualnwtOMGHIA77F6uukMclj1+DUqJfKOHsMm6RxqnzXvx0dOXkVKmzWcIjnNWZ5NY0GkvMs1exsu8No6ECQQCJNiD9xDXE8uGXWXmvU5NR2XOIF7dp8ITPd2qukIvVNT3yLcVUWCZuZi6/rqHR6qbxV3FNfOuoGZlWL/0s8nzf";
            NSString *privateKey = @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKJXfGP2m6jD9B7Q5r7e8hpwW5OMkcJbdTQrPktuGZl8vYfyBX33PLI66N+EQlG7RRs7YJbbVKxleywwbFpDm5xyU24+/iwG8LbgQ30k/DHfSkRhEZB2Oxbf7iAbqk6R0rDJNREy/R7ZUrPP8vMQk7ACr1M/S2TOapmQgqjGIK/PAgMBAAECgYA7nSi+hJaQmLSShF/Xg4MgFlZqjloQJwmZCLAtftbDuDzZKRS/NwUA5gUR3z2DSeOMpndHrm8fh3x9s6J2WxFPAilviiIhKWdXmQvJ1Zf59FC2XtW73vsX9lEG34t1LPYhB/Q3ikM4VvvUaEKXLQMi3h8lO1ulC58Zu0ut2ZPzQQJBAM3tWue5LeAu2PZ2qpdMQVE5VjykZ9x5BxwPy5zGyTDpQCZgYAPlkQNXVIlxqxgWGZAZp/W4IUC9HDg48qSf+zECQQDJ0QGJ1+G2QCozX/4LuKrKq8hMl5gogHuHRGpRSxRG8VVBJRLk5gqGhMWAABBXWgnp+pUdGf46AJMgRw+pypr/AkEAin8hTYnY1dcMKq7iysEJiQREAKMeC0UGyBPDgFydwZyOfYEB8nz6S8H3ZD0jsh5i8Oygbv14t964VQPQBXJncQJAKrfCy5qWfC04wYcgDvsXq66QxyWPX4NSol8o4ewybpHGqfNe/HR05eRUqbNZwiOc1Znk1jQaS8yzV7Gy7w2joQJBAIk2IP3ENcTy4ZdZea9Tk1HZc4gXt2nwhM93aq6Qi9U1PfItxVRYJm5mLr+uodHqpvFXcU1866gZmVYv/SzyfN8=";
            /*
             *生成订单信息及签名
             */
            
            //将商品信息赋予AlixPayOrder的成员变量
            Order *order = [[Order alloc] init];
            order.partner = partner;
            order.sellerID = @"119863563@qq.com";
            order.outTradeNO = good.serialNumber; //订单ID（由商家自行制定）
            order.subject = good.order.orderDesc; //商品标题
//            order.body = product.body; //商品描述
//            order.totalFee = [NSString stringWithFormat:@"%.2f",product.price]; //商品价格
            order.totalFee = @"0.01";
            order.notifyURL =  @"http://123.56.192.182/alipayNotify.jsp"; //回调URL
            
            order.service = @"mobile.securitypay.pay";
            order.paymentType = @"1";
            order.inputCharset = @"utf-8";
            order.itBPay = @"30m";
            order.showURL = @"m.alipay.com";
            
            //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
            NSString *appScheme = @"JLshopios";
            
            //将商品信息拼接成字符串
            NSString *orderSpec = [order description];
            NSLog(@"orderSpec = %@",orderSpec);
            
            //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
            id<DataSigner> signer = CreateRSADataSigner(privateKey);
            NSString *signedString = [signer signString:orderSpec];
            
            //将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = nil;
            if (signedString != nil) {
                orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                               orderSpec, signedString, @"RSA"];
                
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                    NSLog(@"reslut = %@",resultDic);
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
           
            
            
         /*
            //将商品信息赋予AlixPayOrder的成员变量
            Order* order = [Order new];
//            order.partner = appID;
            order.partner = pid;
            order.sellerID = @"119863563@qq.com";
            order.outTradeNO = good.serialNumber;
            order.totalFee = @"0.01";
            
//            order.notify_url = @"http://123.56.192.182/alipayNotify.jsp";
          
            
            // NOTE: app_id设置
//            order.app_id = appID;
            
            // NOTE: 支付接口名称
//            order.method = @"alipay.trade.app.pay";
            
            // NOTE: 参数编码格式
//            order.charset = @"utf-8";
            
            // NOTE: 当前时间点
            NSDateFormatter* formatter = [NSDateFormatter new];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//            order.timestamp = [formatter stringFromDate:[NSDate date]];
            
            // NOTE: 支付版本
//            order.version = @"1.0";
            
            // NOTE: sign_type设置
//            order.sign_type = @"RSA";
            
            // NOTE: 商品数据
//            order.biz_content = [BizContent new];
            //描述 好像没有
//            order.biz_content.seller_id = @"119863563@qq.com";
            //order.biz_content.body = good.description;
            order.subject = good.order.orderDesc;
//            order.biz_content.out_trade_no = good.serialNumber; //订单ID（由商家自行制定）
//            order.biz_content.timeout_express = @"30m"; //超时时间设置
//TODO:价格修改
//            order.biz_content.total_amount = [NSString stringWithFormat:@"%.2f", [good.order.payMoney floatValue]]; //商品价格
//            order.biz_content.total_amount = @"0.01";
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
          */
//                    NSLog(@"reslut = %@",resultDic);
//                    [subscriber sendNext:resultDic];
//                    [subscriber sendCompleted];
//                }];
//            }
//            
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
@implementation SysInvoice


@end
