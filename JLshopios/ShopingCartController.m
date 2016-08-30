//
//  ShopingCartController.m
//  JLshopios
//
//  Created by zhouyuxi on 16/6/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShopingCartController.h"
#import "CartUIService.h"
#import "CartViewModel.h"

#import "CartPlaceHolderView.h"
#import "CartBarEdit.h"
@interface ShopingCartController ()
@property (nonatomic, strong) CartUIService *service; //UI SERVICE
@property (nonatomic, strong) CartViewModel *viewModel;
@property (nonatomic, strong) UITableView     *cartTableView;

@property (nonatomic, strong) CartBarEdit   *cartEditBar;//编辑状态的bar
@property (nonatomic, strong) CartPlaceHolderView   *cartPlaceholder;

@end

@implementation ShopingCartController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.viewModel selectAll:NO];
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if ([[LoginStatus sharedManager] login]) {
        [self.viewModel getDataSuccess:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.cartTableView reloadData];
            });
            //
        }];
    }
//    [self.viewModel getDataSuccess:^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.cartTableView reloadData];
//        });
//        //
//    }];
   
    //假装X秒以后 出现数据
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)),dispatch_get_global_queue(0, 0), ^{
////        [CartManager sharedManager].cartGoodNum = @10;
//        [self.viewModel getLocalDataSuccess:^{
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.cartTableView reloadData];
//            });
//        }];
//        
//    });
}
- (void)edit:(UIButton*)btn{
     btn.selected = !btn.selected;
    self.cartEditBar.hidden = !btn.selected;
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor orangeColor];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"购物车";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cartTableView];
    [self.view addSubview:self.cartBar];
    [self.view addSubview:self.cartEditBar];
    [self.view addSubview:self.cartPlaceholder];
    
    UIButton * edit = [UIButton createButtonWithFrame:CGRectMake(0, 0, 60, 40) Title:@"编辑" Target:self Selector:@selector(edit:)];
//    edit.hidden = ![LoginStatus sharedManager].login;
   
    edit.titleLabel.font = SXFont(15);
    [edit setTitleColor:[UIColor blackColor] forState:0|UIControlStateSelected];
    [edit setTitle:@"编辑" forState:0];
    [edit setTitle:@"完成" forState:UIControlStateSelected];
    UIBarButtonItem * right = [[UIBarButtonItem alloc] initWithCustomView:edit];
    [RACObserve([LoginStatus sharedManager], login) subscribeNext:^(id x) {
       
        if ([x boolValue]) {
            self.navigationItem.rightBarButtonItem = right;
        }else
        {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }];
    [RACObserve([CartManager sharedManager], cartGoodNum) subscribeNext:^(NSNumber* x) {
        if (x&&![x isEqualToNumber:@(0)]) {
        //有数量 按钮显示
            self.navigationItem.rightBarButtonItem = right;
        }else{
            self.navigationItem.rightBarButtonItem = nil;
        }
        
    }];
  //所有操作
    //全选
    [[self.cartBar.selectAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        x.selected = !x.selected;
        [self.viewModel selectAll:x.selected];
    }];
    //结算
    [[self.cartBar.balanceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        [self.viewModel payAction];
    }];
    //edit状态的全选
    [[self.cartEditBar -> _selectAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton* x) {
        x.selected = !x.selected;
        [self.viewModel selectAll:x.selected];
    }];
    //FOLLOW
    [[self.cartEditBar ->_followButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel followAction];
    }];
    //DELETE
    [[self.cartEditBar ->_deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self.viewModel deleteAction];
    }];
    //点击登录
    [self.cartPlaceholder ->_loginSignal subscribeNext:^(id x) {
        //TODO 去登录
        [self.viewModel loginAction];
    }];
    //点击秒杀
    [self.cartPlaceholder ->_quickSignal subscribeNext:^(id x) {
        self.tabBarController.selectedIndex = 1;
    }];

    /* 观察价格属性 */
    SX_WEAK
    [RACObserve(self.viewModel, allPrices) subscribeNext:^(NSNumber *x) {
        SX_STRONG
        self.cartBar.money = x.floatValue;
    }];
    [RACObserve(self.viewModel, selectedCount) subscribeNext:^(NSNumber *x) {
        SX_STRONG
        self.cartBar.seletedCount = x.floatValue;
    }];
    /* 全选 状态 */
    RAC(self.cartBar.selectAllButton,selected) = RACObserve(self.viewModel, isSelectAll);
}
#pragma mark - Lazy Load

- (CartViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[CartViewModel alloc] init];
        _viewModel.cartVC = self;
        _viewModel.cartTableView  = self.cartTableView;
        _viewModel.cartPlaceholderView = self.cartPlaceholder;
    }
    return _viewModel;
}


- (CartUIService *)service{
    
    if (!_service) {
        _service = [[CartUIService alloc] init];
        _service.viewModel = self.viewModel;
    }
    return _service;
}


- (UITableView *)cartTableView{
    
    if (!_cartTableView) {
        NSLog(@"  boom   %f",self.tabBarController.tabBar.height) ;
        _cartTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, KDeviceHeight-99)
                                                      style:UITableViewStylePlain];
        
        [_cartTableView registerNib:[UINib nibWithNibName:@"CartCell" bundle:nil]
             forCellReuseIdentifier:@"CartCell"];
       _cartTableView.dataSource = self.service;
        _cartTableView.delegate   = self.service;
        _cartTableView.backgroundColor = RGBA(240, 240, 240, 1);
//        _cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 50)];
        LAYOUT_TABLE(_cartTableView);
        _cartTableView.tableFooterView = [[UIView alloc] init];
    }
    return _cartTableView;
}

- (CartBar *)cartBar{
    
    if (!_cartBar) {
        _cartBar = [[CartBar alloc] initWithFrame:CGRectMake(0, KDeviceHeight-50- 49-64, kDeviceWidth, 50)];
    }
    return _cartBar;
}
- (CartBarEdit *)cartEditBar{
    if (!_cartEditBar) {
        _cartEditBar = [[CartBarEdit alloc] initWithFrame:CGRectMake(0, KDeviceHeight-50- 49-64, kDeviceWidth, 50)];
        _cartEditBar.hidden = YES;
    }
    return _cartEditBar;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CartPlaceHolderView *)cartPlaceholder{
    if (!_cartPlaceholder) {
        _cartPlaceholder = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CartPlaceHolderView class]) owner:nil options:nil].firstObject;
        _cartPlaceholder.frame = CGRectMake(0, 0, kDeviceWidth, KDeviceHeight);
        
    }
    return _cartPlaceholder;
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
