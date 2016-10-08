//
//  ShopTableViewCell.h
//  JLshopios
//
//  Created by mymac on 16/9/29.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconLogoImage;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopStanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *noFullYouFeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *fullYouFeiLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailInfoLabel;

@end
