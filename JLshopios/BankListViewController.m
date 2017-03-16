//
//  BankListViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "BankListViewController.h"
#import "BankListTableViewCell.h"
#import "BankCardModel.h"
#import "AddBankViewController.h"
@interface BankListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainView;
@property (nonatomic, strong) NSMutableArray <BankCardModel*>* dataArray;

@end

@implementation BankListViewController
- (NSMutableArray<BankCardModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"银行卡";
    // Do any additional setup after loading the view from its nib.
    [self setUpTable];
}
- (void)setUpTable{
    self.mainView.rowHeight = 100;
    [self.mainView registerNib:[UINib nibWithNibName:@"BankListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.mainView.tableFooterView = [UIView new];
//    [self request];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)addClick:(id)sender {
    AddBankViewController * add = [[AddBankViewController alloc] init];
    [self.navigationController pushViewController:add animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self request];
    
}
- (void)request{
    [self.dataArray removeAllObjects];
    [FYTXHub progress:@"请稍等"];
    /*
     https://123.56.192.182:8443/app/Score/tomybankcardPage?&userId=8
     */
    NSString * urlString = [NSString stringWithFormat:@"https://123.56.192.182:8443/app/Score/tomybankcardPage?&userId=%@",[LoginStatus sharedManager].idStr];
    [QSCHttpTool get:urlString parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
   
        
        NSLog(@"json 9627 === %@",json);
        for (NSDictionary* value in json) {
            BankCardModel * model =  [BankCardModel objectWithKeyValues:value];
            model.user = [LoginStatus objectWithKeyValues:model.user];
         
            [self.dataArray  addObject:model];
        }
        
        [self.mainView reloadData];
    } failure:^(NSError *error) {
       
        
        NSLog(@"/*****************************    **********************************/%@",error);
        [FYTXHub toast:@"网络错误"];
    }];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BankListTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (self.dataArray.count) {
        cell.model = self.dataArray[indexPath.row];
        cell.deleteAction = ^{
            [self request];
        };
        cell.defaultAction = ^{
            TTAlert(@"设置成功");
            [self request];
        };
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"暂无订单,快去挑选商品吧！"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //选择某一个银行卡
    
    !_result?:_result(self.dataArray[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
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
