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
- (void)getTheScore{
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
      
               
      
 
        //计算数量
        
        
    } failure:^(NSError *error) {
        [FYTXHub dismiss];
        //        TTAlert(@"网络请求出错");
    }];

}
- (void)getTheScoreDetail{
    /*https://123.56.192.182:8445/app/Score/getMoreScoreDetailevent?
    /userId
    pageno
    pagesize
     */
}
@end
