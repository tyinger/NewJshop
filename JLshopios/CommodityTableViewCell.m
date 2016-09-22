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
    if ([LoginStatus sharedManager].status) {
        self.addGoodsBtnAction(1);
    }else{
        [FYTXHub toast:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });

    }
    
}

- (IBAction)deleteGoods:(id)sender {
//    [self.commodityGoodNumer setTitle:[NSString stringWithFormat:@"%d",arc4random()%1] forState:UIControlStateNormal];
    if (![self.commodityGoodNumer.titleLabel.text isEqualToString:@"0"] && [LoginStatus sharedManager].status) {
        self.addGoodsBtnAction(-1);
    }else{
        ![LoginStatus sharedManager].status ? [FYTXHub toast:@"请先登录"] : nil;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });

    }
    
}

@end



