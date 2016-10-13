//
//  CommoditySelectCell.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface CommoditySelectCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *DetailAddressLatel;

/// 根据数据模型来显示内容
- (void)showInfo:(ShopDetailModel *)model;
@end
