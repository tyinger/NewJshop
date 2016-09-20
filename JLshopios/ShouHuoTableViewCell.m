//
//  ShouHuoTableViewCell.m
//  JLshopios
//
//  Created by mymac on 16/9/18.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShouHuoTableViewCell.h"

@implementation ShouHuoTableViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)isDefaultAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [FYTXHub progress:@"数据更新中..."];

    if (self.cellBtnBlock) {
        self.cellBtnBlock(sender);
    }
    
}

- (IBAction)modifyAction:(UIButton *)sender {
    
    if (self.cellBtnBlock) {
        self.cellBtnBlock(sender);
    }
}

- (IBAction)deteleAction:(UIButton *)sender {
    
    if (self.cellBtnBlock) {
        self.cellBtnBlock(sender);
    }
}

@end
