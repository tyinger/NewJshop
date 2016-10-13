//
//  MyOrderDetailTableViewCell.m
//  JLshopios
//
//  Created by 孙鑫 on 16/10/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyOrderDetailTableViewCell.h"
@interface MyOrderDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodNumLabel;
@end
@implementation MyOrderDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(SysOrderDetail *)model{
    _model = model;
    _goodNumLabel.text = [NSString stringWithFormat:@"x%@",model.goodsNum];
    _goodPriceLabel.text =[NSString stringWithFormat:@"¥:%.2f", [model.unitPrice floatValue]];
    _goodNameLabel.text = model.goods.name;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.goods.icon]] ;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
