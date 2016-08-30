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

- (void)start;
//退出
- (void)end;

/**
 *  登录状态的设置，只在登录的时候才做赋值
 *
 *  @param login
 */
//- (void)setLogin: (BOOL)login;

- (void)setJson:(NSDictionary *)json;


/**
 *  YES为已经登录状态
 */
@property (nonatomic,assign) BOOL login;

@property (nonatomic,strong) NSString *age;
@property (nonatomic,strong) NSString *birthday;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *headPic;
@property (nonatomic,strong) NSString *idStr;
@property (nonatomic,strong) NSString *lockScore;
@property (nonatomic,strong) NSString *loginName;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *rank;
@property (nonatomic,strong) NSString *recommendCode;
@property (nonatomic,strong) NSString *recommendCodePic;
@property (nonatomic,strong) NSString *score;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *status;

@end
