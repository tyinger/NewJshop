//
//  PayManager.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlipaySDK/AlipaySDK.h>
#import "GoodModel.h"
@class SysOrderDetail;
@class SysShop;
@class SysGoodsCombination;
@class SysInvoice;
@interface PayManager : NSObject

+ (instancetype)manager;
- (void)getTheOrder;
- (RACCommand*)doAlipayPayWithGood:(GoodModel *)good;

@end

@interface SysOrderDetail : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *goodsType; //商品类型,见EnumOrderDetailGoodsType.java
@property (nonatomic, copy) NSString *fkId;
@property (nonatomic, copy) GoodModel *goods;
@property (nonatomic, copy) SysGoodsCombination *combination;
@property (nonatomic, copy) NSString *goodsNum;
@property (nonatomic, copy) NSString *unitPrice;
@property (nonatomic, copy) NSString *goodsTotal;
@property (nonatomic, copy) NSString *status; //状态,EnumOrderDetailStatus.java
@end

@interface SysShop : NSObject
@end

@interface SysGoodsCombination : NSObject
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *goodsId;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *sku;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *createTime;
@end
//static NSString * serialVersionUID:@"6014327325401693920L";
@interface SysOrder : NSObject

@property (nonatomic, copy) NSString *id;						//主键
@property (nonatomic, copy) NSString *subject;					//订单名称
@property (nonatomic, copy) NSString * orderDesc;				//订单描述
@property (nonatomic, copy) SysShop* shop;					//商铺
//private SysUser user;					//用户
@property (nonatomic, copy) NSString * money;					//订单金额
@property (nonatomic, copy) NSString * payMoney;				//支付金额
@property (nonatomic, copy) NSString *payScore;				//使用积分
@property (nonatomic, copy) NSString * orderType;				//订单类型0普通订单1退货单2换货单 4当面付
@property (nonatomic, copy) NSString *sendType;					//配送类型 便利店订单使用
@property (nonatomic, copy) NSString *deliveryFee;				//配送费用/邮费
@property (nonatomic, copy) NSString * deliveryTime;			//配送时间 便利店使用
@property (nonatomic, copy) NSString * payStatus;				//支付状态 见EnumOrderPayStatus.java
@property (nonatomic, copy) NSString * showStatus;				//显示状态EnumOrderShowStatus.java 0正常 1系统删除 2用户删除
@property (nonatomic, copy) NSString * deliveryStatus;			//物流状态EnumOrderDeliveryStatus.java
@property (nonatomic, copy) SysOrder* refundOrder;			//退换货订单
@property (nonatomic, copy) NSString *refundStatus;				//退换货状态EnumOrderRefundStatus.java
@property (nonatomic, copy) NSString * clearStatus;				//清算状态EnumOrderClearSatus.java
@property (nonatomic, copy) NSString * commentStatus;			//评价状态 见EnumOrderCommentStatus.java
@property (nonatomic, copy) NSString * serialNumber;			//流水号
@property (nonatomic, copy)  SysInvoice* invoice;				//发货单
@property (nonatomic, copy) NSString * receiveUser;				//收货人姓名
@property (nonatomic, copy) NSString *receiveAdd;				//收货地址
@property (nonatomic, copy) NSString * userPhone;				//收货人联系方式
@property (nonatomic, copy) NSString * createTime;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *clearTime;			//清算日期

@property (nonatomic, copy) NSString *originSerialNumber;	//原订单流水号

@property (nonatomic, copy) NSString * changeTime;//物流更新时间,deliveryStatus更新  即更新此字段
@property (nonatomic, copy) NSString * refundsTime;//退换货时间,退换货业务最后更新时间
@end



@interface SysInvoice : NSObject

@property (nonatomic, copy) NSString *  id;
@property (nonatomic, copy) NSString *  serialNumber;
@property (nonatomic, copy) NSString *  companyName;
@property (nonatomic, copy) NSString *  companyCode;
@property (nonatomic, copy) NSString *  deliveryNumber;
@property (nonatomic, copy) NSString *  createDate;
@end