//
//  MyFollowViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//
static const CGFloat segHeight = 44;
#import "MyFollowViewController.h"
#import "XTSegmentControl.h"
#import "FollowUIModel.h"
#import "FollowGoodTableViewCell.h"
#import "FollowViewModel.h"
@interface MyFollowViewController ()
{
    BOOL isFirst ;
}
@property (nonatomic, strong) XTSegmentControl * segmentControl;
@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) FollowUIModel *service; //UI SERVICE
@property (nonatomic, strong) FollowViewModel *viewModel;
@end

@implementation MyFollowViewController
#pragma mark - lazyLoad
- (FollowUIModel *)service{
    if (!_service) {
        _service = [[FollowUIModel alloc] init];
        _service.viewModel = self.viewModel;
        _service.mainTableView = self.mainTableView;
    }
    return  _service;
}
- (FollowViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [[FollowViewModel alloc] init];
        _viewModel.followViewController = self;
    }
    return _viewModel;
}
- (XTSegmentControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl= [[XTSegmentControl alloc] initWithFrame:CGRectMake(0, 0, 160, segHeight) Items:@[@"商品",@"店铺"] selectedBlock:^(NSInteger index) {
            
            [self.service reloadData:index];
            
        }];
        _segmentControl.centerX = self.view.centerX;
       }
    return _segmentControl;
}
- (UITableView *)mainTableView{
    
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, segHeight, kDeviceWidth, KDeviceHeight-segHeight) style:UITableViewStylePlain];
        _mainTableView.tableFooterView = [[UIView alloc] init];
    }
    return _mainTableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    isFirst = YES;
    //绑定操作
    [self getInitlizaData];
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.mainTableView];
}
- (void)viewWillAppear:(BOOL)animated{
    if (isFirst) {
        return;
    }else{
    [[self.viewModel getData:self.segmentControl.currentIndex andPage:1] subscribeCompleted:^{
        [self.service reloadData:self.segmentControl.currentIndex];
    }];
    }
    isFirst = NO;
  
}
- (void)getInitlizaData{
    RACSignal *signGood =  [self.viewModel getData:0 andPage:1];
    RACSignal *signShop =  [self.viewModel getData:1 andPage:1];
    [[RACSignal combineLatest:@[signGood,signShop]] subscribeCompleted:^{
        [self.service reloadData:0];
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
