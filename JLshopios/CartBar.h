//
//  CartBar.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartBar : UIView
//结算
@property (nonatomic, strong) UIButton *balanceButton;
//全选
@property (nonatomic, strong) UIButton *selectAllButton;
//合计 （在上面，虽然不知道和总额有啥区别 呵呵哒）
@property (nonatomic, strong) UILabel *totalLabel;
//总额
@property (nonatomic, retain) UILabel *allMoneyLabel;


@property (nonatomic, assign) float money;
@property (nonatomic, assign) float seletedCount;

@end
