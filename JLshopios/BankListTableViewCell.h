//
//  BankListTableViewCell.h
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankCardModel.h"
@interface BankListTableViewCell : UITableViewCell
@property (nonatomic, strong) BankCardModel * model;
@property (nonatomic, strong) void(^deleteAction)(void);
@end
