//
//  LoginStatus.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/7.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "LoginStatus.h"

#import <AdSupport/AdSupport.h>

@interface LoginStatus()

@end

@implementation LoginStatus

+ (LoginStatus *)sharedManager{
    
    static LoginStatus *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
        NSString *documentDirectory = [directoryPaths objectAtIndex:0];
        
        NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"LoginStatus.plist"];
        if (![fileManager fileExistsAtPath:filePath]) {
            
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
            
        }
    }
    return self;
}

- (void)start{
    
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"LoginStatus.plist"];
    NSDictionary *json = [NSDictionary dictionaryWithContentsOfFile:filePath];
    
    if ([json valueForKey:@"id"]) {
        
        self.login = YES;
    }else{
        
        self.login = NO;
    }
    
    if (self.login == YES) {
        
        self.age = [json valueForKey:@"age"];
        self.birthday = [json valueForKey:@"birthday"];
        self.createDate = [json valueForKey:@"createDate"];
        self.headPic = [json valueForKey:@"headPic"];
        self.idStr = [json valueForKey:@"id"];
        self.lockScore = [json valueForKey:@"lockScore"];
        self.loginName = [json valueForKey:@"loginName"];
        self.name = [json valueForKey:@"name"];
        self.password = [json valueForKey:@"password"];
        self.phone = [json valueForKey:@"phone"];
        self.rank = [json valueForKey:@"rank"];
        self.recommendCode = [json valueForKey:@"recommendCode"];
        self.recommendCodePic = [json valueForKey:@"recommendCodePic"];
        self.score = [json valueForKey:@"score"];
        self.sex = [json valueForKey:@"sex"];
        self.status = [json valueForKey:@"status"];
    }
}
- (void)end{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"LoginStatus.plist"];
    [fileManager removeItemAtPath:filePath error:nil];
    
    //清除数据 就这样子吧
    self.age = nil;
    self.birthday = nil;
    self.createDate = nil;
    self.headPic = nil;
    self.idStr = nil;
    self.lockScore = nil;
    self.loginName = nil;
    self.name = nil;
    self.password = nil;
    self.phone = nil;
    self.rank = nil;
    self.recommendCode = nil;
    self.recommendCodePic = nil;
    self.score = nil;
    self.sex = nil;
    self.status = nil;
}

- (void)setJson:(NSDictionary *)json{
    
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"LoginStatus.plist"];
    
    [json writeToFile:filePath atomically:YES];
    
    self.age = [json valueForKey:@"age"];
    self.birthday = [json valueForKey:@"birthday"];
    self.createDate = [json valueForKey:@"createDate"];
    self.headPic = [json valueForKey:@"headPic"];
    self.idStr = [json valueForKey:@"id"];
    self.lockScore = [json valueForKey:@"lockScore"];
    self.loginName = [json valueForKey:@"loginName"];
    self.name = [json valueForKey:@"name"];
    self.password = [json valueForKey:@"password"];
    self.phone = [json valueForKey:@"phone"];
    self.rank = [json valueForKey:@"rank"];
    self.recommendCode = [json valueForKey:@"recommendCode"];
    self.recommendCodePic = [json valueForKey:@"recommendCodePic"];
    self.score = [json valueForKey:@"score"];
    self.sex = [json valueForKey:@"sex"];
    self.status = [json valueForKey:@"status"];
}

@end
