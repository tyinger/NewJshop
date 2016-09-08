//
//  ShangjiaViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShangjiaViewController.h"
#import "AddressController.h"

static const CGFloat kBottomHeight = 60;
@interface ShangjiaViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 列表 */
@property (nonatomic , strong) UITableView *addressTableView;
/** 底部添加按钮 */
@property (nonatomic , strong) UIButton *addressBtn;
/** 底部白色背景 */
@property (nonatomic , strong) UIView *whiteBackGroundView;

@end

@implementation ShangjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self whiteBackGroundView];
    [self addressTableView];
}

- (UIView *)whiteBackGroundView
{
    if (!_whiteBackGroundView) {

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomHeight - 64, kDeviceWidth, kBottomHeight)];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"+ 新增地址" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = kCTTextAlignmentCenter;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(-10);
            make.left.equalTo(view).offset(20);
            make.right.equalTo(view).offset(-20);
            make.top.equalTo(view).offset(10);
        }];
        self.addressBtn = button;
        self.whiteBackGroundView = view;
        
    }
    return _whiteBackGroundView;
}

- (UITableView *)addressTableView
{
    if (!_addressTableView) {

        _addressTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        _addressTableView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_addressTableView];
        [_addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.whiteBackGroundView.mas_top).offset(0);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
        }];
    }
    return _addressTableView;
}


#pragma mark -----tableView Delegate And Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor blueColor];
    return cell;
}

#pragma mark -- button Action
- (void)addAddressAction:(UIButton *)btn
{
    Class class = NSClassFromString(@"AddressController");
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = @"新建收货地址";
        [self.navigationController pushViewController:ctrl animated:YES];
    }
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
