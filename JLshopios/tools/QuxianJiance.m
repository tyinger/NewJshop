//
//  QuxianJiance.m
//  JLshopios
//
//  Created by 洪彬 on 16/10/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "QuxianJiance.h"

@implementation QuxianJiance

+ (RACSignal *)xiangjiquanxian{
    
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusNotDetermined) {
            
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                
                if (granted == YES) {
                    
                    [subscriber sendNext:@(YES)];
                    [subscriber sendCompleted];
                }else{
                    
                    [subscriber sendNext:@(NO)];
                    [subscriber sendCompleted];
                }
            }];
        }else if ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo] == AVAuthorizationStatusAuthorized){
            
            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
        }else{
            
            [subscriber sendNext:@(NO)];
            [subscriber sendCompleted];
        }
        
        return nil;
    }];
}

@end
