//
//  CartCell.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodModel,ChartNumberCountView;
@interface CartCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *selectShopGoodsButton;

@property (weak, nonatomic) IBOutlet ChartNumberCountView *nummberCount;

@property (nonatomic, strong) GoodModel *model;

+ (CGFloat)getCartCellHeight;
@end
