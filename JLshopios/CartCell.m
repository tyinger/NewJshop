//
//  CartCell.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "CartCell.h"
#import "GoodModel.h"
#import "ChartNumberCountView.h"
@interface CartCell()

@property (weak, nonatomic) IBOutlet UILabel        *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel        *GoodsPricesLabel;
@property (weak, nonatomic) IBOutlet UIImageView    *goodsImageView;
@end

@implementation CartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_nummberCount sx_addAction:^{
        return ;
    }];
    
}
+ (CGFloat)getCartCellHeight{
    return 100;
}
- (void)setModel:(GoodModel *)model{
    
    self.goodsNameLabel.text             = model.goodName;
    self.GoodsPricesLabel.text           = [NSString stringWithFormat:@"￥%.2f",[model.price floatValue]];
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.goodImg]];
    self.nummberCount.totalNum           = 99;
    self.nummberCount.currentCountNumber = [model.num integerValue];
    self.selectShopGoodsButton.selected  = model.isSelect;
    
    //本地数据
    if(model.iconImage){
        self.goodsImageView.image = model.iconImage;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
