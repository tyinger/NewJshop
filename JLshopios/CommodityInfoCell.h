//
//  CommodityInfoCell.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/23.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsMode.h"
#import "TYAttributedLabel.h"
#import "TYLinkTextStorage.h"
#import "ShopDetailModel.h"
#define kHeightCommodityInfo 180
@interface CommodityInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *activityLabel;
@property (nonatomic, strong) UILabel *priceyLabel;//商品价钱
@property (nonatomic, strong) UIImageView *imgZXImageview;//专项图片
@property (nonatomic, strong) UILabel *txtZXLabel;//专项文字

@property (nonatomic, assign) CGFloat cellHigh;

/// 根据数据模型来显示内容
- (void)showInfo:(DetailsMode *)model;

//商铺数据模型显示内容
- (void)showShopInfo:(ShopDetailModel *)shopModel;
@end
