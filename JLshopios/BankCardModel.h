//
//  BankCardModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BankCardModel : NSObject
@property (nonatomic, copy) NSString * accNoView;  //卡号后四位
@property (nonatomic, copy) NSString * bankName;
@property (nonatomic, copy) NSString * cardNo;
@property (nonatomic, copy) NSString * city;
@property (nonatomic, copy) NSString * createDate;
@property (nonatomic, copy) NSString * Id;
@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * isdefault;
@property (nonatomic, copy) NSString * province;
@property (nonatomic, strong) LoginStatus * user;
@end
