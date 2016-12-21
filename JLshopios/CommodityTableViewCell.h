//
//  CommodityTableViewCell.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/19.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^AddGoodsBtnAction)(NSInteger numberOne);
@interface CommodityTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *commodityImg;


@property (strong, nonatomic) IBOutlet UILabel *commodityName;
@property (strong, nonatomic) IBOutlet UILabel *commodityPrice;
@property (strong, nonatomic) IBOutlet UIImageView *commodityZX;
@property (strong, nonatomic) IBOutlet UILabel *commodityPraise;

@property (weak, nonatomic) IBOutlet UIButton *commodityGoodNumer;

@property (copy, nonatomic) AddGoodsBtnAction addGoodsBtnAction;


//Mars增加
@property (weak, nonatomic) IBOutlet UIView *numberButtonBgView;
@end


