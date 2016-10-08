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
- (NSMutableArray<OrderModel *> *)dataInfo{
    if (!_dataInfo) {
        _dataInfo = [NSMutableArray array];
    }
    return _dataInfo;
}
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
            
            //这个type根据 owner的type 请求不同
            NSString * type ;
            
            NSDictionary *dic = @{@"arg0":@{@"id":idStr,@"begin":@"1",@"type":@""}};
            [QSCHttpTool get:urlString parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
                [FYTXHub dismiss];
                NSLog(@"%@",json);
                self.dataInfo = [[[[json rac_sequence] map:^id(id value) {
                    return [[OrderModel alloc] initWithData:value];
                    }] array]mutableCopy];
                [self.owner.mainView reloadData];
            } failure:^(NSError *error) {
                   NSLog(@"/*****************************    **********************************/%@",error);
                     [FYTXHub dismiss];
            }];
            
       

            
            
            
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (RACCommand *)payAction{
     return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            TTAlert(@"pay");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (RACCommand *)cancelAction{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            TTAlert(@"cancel");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataInfo.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"暂无订单"];
}
@end
