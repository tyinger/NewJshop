//
//  JLMeViewController.m
//  JLshopios
//
//  Created by imao on 16/6/5.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLMeViewController.h"

#import "ItemModel.h"

@interface JLMeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableView;

@property (nonatomic,strong) NSMutableArray *dataArr;

@end

@implementation JLMeViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _dataArr = @[].mutableCopy;
        [self loadData];
    }
    return self;
}
- (void)loadData{
    
    NSArray *nameArr1 = @[@"我的订单",@"我的关注",@"我的收货地址"];
    NSArray *nameArr2 = @[@"我是商家",@"修改密码"];
    
    NSArray *className1 = @[@"OderViewController",@"LikeViewController",@"AddressViewController"];
    NSArray *className2 = @[@"BusinessViewController",@"ModifyViewController"];
    
    NSMutableArray *arr1 = @[].mutableCopy;
    NSMutableArray *arr2 = @[].mutableCopy;
    for (int i = 0; i<3; i++) {
        
        ItemModel *item = [[ItemModel alloc] init];
        item.titleStr = nameArr1[i];
        item.imageStr = @"";
        item.className = className1[i];
        [arr1 addObject:item];
    }
    
    for (int i = 0; i<2; i++) {
        
        ItemModel *item = [[ItemModel alloc] init];
        item.titleStr = nameArr2[i];
        item.imageStr = @"";
        item.className = className2[i];
        [arr2 addObject:item];
    }
    
    [self.dataArr addObject:arr1];
    [self.dataArr addObject:arr2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    [self creatUI];
}

- (void)creatUI{
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.offset(0);
    }];
}

- (void)logoAction:(UIButton*)btn{
    
    Class class = NSClassFromString(@"LoginViewController");
    if (class) {
        
        UIViewController *ctrl = class.new;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

//init
- (UIView*)creatHeaderView{
    
    UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 100)];
    b.backgroundColor = [UIColor grayColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"欢迎来到用啥";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [titleLabel sizeToFit];
    [b addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(30);
        make.centerX.mas_equalTo(@0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@"登录" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logoAction:) forControlEvents:UIControlEventTouchUpInside];
    [b addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(@0);
    }];
    
    return b;
}
- (UITableView*)mainTableView{
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = [self creatHeaderView];
    }
    return _mainTableView;
}

//delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr = self.dataArr[section];
    return arr.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSArray *arr = self.dataArr[indexPath.section];
    ItemModel *item = arr[indexPath.row];
    
    cell.textLabel.text = item.titleStr;
    cell.imageView.image = [UIImage createImageWithColor:[UIColor redColor]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *arr = self.dataArr[indexPath.section];
    ItemModel *item = arr[indexPath.row];
    
    Class class = NSClassFromString(item.className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = item.titleStr;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
