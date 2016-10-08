//
//  MyOrderViewController.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, OrderType) {
    OrderTypeWaitpay,       //待支付
    OrderTypeWaitsend,      //待发货
    OrderTypeWaitreceive,   //待收货
    OrderTypeWaitComment,   //待评价
    OrderTypeAll,           //全部
};
@interface MyOrderViewController : UIViewController
@property (nonatomic, strong) UITableView *mainView;
@property (nonatomic, assign) OrderType mainType;
- (instancetype)initWithType:(OrderType)type;
@end
