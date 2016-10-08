//
//  CommodityPraiseCell.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityPraiseCell.h"

@implementation CommodityPraiseCell

#pragma mark - 显示数据
- (void)showInfo:(ShopDetailModel *)model
{
    
    self.simpleAddressLabel.text = model.shopAddInfo;
//    CGSize size = CGSizeMake(self.width, 1000);
//    CGSize labelSize = [self.simpleAddressLabel.text sizeWithFont:self.simpleAddressLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByClipping];
//    self.cellHeight = labelSize.height;
    [self layoutSubviews];
    model.cellHeight = self.cellHeight;
}
#pragma mark - 布局
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat nameX=10,nameY=10;
    CGSize size = CGSizeMake(self.width,2000);
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [self.simpleAddressLabel.text sizeWithFont:self.simpleAddressLabel.font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
    self.simpleAddressLabel.frame = CGRectMake(nameX,10, self.contentView.frame.size.width-20, labelsize.height);
    self.cellHeight = CGRectGetMaxY(self.simpleAddressLabel.frame) + nameY;
}
@end
