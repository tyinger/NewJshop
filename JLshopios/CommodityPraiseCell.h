//
//  CommodityPraiseCell.h
//  jdmobile
//
//  Created by 丁博洋 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsMode.h"
@interface CommodityPraiseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *simpleAddressLabel;
- (void)showInfo:(DetailsMode *)model;
@end
