//
//  MyOrderTableViewCell.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayManager.h"
@class SysOrder;
@interface MyOrderTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (nonatomic, strong) SysOrder*order;
@end
