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
@interface ScoreViewController ()
@property (nonatomic, strong) ScoreHeaderView * headerView;
@property (nonatomic, strong) ScoreViewModel * viewModel;
@property (nonatomic, strong) UILabel * placeHolder;
@end

@implementation ScoreViewController
- (ScoreHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[ScoreHeaderView alloc] init];
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
- (void)initialization{

    [self.view addSubview:self.headerView];
    [self.view addSubview:self.placeHolder];
    SX_WEAK
    [self.viewModel getTheScoreSuccess:^(id data) {
        SX_STRONG
        self.headerView.userusedScore = [NSString stringWithFormat:@"%@",data[@"userusedScore"]];
         self.headerView.totalScore = [NSString stringWithFormat:@"%@",data[@"score"]];
        NSInteger canuse = [data[@"score"] integerValue]- [data[@"userusedScore"] integerValue];
         self.headerView.canUseScore = [NSString stringWithFormat:@"%ld",(long)canuse];
        
    }];
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
