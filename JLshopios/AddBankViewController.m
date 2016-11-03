//
//  AddBankViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//
#import "MarsCustomButton.h"
#import "AddBankViewController.h"

@interface AddBankViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    NSArray * bankArray;
}
@property (weak, nonatomic) IBOutlet UITextField *cityLabel;
@property (weak, nonatomic) IBOutlet UITextField *proviceLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNoLabel;
@property (nonatomic, strong) UITableView * bankListView;
@property (nonatomic, strong) UIView * popView;
@property (weak, nonatomic) IBOutlet MarsCustomButton *choseBankButton;

@end

@implementation AddBankViewController
- (UIView *)popView{
    if (!_popView) {
        _popView = [[UIView alloc] initWithFrame:self.view.frame];
//        _popView.alpha = 0;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = self;
        [_popView addSubview:self.bankListView];
        _popView.userInteractionEnabled = YES;
        [_popView addGestureRecognizer:tap];
    }
    return _popView;
}
- (void)tap:(UITapGestureRecognizer *)sender{
    CGPoint point = [sender locationInView:self.view];
    if ((point.x>self.bankListView.x&&point.x<self.bankListView.x+self.bankListView.width)&&(point.y>self.bankListView.y&&point.y<self.bankListView.y+self.bankListView.height)) {
        return;
    }
    [self.popView removeFromSuperview];
}
- (UITableView *)bankListView{
    if (!_bankListView) {
        _bankListView = [[UITableView alloc] initWithFrame:CGRectMake(_choseBankButton.frame.origin.x, _choseBankButton.frame.origin.y+_choseBankButton.height, _choseBankButton.width, self.view.height - 100 -  _choseBankButton.y - _choseBankButton.height) style:UITableViewStylePlain];
        _bankListView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        _bankListView.delegate = self;
        _bankListView.dataSource = self;
//        _bankListView.alpha = 0;
    }
    return _bankListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyBoardDidHide)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    bankArray = @[@"中国银行", @"中国农业银行", @"中国工商银行", @"中国建设银行", @"交通银行", @"招商银行",
                  @"中国民生银行", @"兴业银行", @"上海浦东发展银行", @"广东发展银行", @"中信银行", @"光大银行", @"中国邮政储蓄银行",
                  @"平安银行", @"北京银行", @"南京银行", @"宁波银行", @"上海农村商业银行", @"东亚银行"];
    [_choseBankButton setNeedsDisplay];
    [self.view addSubview:_bankListView];
    [_choseBankButton addTarget:self action:@selector(choseBank:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}
- (void)keyBoardDidShow:(NSNotification*)aNotification{
   
    self.bankListView.y = 0;
}
- (void)keyBoardDidHide{
    self.bankListView.y = self.choseBankButton.y ;
}
- (void)choseBank:(UIButton *)sender{
    [TTKeyWindow() addSubview:self.popView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.font = SXFont(13);
        cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
        
    }
    cell.textLabel.text = bankArray[indexPath.row];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return bankArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_choseBankButton setTitle:bankArray[indexPath.row] forState:UIControlStateNormal];
    [self tap:nil];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
- (IBAction)saveAction:(id)sender {
    if (!_nameLabel.text.length) {
        TTAlert(@"请输入持卡人");
        return;
    }
    if (!_cardNoLabel.text.length) {
        TTAlert(@"请输入银行卡号");
        return;
    }
    if (!_proviceLabel.text.length) {
        TTAlert(@"请输入省份");
        return;
    }
    if (!_cityLabel.text.length) {
        TTAlert(@"请输入城市");
        return;
    }
    
    
    NSString * urlString = @"https://123.56.192.182:8443/app/Score/saveuserbackcard?";
    NSDictionary * paraDic = @{@"name":_nameLabel.text,@"cardNo":_cardNoLabel.text,@"userId":[LoginStatus sharedManager].idStr,@"bankName":_choseBankButton.titleLabel.text,@"province":_proviceLabel.text,@"city":_cityLabel.text};
    NSDictionary * prar = @{@"arg0":[paraDic JSONString]};
    [QSCHttpTool get:urlString parameters:prar isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        
        if ([json[@"status"] boolValue] == YES) {
            NSLog(@"添加成功");
            [self.navigationController popViewControllerAnimated:YES];
        }
        NSLog(@"json 9627 === %@",json);
        
      
    } failure:^(NSError *error) {
        
        
        NSLog(@"/*****************************    **********************************/%@",error);
        [FYTXHub dismiss];
    }];
    

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
