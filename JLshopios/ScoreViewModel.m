//
//  ScoreViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ScoreViewModel.h"

@implementation ScoreViewModel
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
//    NSString * idStr = [LoginStatus sharedManager].idStr;
         NSString * idStr =@"6";
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
- (RACSignal *)getTheScoreDetail{
    /*https://123.56.192.182:8445/app/Score/getMoreScoreDetailevent?
    /userId
    pageno
    pagesize
     */
    RACSignal * result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [FYTXHub progress:@"正在加载"];
      
        NSString *  urlString = @"https://123.56.192.182:8443/app/Score/getMoreScoreDetailevent?";
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
@end
