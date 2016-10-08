//
//  WalletViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "WalletViewModel.h"

@implementation WalletViewModel
- (void)payAction{
    TTAlert(@"点击提现");
}
- (RACSignal*)getTheScore{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [FYTXHub progress:@"正在加载"];
        /*
         https://123.56.192.182:8444/app/Score/getSumAndUseScore?
         userId
         */
        NSString *  urlString = @"https://123.56.192.182:8443/app/Score/mywallet_page?";
        //    NSString * idStr = [LoginStatus sharedManager].idStr;
        NSString * idStr =@"6";
        [QSCHttpTool get:urlString parameters:@{@"userId":idStr} isShowHUD:YES httpToolSuccess:^(id json) {
            [FYTXHub dismiss];
            self.userablemoney = [NSString stringWithFormat:@"%@",json[@"userablemoney"]];
            self.totalprofit = [NSString stringWithFormat:@"%@",json[@"totalprofit"]];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [FYTXHub dismiss];
            [subscriber sendError:error];
            //        TTAlert(@"网络请求出错");
        }];
        return nil;
    }];
    return result;
}
- (RACSignal * )getTheScoreDetail{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [FYTXHub progress:@"正在加载"];
        
        NSString *  urlString = @"https://123.56.192.182:8443/app/Score/getUserFundEventdetailList?";
        //    NSString * idStr = [LoginStatus sharedManager].idStr;
        NSString * idStr =@"20";
        
        NSString *parameterStr = [NSString stringWithFormat:@"{\"userId\":\"%@\",\"pageno\":\"1\",\"pagesize\":\"20\"}",idStr];
        NSDictionary *dic = @{@"arg0":parameterStr};
        [QSCHttpTool get:urlString parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
            NSLog(@"JSON = %@",json);
            
            [FYTXHub dismiss];
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [FYTXHub dismiss];
            NSLog(@"%@",error);
            [subscriber sendError:error];
            //        TTAlert(@"网络请求出错");
        }];
        return nil;
    }];
    return result;

}
#pragma mark - delegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"对不起，目前无更多信息"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.walletDetailData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    
    return cell;
}
@end
