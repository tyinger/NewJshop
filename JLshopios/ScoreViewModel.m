//
//  ScoreViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ScoreViewModel.h"
@interface ScoreViewModel()
@property (nonatomic, assign) BOOL needEmpty;
@end
@implementation ScoreViewModel
- (NSMutableArray<ScoreDetailModel *> *)scoreDetailData{
    if (!_scoreDetailData) {
        _scoreDetailData = [NSMutableArray array];
    }
    return _scoreDetailData;
}
- (void)getTheScoreSuccess:(void (^)(id))success{
    [FYTXHub progress:@"正在加载"];
    
    /*
     https://123.56.192.182:8444/app/Score/getSumAndUseScore?
     userId
     */
    NSString *  urlString = @"https://123.56.192.182:8444/app/Score/getSumAndUseScore?";
    //    NSString * idStr = [LoginStatus sharedManager].idStr;
    NSString * idStr =@"37";
    [QSCHttpTool get:urlString parameters:@{@"userid":idStr} isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        success?success(json):nil;
        
        //计算数量
        } failure:^(NSError *error) {
            self.needEmpty = YES;
            [self.owner.mainTableView reloadData];
        [FYTXHub dismiss];
        //        TTAlert(@"网络请求出错");
    }];

}
- (RACSignal *)getTheScore{
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    [FYTXHub progress:@"正在加载"];
    /*
     https://123.56.192.182:8444/app/Score/getSumAndUseScore?
     userId
     */
    NSString *  urlString = @"https://123.56.192.182:8443/app/Score/getSumAndUseScore?";
    NSString * idStr = [LoginStatus sharedManager].idStr;
//         NSString * idStr =@"20";
    [QSCHttpTool get:urlString parameters:@{@"userId":idStr} isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        self.userusedScore = [NSString stringWithFormat:@"%@",json[@"userusedScore"]];
                 self.totalScore = [NSString stringWithFormat:@"%@",json[@"score"]];
            NSInteger canuse = [json[@"score"] integerValue]- [json[@"userusedScore"] integerValue];
            self.canUseScore = [NSString stringWithFormat:@"%ld",(long)canuse];
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
- (RACSignal *)getTheScoreDetailWithPage:(NSInteger)page{
    /*https://123.56.192.182:8445/app/Score/getMoreScoreDetailevent?
    /userId
    pageno
    pagesize
     */
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [FYTXHub progress:@"正在加载"];
      
        NSString *  urlString = @"https://123.56.192.182:8443/app/Score/getMoreScoreDetailevent?";
            NSString * idStr = [LoginStatus sharedManager].idStr;
//        NSString * idStr =@"20";
        
        NSDictionary * dic = @{@"userId":idStr,@"pageno":[NSString stringWithFormat:@"%ld",(long)page],@"pagesize":@"10"};
        
        NSString *parameterStr = [dic JSONString];
        NSDictionary *para = @{@"arg0":parameterStr};
       
        
        [QSCHttpTool get:urlString parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
            NSLog(@"JSON = %@",json);
            [self.owner.mainTableView.mj_header endRefreshing];
            
            [FYTXHub dismiss];
            NSLog(@"JSON = %@",json);
            if (((NSArray*)json).count<10) {
                [self.owner.mainTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.owner.mainTableView.mj_footer endRefreshing];
            }
            NSArray * data = [[[json rac_sequence] map:^id(id value) {
//                ScoreDetailModel * model = [[ScoreDetailModel alloc] init];
//                [model setValuesForKeysWithDictionary:value];
//                return model;
                return [ScoreDetailModel objectWithKeyValues:value];
            }] array];
            [self.scoreDetailData addObjectsFromArray:data];
            self.needEmpty = YES;
            [self.owner.mainTableView reloadData];
            

            [FYTXHub dismiss];
             [subscriber sendCompleted];
        } failure:^(NSError *error) {
            [FYTXHub dismiss];
            self.needEmpty = YES;
            [self.owner.mainTableView reloadData];
            NSLog(@"%@",error);
            [subscriber sendError:error];
            //        TTAlert(@"网络请求出错");
        }];
        return nil;
    }];
    return result;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return[[NSAttributedString alloc] initWithString:@"对不起，目前无更多信息" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:18]}];
}
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return self.needEmpty;
}
@end
