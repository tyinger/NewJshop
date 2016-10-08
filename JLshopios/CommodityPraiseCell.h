//
//  CommodityPraiseCell.h
//  jdmobile
//
//  Created by 丁博洋 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopDetailModel.h"
@interface CommodityPraiseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *simpleAddressLabel;
@property (assign, nonatomic) CGFloat cellHeight;
- (void)showInfo:(ShopDetailModel *)model;
@end
