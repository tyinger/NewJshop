//
//  ScoreViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ScoreViewController.h"
#import "ScoreHeaderView.h"
#import "ScoreViewModel.h"
#import "ScoreUIService.h"
@interface ScoreViewController ()
@property (nonatomic, strong) ScoreHeaderView * headerView;
@property (nonatomic, strong) ScoreViewModel * viewModel;
@property (nonatomic, strong) ScoreUIService * service;
@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) UILabel * placeHolder;

@end

@implementation ScoreViewController
- (ScoreUIService *)service{
    if (!_service) {
        _service = [[ScoreUIService alloc] init];
        _service.mainTableView = self.mainTableView;
    }
    return _service;
}
- (ScoreHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ScoreHeaderView alloc] init];
        [RACObserve(self.viewModel, canUseScore) subscribeNext:^(id x) {
            _headerView.canUseScore = x;
        }];
        [RACObserve(self.viewModel, totalScore) subscribeNext:^(id x) {
            _headerView.totalScore = x;
        }];
        [RACObserve(self.viewModel, userusedScore) subscribeNext:^(id x) {
            _headerView.userusedScore = x;
        }];
    }
    return _headerView;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.height, kDeviceWidth, KDeviceHeight-self.headerView.height) style:UITableViewStylePlain];
        _mainTableView.tableFooterView = [[UIView alloc] init];
    }
    return _mainTableView;
}
- (ScoreViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[ScoreViewModel alloc] init];
    }
    return _viewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的积分";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initialization];
}
- (void)viewWillAppear:(BOOL)animated{
    [[self.viewModel getTheScore]subscribeCompleted:^{
        
    } ];
    [[self.viewModel getTheScoreDetail] subscribeCompleted:^{
        
    }];

}
- (void)initialization{
    self.service.viewModel = self.viewModel;
    [self.view addSubview:self.headerView];
      [self.view addSubview:self.mainTableView];
//    [self.view addSubview:self.placeHolder];
//    SX_WEAK
  //        SX_STRONG
//        self.headerView.userusedScore = [NSString stringWithFormat:@"%@",data[@"userusedScore"]];
//         self.headerView.totalScore = [NSString stringWithFormat:@"%@",data[@"score"]];
//        NSInteger canuse = [data[@"score"] integerValue]- [data[@"userusedScore"] integerValue];
//         self.headerView.canUseScore = [NSString stringWithFormat:@"%ld",(long)canuse];
        
//    }];
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
