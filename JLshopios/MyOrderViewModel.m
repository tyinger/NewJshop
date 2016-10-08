//
//  MyOrderViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyOrderViewModel.h"
#import "QSCHttpTool.h"
@implementation MyOrderViewModel
- (RACCommand *)getTheData{
     return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            /*
             https://123.56.192.182:8443/app/appOrderController/ajaxOrderRecdsPage?
             */
            [FYTXHub progress:@"正在加载"];
            
            NSString *  urlString = @"https://123.56.192.182:8443/app/appOrderController/ajaxOrderRecdsPage?";
            //    NSString * idStr = [LoginStatus sharedManager].idStr;
            NSString * idStr = @"6";
            
            NSDictionary *dic = @{@"arg0":@{@"id":idStr,@"begin":@"1",@"type":@""}};
            [QSCHttpTool get:urlString parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
                [FYTXHub dismiss];
                NSLog(@"%@",json);
            } failure:^(NSError *error) {
                   NSLog(@"/*****************************    **********************************/%@",error);
            }];
            
       

            
            
            
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
@end
