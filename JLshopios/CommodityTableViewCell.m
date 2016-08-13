//
//  CommodityTableViewCell.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/19.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityTableViewCell.h"

@implementation CommodityTableViewCell
- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.width = [UIScreen mainScreen].bounds.size.width;
}
@end



