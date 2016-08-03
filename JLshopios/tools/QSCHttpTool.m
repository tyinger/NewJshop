//
//  QSCHttpTool.m
//  qingsongchou
//
//  Created by zhou on 15/9/9.
//  Copyright (c) 2015年 Chai. All rights reserved.
//

#import "QSCHttpTool.h"
#import <AFNetworking/AFNetworking.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "AppDelegate.h"

@implementation QSCHttpTool

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"kudou" ofType:@"cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    //    [NSSet setWithObject:certData]
    //@[certData]
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}


+ (void)get:(NSString *)url parameters:(NSDictionary *)parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
    
//    [[QSCHudView sharedQSCHudView] creatHUD];
//    [QSCHudView sharedQSCHudView].hidden = !showHUD;
    AFHTTPSessionManager *manager = [self getAFHTTPRequestOperationManager];
    
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            httpToolSuccess(responseObject);
//            [QSCHudView sharedQSCHudView].hidden = YES;
//            [[QSCHudView sharedQSCHudView] disMissHUD];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);

        }
    }];
}


+ (void)post:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
//   [[QSCHudView sharedQSCHudView] creatHUD];
//   [QSCHudView sharedQSCHudView].hidden = !showHUD;
    AFHTTPSessionManager *manager = [self getAFHTTPRequestOperationManager];
    
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            httpToolSuccess(responseObject);
//            [QSCHudView sharedQSCHudView].hidden = YES;
//            [[QSCHudView sharedQSCHudView] disMissHUD];
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}

+ (void)deleted:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
//    [[QSCHudView sharedQSCHudView] creatHUD];
//    [QSCHudView sharedQSCHudView].hidden = !showHUD;

    
    AFHTTPSessionManager *manager = [self getAFHTTPRequestOperationManager];
    [manager DELETE:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            httpToolSuccess(responseObject);
//              [QSCHudView sharedQSCHudView].hidden = YES;
//              [[QSCHudView sharedQSCHudView] disMissHUD];
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)put:(NSString *)url parameters:(id )parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
//   [[QSCHudView sharedQSCHudView] creatHUD];
//   [QSCHudView sharedQSCHudView].hidden = !showHUD;
    AFHTTPSessionManager *manager = [self getAFHTTPRequestOperationManager];
    

    [manager PUT:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            httpToolSuccess(responseObject);
//            [QSCHudView sharedQSCHudView].hidden = YES;
//            [[QSCHudView sharedQSCHudView] disMissHUD];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if (failure) {
                failure(error);
            }

    }];
}


+(void)patch:(NSString *)url parameters:(id)parameters isShowHUD:(BOOL)showHUD httpToolSuccess:(QSCSuccess)httpToolSuccess failure:(QSCFailure)failure
{
//    [[QSCHudView sharedQSCHudView] creatHUD];
//    [QSCHudView sharedQSCHudView].hidden = !showHUD;
     AFHTTPSessionManager *manager = [self getAFHTTPRequestOperationManager];
    [manager PATCH:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (httpToolSuccess) {
            httpToolSuccess(responseObject);
//            [QSCHudView sharedQSCHudView].hidden = YES;
//            [[QSCHudView sharedQSCHudView] disMissHUD];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
        
    }];
}


+ (AFHTTPSessionManager *)getAFHTTPRequestOperationManager
{
    MYLog(@"1.getAFHTTPRequestOperationManager");
//    [self getToken];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/plain",@"text/javascript",@"text/html", nil];
     manager.requestSerializer.timeoutInterval = 10.f;

    [manager setSecurityPolicy:[self customSecurityPolicy]];
    return manager;
}


+ (void)uploadImagePath:(NSString *)path params:(NSDictionary *)params kHeadimgName:(NSString *)headimgName image:(UIImage *)image success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure
{
    NSData *data = UIImageJPEGRepresentation(image, 0.7);// 压缩
    // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
    // 要解决此问题，
    // 可以在上传时使用当前的系统时间作为文件名
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [self getAFHTTPRequestOperationManager];
    [mgr POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//       [QSCHudView sharedQSCHudView].hidden = YES;
//       [[QSCHudView sharedQSCHudView] disMissHUD];
        success(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}


+ (void)uploadImagePath:(NSString *)path params:(NSDictionary *)params kHeadimgName:(NSString *)headimgName image:(UIImage *)image progress:(ImageUploadProgress)progress success:(ImageHttpSuccessBlock)success failure:(ImageHttpFailureBlock)failure
{
    NSData *data = UIImageJPEGRepresentation(image, 0.7);// 压缩
    MYLog(@"%f", (CGFloat)data.length / 1024/1024);
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
    
   AFHTTPSessionManager *mgr = [self getAFHTTPRequestOperationManager];
 
  [mgr POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
      progress(uploadProgress.completedUnitCount,uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
//        [QSCHudView sharedQSCHudView].hidden = YES;
//        [[QSCHudView sharedQSCHudView] disMissHUD];
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}





@end
