//
//  ShouHuoTableViewCell.h
//  JLshopios
//
//  Created by mymac on 16/9/18.
//  Copyright © 2016年 feng. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface ShouHuoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *manName;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailAddr;
@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
@property (weak, nonatomic) IBOutlet UIButton *deteleBtn;
@property (weak, nonatomic) IBOutlet UIButton *isDefaultBtn;

@property (copy, nonatomic) void(^cellBtnBlock)(NSInteger tag);

@end
