//
//  MyFollowViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//
static const 
#import "MyFollowViewController.h"
#import "XTSegmentControl.h"
#import "FollowUIModel.h"
#import "FollowGoodTableViewCell.h"
#import "FollowViewModel.h"
@interface MyFollowViewController ()
@property (nonatomic, strong) XTSegmentControl * segmentControl;
@property (nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) FollowUIModel *service; //UI SERVICE
@property (nonatomic, strong) FollowViewModel *viewModel;
@end

@implementation MyFollowViewController
#pragma mark - lazyLoad
- (XTSegmentControl *)segmentControl{
    if (!_segmentControl) {
        _segmentControl= [[XTSegmentControl alloc] initWithFrame:CGRectMake(0, 0, 160, 44) Items:@[@"商品",@"店铺"] selectedBlock:^(NSInteger index) {
//            [self refreshMySegment];
//            [self.myCarousel scrollToItemAtIndex:index animated:NO];
            
        }];
        _segmentControl.centerX = self.view.centerX;
       }
    return _segmentControl;
}
- (UITableView *)mainTableView{
    if (!_mainTableView) {
     _mainTableView = [UITableView alloc] initWithFrame:CGRectMake(0, 44, <#CGFloat width#>, <#CGFloat height#>) style:<#(UITableViewStyle)#>
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.segmentControl];
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
