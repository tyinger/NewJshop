//
//  CommodityPackCell.h
//  jdmobile
//
//  Created by 丁博洋 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface CommodityPackCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
#pragma mark - 显示数据
- (void)showInfo:(ShopDetailModel *)model;
@end
