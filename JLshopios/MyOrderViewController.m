//
//  MyOrderViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyOrderViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderViewModel.h"
@interface MyOrderViewController ()

@property (nonatomic, strong) MyOrderViewModel *viewModel;
@end

@implementation MyOrderViewController
- (UITableView *)mainView{
    if (!_mainView) {
        _mainView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _mainView.delegate = self.viewModel;
        _mainView.dataSource = self.viewModel;
        _mainView.rowHeight = 150;
        _mainView.emptyDataSetSource = self.viewModel;
        LAYOUT_TABLE(_mainView)
        [_mainView registerNib:[UINib nibWithNibName:NSStringFromClass([MyOrderTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyOrderTableViewCell class])];
    }
    return _mainView;
}
- (MyOrderViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[MyOrderViewModel alloc] init];
    }
    return _viewModel;
}
- (instancetype)initWithType:(OrderType)type{
    self = [super init];
    self.mainType = type;
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"我的订单";
    NSArray * titles = @[@"待支付",@"待发货",@"待收货",@"待评价",@"全部订单"];
    self.title = titles[self.mainType];
    [self.view addSubview:self.mainView];
    
    [[self.viewModel getTheData] execute:nil];
    
   
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyOrderTableViewCell class])];
    return cell;
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
