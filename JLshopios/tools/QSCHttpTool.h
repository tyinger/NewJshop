//
//  QSCHttpTool.h
//  qingsongchou
//
//  Created by Chai on 15/9/9.
//  Copyright (c) 2015年 Chai. All rights reserved.
//


#import <Foundation/Foundation.h>
typedef void (^QSCSuccess)(id json);
typedef void (^QSCFailure)(NSError *error);
typedef void (^ImageHttpSuccessBlock)(id JSON);
typedef void (^ImageHttpFailureBlock)(NSError *error);
typedef void (^ImageUploadProgress)(NSUInteger bytesWritten,long long totalBytesWritten,long long totalBytesExpectedToWrite);

@interface QSCHttpTool : NSObject

@property (nonatomic, assign) BOOL  isNeedToken;

+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure;

+ (void)post:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure;

+ (void)deleted:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure;

+ (void)put:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure;

+ (void)patch:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure;


/**
 *  上传图片
 *
 *  @param path        <#path description#>
 *  @param params      <#params description#>
 *  @param headimgName <#headimgName description#>
 *  @param image       <#image description#>
 *  @param success     <#success description#>
 *  @param failure     <#failure description#>
 */
+ (void)uploadImagePath:(NSString *)path params:(NSDictionary *)params kHeadimgName:(NSString *)headimgName image:(UIImage *)image success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure;

+ (void)uploadImagePath:(NSString *)path params:(NSDictionary *)params kHeadimgName:(NSString *)headimgName image:(UIImage *)image progress:(ImageUploadProgress)progress success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure;


//+ (void)uploadIconPath:(NSString *)path image:(UIImage *)image success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure;


@end
