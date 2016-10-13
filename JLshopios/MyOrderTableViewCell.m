//
//  MyOrderTableViewCell.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyOrderTableViewCell.h"

@interface MyOrderTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPirceLabel;

@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (weak, nonatomic) IBOutlet UIImageView *orderImageOne;
@property (weak, nonatomic) IBOutlet UIImageView *orderImageTwo;
@property (weak, nonatomic) IBOutlet UIImageView *moreImage;



@end

@implementation MyOrderTableViewCell
- (void)setOrder:(SysOrder *)order{
    _order = order;
    NSArray * stat = @[@"待付款",@"已付款",@"支付失败",@"取消支付"];
    _shopNameLabel.text = order.shop.name;
    _orderPirceLabel.text = order.money;
    _orderStateLabel.text = stat[[order.payStatus integerValue]];
    
    NSInteger orderNumber = _order.orderDetails.count;
    if (orderNumber == 1) {
        [_orderImageOne sd_setImageWithURL:[NSURL URLWithString:_order.orderDetails[0].goods.icon]];
        _orderImageOne.hidden = NO;
        _orderImageTwo.hidden = YES;
        _moreImage.hidden = YES;
        _moreImage.image = [UIImage imageNamed:@"refresh.png"];
    }else if(orderNumber == 2){
        [_orderImageOne sd_setImageWithURL:[NSURL URLWithString:_order.orderDetails[0].goods.icon]];
        [_orderImageTwo sd_setImageWithURL:[NSURL URLWithString:_order.orderDetails[1].goods.icon]];
        _orderImageOne.hidden = NO;
        _orderImageTwo.hidden = NO;
        _moreImage.hidden = YES;
    }else{
        [_orderImageOne sd_setImageWithURL:[NSURL URLWithString:_order.orderDetails[0].goods.icon]];
        [_orderImageTwo sd_setImageWithURL:[NSURL URLWithString:_order.orderDetails[1].goods.icon]];
        _orderImageOne.hidden = NO;
        _orderImageTwo.hidden = NO;
        _moreImage.hidden = NO;
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
