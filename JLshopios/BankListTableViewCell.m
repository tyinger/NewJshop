//
//  BankListTableViewCell.m
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BankListTableViewCell.h"
@interface BankListTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *setDefault;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UIButton *defaultButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@end
@implementation BankListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _setDefault.userInteractionEnabled = YES;
    UITapGestureRecognizer * defaultGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(defaultSetting)];
    [_setDefault addGestureRecognizer:defaultGes];
}

- (void)setModel:(BankCardModel *)model{
    _model = model;
    
    _nameLabel.text = model.name;
    _cardNumberLabel.text = model.cardNo;
    
    
    if ([model.isdefault isEqualToString:@"1"]) {
        _defaultButton.selected = YES;
    }else{
        _defaultButton.selected = NO;
    }
    [_defaultButton addTarget:self action:@selector(setDefault:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton addTarget:self action:@selector(delete) forControlEvents:UIControlEventTouchUpInside];
}
- (void)defaultSetting{
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"确定设置默认银行卡" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [[av rac_buttonClickedSignal] subscribeNext:^(NSNumber* index) {
        if ([index isEqualToNumber:@(1)]) {
            //点击了确定
            //userId     val 固定传1  id;
            NSDictionary * para =  @{@"userId":[LoginStatus sharedManager].idStr,@"val":@"1",@"id":self.model.Id};
            [FYTXHub progress:@"请稍等"];
            [QSCHttpTool get:[NSString stringWithFormat:@"https://123.56.192.182:8443/app/Score/setbankcarddefault?"] parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
                [FYTXHub dismiss];
                if ([json[@"status"] boolValue]==YES) {
                    if (_defaultAction) {
                        _defaultAction();
                    }
                }else{
                    TTAlert(json[@"msg"]);
                }
            } failure:^(NSError *error) {
                TTAlert(@"设置失败");
                
                NSLog(@"/*****************************    **********************************/%@",error);
                [FYTXHub dismiss];
            }];
            
        }
    }];
    [av show];
   }
- (void)delete{
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定删除" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [[av rac_buttonClickedSignal] subscribeNext:^(NSNumber* index) {
        if ([index isEqualToNumber:@(1)]) {
            //点击了确定
            [QSCHttpTool get:[NSString stringWithFormat:@"https://123.56.192.182:8443/app/Score/deletebankcarddefault?&bankId=%@",self.model.Id] parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
                [FYTXHub dismiss];
                if ([json[@"status"] boolValue]==YES) {
                    if (_deleteAction) {
                        _deleteAction();
                    }
                }
                
                
                
            } failure:^(NSError *error) {
                TTAlert(@"删除失败");
                
                NSLog(@"/*****************************    **********************************/%@",error);
                [FYTXHub dismiss];
            }];

        }
    }];
    [av show];
    

   
 
}
- (void)setDefault:(UIButton *)sender{
    sender.selected = !sender.selected;
//    TTAlert(@"设为默认");
    [self defaultSetting];
 

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
