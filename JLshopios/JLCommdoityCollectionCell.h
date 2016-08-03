//
//  JLCommdoityCollectionCell.h
//  JLshopios
//
//  Created by mymac on 16/7/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JLCommdoityCollectionCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *productionImage;
@property (weak, nonatomic) IBOutlet UILabel *productionName;
@property (weak, nonatomic) IBOutlet UILabel *productionPrise;
@property (weak, nonatomic) IBOutlet UILabel *productionAppraise;

@end
