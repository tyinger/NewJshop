//
//  GoodModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodModel : NSObject
{
    @public
    NSString * _goodName;
    NSString * _num;
    NSString * _price;
    UIImage  * _iconImage;
}
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString * goodImg;
@property (nonatomic, copy) NSString * goodName;
@property (nonatomic, copy) NSString * goodid;
@property (nonatomic, copy) NSString * jsFlag;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * price;
@property (nonatomic, copy) NSString * shopid;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * Id;

//本地数据
@property (nonatomic, strong) UIImage * iconImage;

//商品是否被选中
@property (nonatomic, assign) BOOL      isSelect;
- (instancetype)initWithData:(id)data;
@end
