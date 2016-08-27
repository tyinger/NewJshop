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
        
        self.login = NO;
        
        self.userId = @"37";
    }
    return self;
}

- (void)setLogin: (BOOL)login{
    
    if (!_login) {
        
        _login = login;
    }
}

@end
