//
//  JLShopCollectionViewCell.h
//  JLshopios
//
//  Created by daxiongdi on 16/6/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TuiJianView.h"
@class JLGoodModel;

typedef void(^TuiJianBlock)(JLGoodModel *goodModel);
@interface JLShopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *hotView;

@property (weak, nonatomic) IBOutlet UIView *yuShouGoods;

@property (weak, nonatomic) IBOutlet UIView *zhidemai;
@property (weak, nonatomic) IBOutlet UIView *jingxuantuijian;
@property (copy, nonatomic) TuiJianBlock tuiJianBlock;

@end
