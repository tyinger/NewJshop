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

- (IBAction)addGoods:(id)sender {
//    [self.commodityGoodNumer setTitle:[NSString stringWithFormat:@"%d",arc4random()%99] forState:UIControlStateNormal];
    self.addGoodsBtnAction(1);
}

- (IBAction)deleteGoods:(id)sender {
//    [self.commodityGoodNumer setTitle:[NSString stringWithFormat:@"%d",arc4random()%1] forState:UIControlStateNormal];
    if (![self.commodityGoodNumer.titleLabel.text isEqualToString:@"0"]) {
        self.addGoodsBtnAction(-1);
    }
    
}

@end



