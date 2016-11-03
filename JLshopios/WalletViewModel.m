//
//  WalletViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//
#import "WithDrawBankViewController.h"
#import "WalletViewModel.h"

@implementation WalletViewModel
- (void)payAction{
    WithDrawBankViewController * WithDrawVC = [[WithDrawBankViewController alloc] init];
    WithDrawVC.canUseMoney = self.userablemoney;
    [self.owner.navigationController pushViewController:WithDrawVC animated:YES];
//    TTAlert(@"点击提现");
}
- (NSMutableArray<WallteDetailModel *> *)walletDetailData{
    if (!_walletDetailData) {
        _walletDetailData = [NSMutableArray array];
    }
    return _walletDetailData;
}
- (RACSignal*)getTheScore{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [FYTXHub progress:@"正在加载"];
        /*
         https://123.56.192.182:8444/app/Score/getSumAndUseScore?
         userId
         */
        NSString *  urlString = @"https://123.56.192.182:8443/app/Score/mywallet_page?";
            NSString * idStr = [LoginStatus sharedManager].idStr;
//        NSString * idStr = @"6";
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
- (RACSignal * )getTheScoreDetailWithPage:(NSInteger)page{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [FYTXHub progress:@"正在加载"];
        
        NSString *  urlString = @"https://123.56.192.182:8443/app/Score/getUserFundEventdetailList?";
            NSString * idStr = [LoginStatus sharedManager].idStr;
//        NSString * idStr =@"20";
        NSDictionary * dic = @{@"userId":idStr,@"pageno":[NSString stringWithFormat:@"%ld",(long)page],@"pagesize":@"10"};
        
        NSString *parameterStr = [dic JSONString];
        NSDictionary *para = @{@"arg0":parameterStr};
        [QSCHttpTool get:urlString parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
            [self.owner.mainTableView.mj_header endRefreshing];
             [self.owner.mainTableView.mj_footer endRefreshing];
            [FYTXHub dismiss];
            NSLog(@"JSON = %@",json);
            NSArray * data = [[[json rac_sequence] map:^id(id value) {
                return [WallteDetailModel objectWithKeyValues:value];
            }] array];
            [self.walletDetailData addObjectsFromArray:data];
           
            [self.owner.mainTableView reloadData];
            
            [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [FYTXHub dismiss];
            [self.owner.mainTableView.mj_header endRefreshing];
            [self.owner.mainTableView.mj_footer endRefreshing];
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
        cell.detailTextLabel.textColor = QSCRedColor;
    }
    if (self.walletDetailData.count) {
        cell.textLabel.text = [self.walletDetailData[indexPath.row].eventType isEqualToString:@"2"]?@"消费":@"收入";
        cell.detailTextLabel.text =[self.walletDetailData[indexPath.row].eventType isEqualToString:@"2"]? [NSString stringWithFormat:@"-%.2f",[self.walletDetailData[indexPath.row].eventmoney floatValue]]:[NSString stringWithFormat:@"+%.2f",[self.walletDetailData[indexPath.row].eventmoney floatValue]];
    }
    
    return cell;
}
@end
