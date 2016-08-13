//
//  LoginStatus.h
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/7.
//  Copyright © 2016年 feng. All rights reserved.
//

/**
 *  登录状态获取单例
 *
 *  @param LoginStatus
 *
 *  @return
 */

#import <Foundation/Foundation.h>

@interface LoginStatus : NSObject

+ (LoginStatus *)sharedManager;

/**
 *  登录状态的设置，只在登录的时候才做赋值
 *
 *  @param login
 */
- (void)setLogin: (BOOL)login;


/**
 *  YES为已经登录状态
 */
@property (nonatomic,readonly,getter=isLogin) BOOL login;

@end
