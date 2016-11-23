//
//  WithDrawBankViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//
#import "BankTipsViewController.h"
#import "WithDrawBankViewController.h"
#import "BankListViewController.h"
#import "BankCardModel.h"
@interface WithDrawBankViewController ()
@property (weak, nonatomic) IBOutlet UILabel *bankCardLabel;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic)  BankCardModel * mainModel;
@property (weak, nonatomic) IBOutlet UILabel *canUserMoneyLabel;

@end

@implementation WithDrawBankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    _canUserMoneyLabel.text = [NSString stringWithFormat:@"余额%@",self.canUseMoney];
    UITapGestureRecognizer * pushTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushBankList)];
    self.bankCardLabel.userInteractionEnabled = YES;
    [self.bankCardLabel addGestureRecognizer:pushTap];
    [RACObserve(self, mainModel) subscribeNext:^(BankCardModel* x) {
        if (x.bankName.length&&x.accNoView.length) {
            self.bankCardLabel.text = [NSString stringWithFormat:@"%@%@",x.bankName,x.accNoView];

        }
           }];
    [self getTheDefaultCard];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getTheDefaultCard{
    NSString * urlString = [NSString stringWithFormat:@"https://123.56.192.182:8443/app/Score/tomyDefaultbankcard?&userId=%@",[LoginStatus sharedManager].idStr];
            [FYTXHub progress:nil];
    [QSCHttpTool get:urlString parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        
       self.mainModel =  [BankCardModel objectWithKeyValues:json[0]];
        NSLog(@"json 9627 === %@",json);
      
    } failure:^(NSError *error) {
        
        
        NSLog(@"/*****************************    **********************************/%@",error);
        [FYTXHub dismiss];
    }];

}
#pragma mark - method
- (IBAction)confirm:(id)sender {
    if (!_bankCardLabel.text.length) {
        TTAlert(@"请填写银行卡");
        return;
    }
    if (!_priceTextField.text.length||[_priceTextField.text floatValue]<[_canUseMoney floatValue]||[_priceTextField.text isEqualToString:@"0"]) {
       TTAlert(@"金额填写错误");
        return;
    }
    
    
//    NSString * urlString = [NSString stringWithFormat:@"https://123.56.192.182:8443/app/Score/tomyDefaultbankcard?&userId=%@",[LoginStatus sharedManager].idStr];
    /*
     userId
     userwithdraw提现金额
     cardNo银行卡号
     name持卡人姓名
     province 省（规则例如吉林省传参时只传吉林）
     city 市（同上）
     bankName银行名
     */
    NSDictionary * para = @{@"userId":[LoginStatus sharedManager].idStr,@"userwithdraw":_priceTextField.text,@"cardNo":_mainModel.cardNo,@"name":_mainModel.name,@"province":_mainModel.province,@"city":_mainModel.city,@"bankName":_mainModel.bankName};
    NSString * urlString = @"https://123.56.192.182:8443/app/Score/saveuserwithdraw?";
    [FYTXHub progress:nil];
    [QSCHttpTool get:urlString parameters:para isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        
        
        NSLog(@"json 9627 === %@",json);
        TTAlert(json[@"msg"]);
        
    } failure:^(NSError *error) {
        
        
        NSLog(@"/*****************************    **********************************/%@",error);
        [FYTXHub dismiss];
    }];
}
- (void)pushBankList{
    BankListViewController * list = [[BankListViewController alloc] init];
    list.result = ^(BankCardModel * card){
        self.mainModel = card;
        
    };
    [self.navigationController pushViewController:list animated:YES];
}
- (IBAction)tipAction:(id)sender {
    BankTipsViewController * tip = [[BankTipsViewController alloc] init];
    [self.navigationController pushViewController:tip animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
