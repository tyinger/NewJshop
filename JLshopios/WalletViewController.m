//
//  WalletViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//
#import "WalletViewModel.h"
#import "WalletHeaderView.h"
#import "WalletViewController.h"

@interface WalletViewController ()
@property (nonatomic, strong) WalletHeaderView * headerView;
@property (nonatomic, strong) WalletViewModel * viewModel;
@property (nonatomic, strong) UILabel * placeHolder;
@end

@implementation WalletViewController
- (WalletHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[WalletHeaderView alloc] init];
    }
    return _headerView;
}
- (UILabel *)placeHolder{
    if (!_placeHolder) {
        _placeHolder = [[UILabel alloc] initWithFrame:CGRectMake(0, self.headerView.height, kDeviceWidth, KDeviceHeight - self.headerView.height)];
        _placeHolder.text = @"对不起，目前无更多信息";
        _placeHolder.backgroundColor = RGB(245, 245, 245);
        _placeHolder.textAlignment = NSTextAlignmentCenter;
    }
    return _placeHolder;
}
- (WalletViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[WalletViewModel alloc] init];
    }
    return _viewModel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的钱包";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialization];
}
- (void)initialization{
    SX_WEAK
    [[self.headerView -> _payButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SX_STRONG
        [self.viewModel payAction];
        
    }];
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.placeHolder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
