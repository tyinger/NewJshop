//
//  JLMeViewController.m
//  JLshopios
//
//  Created by imao on 16/6/5.
//  Copyright © 2016年 feng. All rights reserved.
//
#import "ScoreViewController.h"

#import "JLMeViewController.h"

#import "ItemModel.h"

#import "LoginViewController.h"

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
    
    NSArray *nameArr1 = @[@"我的钱包",@"我的积分"];
    NSArray *nameArr2 = @[@"我的关注",@"我的收货地址",@"我是商家"];
    NSArray *nameArr3 = @[@"扫码注册",@"修改密码"];
    
    NSArray *imageName1 = @[@"piaobao",@"wodejifen"];
    NSArray *imageName2 = @[@"guanzhu",@"shouhuodizhi",@"woshishangjia"];
    NSArray *imageName3 = @[@"saomazhuce",@"xiugaimima"];
    
    
    
    NSArray *className1 = @[@"WalletViewController",@"ScoreViewController"];
    NSArray *className2 = @[@"GuanzhuViewController",@"ShouhoudizhiViewController",@"ShangjiaViewController"];
    NSArray *className3 = @[@"SaomazhuceViewController",@"XiugaimimaViewController"];
    
    NSMutableArray *arr1 = @[].mutableCopy;
    NSMutableArray *arr2 = @[].mutableCopy;
    NSMutableArray *arr3 = @[].mutableCopy;
    
    for (int i = 0; i<2; i++) {
        
        ItemModel *item = [[ItemModel alloc] init];
        item.titleStr = nameArr1[i];
        item.imageStr = imageName1[i];
        item.className = className1[i];
        [arr1 addObject:item];
    }
    
    for (int i = 0; i<3; i++) {
        
        ItemModel *item = [[ItemModel alloc] init];
        item.titleStr = nameArr2[i];
        item.imageStr = imageName2[i];
        item.className = className2[i];
        [arr2 addObject:item];
    }
    
    for (int i = 0; i<2; i++) {
        
        ItemModel *item = [[ItemModel alloc] init];
        item.titleStr = nameArr3[i];
        item.imageStr = imageName3[i];
        item.className = className3[i];
        [arr3 addObject:item];
    }
    
    [self.dataArr addObject:arr1];
    [self.dataArr addObject:arr2];
    [self.dataArr addObject:arr3];
}














- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    [self creatUI];
    
    [[RACObserve([LoginStatus sharedManager], login) deliverOnMainThread] subscribeNext:^(NSNumber *x) {
        
        if ([x boolValue] == YES) {
            
            self.mainTableView.tableFooterView = [self creatFootView];
        }else{
            
            self.mainTableView.tableFooterView = nil;
        }
    }];
    [[RACObserve([LoginStatus sharedManager], login) deliverOnMainThread] subscribeNext:^(id x) {
        
        if ([x boolValue] == NO) {
            
            self.mainTableView.tableHeaderView = [self creatHeaderView];
        }else{
            
            self.mainTableView.tableHeaderView = [self creatHeaderLoginView];
        }
    }];
}

- (void)creatUI{
    
    [self.view addSubview:self.mainTableView];
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.offset(0);
    }];
}
- (UIView *)creatFootView{
    
    UIView *mainView =[[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80)];
    
    UIButton *tuichuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tuichuButton setBackgroundColor:[UIColor redColor]];
    [tuichuButton setTitle:@"退出当前账号" forState:UIControlStateNormal];
    tuichuButton.layer.cornerRadius = 5;
    [[[tuichuButton rac_signalForControlEvents:UIControlEventTouchUpInside] deliverOnMainThread] subscribeNext:^(id x) {
        
        [FYTXHub success:@"退出成功" delayClose:1 compelete:^{
            
           dispatch_async(dispatch_get_main_queue(), ^{
               
               [[LoginStatus sharedManager] end];
               [LoginStatus sharedManager].login = NO;
           });
        }];
    }];
    [mainView addSubview:tuichuButton];
    [tuichuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.centerY.offset(0);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@180);
    }];
    
    return mainView;
}
- (UIView *)creatHeaderLoginView{
    
    UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180)];
    b.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/ 5 - 20;
    
    UIImageView *topImage = [[UIImageView alloc] init];
    topImage.image = [UIImage imageNamed:@"personel_user_head_bg.jpg"];
    topImage.userInteractionEnabled = YES;
    topImage.backgroundColor = [UIColor grayColor];
    [b addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.offset(0);
        make.bottom.offset(-width);
    }];
    
    UIImageView *userImage = [[UIImageView alloc] init];
    [userImage sd_setImageWithURL:[NSURL URLWithString:[LoginStatus sharedManager].headPic]];
    userImage.layer.masksToBounds = YES;
    userImage.layer.borderWidth = 2;
    userImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [b addSubview:userImage];
    [userImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.mas_equalTo(@20);
        make.width.height.offset(180 - width - 36);;
    }];
    
    UILabel *name = [[UILabel alloc] init];
    name.textColor = [UIColor whiteColor];
    name.font = [UIFont systemFontOfSize:16];
    name.text = [LoginStatus sharedManager].name;
    [name sizeToFit];
    [b addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(userImage.mas_top).offset(0);
        make.left.equalTo(userImage.mas_right).offset(15);
    }];
    
    UILabel *phone = [[UILabel alloc] init];
    phone.textColor = [UIColor whiteColor];
    phone.font = [UIFont systemFontOfSize:16];
    phone.text = [LoginStatus sharedManager].loginName;
    [phone sizeToFit];
    [b addSubview:phone];
    [phone mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(userImage.mas_right).offset(15);
        make.centerY.equalTo(userImage.mas_centerY).offset(0);
    }];
    
    UILabel *code = [[UILabel alloc] init];
    code.textColor = [UIColor whiteColor];
    code.font = [UIFont systemFontOfSize:16];
    code.text = [LoginStatus sharedManager].recommendCode;
    [code sizeToFit];
    [b addSubview:code];
    [code mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(userImage.mas_right).offset(15);
        make.bottom.equalTo(userImage.mas_bottom).offset(0);
    }];
    
    UIImageView *codeImage = [[UIImageView alloc] init];
    codeImage.layer.masksToBounds = YES;
    codeImage.contentMode = UIViewContentModeScaleAspectFill;
    [codeImage sd_setImageWithURL:[NSURL URLWithString:[LoginStatus sharedManager].recommendCodePic]];
    [b addSubview:codeImage];
    [codeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(userImage.mas_centerY).offset(0);
        make.width.height.mas_equalTo(@35);
        make.right.offset(-20);
    }];
    
    NSArray *imageNarr = @[@"daifukuan",@"daishou",@"pingjia",@"",@"quanbudingdan"];
    NSArray *iconName = @[@"代付款",@"待收货",@"待评价",@"返修/退换",@"全部订单"];
    
    UIView *lastView;
    for (int i = 0; i<5; i++) {
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        [b addSubview:backView];
        
        backView.tag = 1000 + i;
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(width);
            make.bottom.offset(0);
            
            if (lastView) {
                
                make.left.equalTo(lastView.mas_right).offset(20);
            }else{
                
                make.left.offset(0);
            }
        }];
        
        lastView = backView;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNarr[i]]];
        [backView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(5);
            make.width.height.mas_equalTo(@32);
            make.centerX.offset(0);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = iconName[i];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor blackColor];
        [backView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.offset(0);
            make.centerX.offset(0);
        }];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
        [backView addGestureRecognizer:ges];
    }
    
    return b;
}

- (void)logoAction:(UIButton*)btn{
    
    Class class = NSClassFromString(@"LoginViewController");
    
    if (class) {
        
        UIViewController *ctrl = class.new;
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}
- (void)gesAction: (UIGestureRecognizer *)ges{
    
    
}

//init
- (UIView*)creatHeaderView{
    
    UIView *b = [[UIView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, 180)];
    b.backgroundColor = [UIColor whiteColor];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width/ 5 - 20;
    
    UIImageView *topImage = [[UIImageView alloc] init];
    topImage.image = [UIImage imageNamed:@"my_personal_not_login_bg.jpg"];
    topImage.userInteractionEnabled = YES;
    topImage.backgroundColor = [UIColor grayColor];
    [b addSubview:topImage];
    [topImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.left.right.offset(0);
        make.bottom.offset(-width);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"欢迎来到用啥";
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    [titleLabel sizeToFit];
    [topImage addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(30);
        make.centerX.mas_equalTo(@0);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.backgroundColor = [UIColor whiteColor];
    [button setTitle:@" 登录/注册 " forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    [button setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(logoAction:) forControlEvents:UIControlEventTouchUpInside];
    [topImage addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(titleLabel.mas_bottom).offset(10);
        make.centerX.mas_equalTo(@0);
    }];
    
    NSArray *imageNarr = @[@"daifukuan",@"daishou",@"pingjia",@"",@"quanbudingdan"];
    NSArray *iconName = @[@"代付款",@"待收货",@"待评价",@"返修/退换",@"全部订单"];
    
    UIView *lastView;
    for (int i = 0; i<5; i++) {
        
        UIView *backView = [[UIView alloc] init];
        backView.backgroundColor = [UIColor whiteColor];
        [b addSubview:backView];
        
        backView.tag = 1000 + i;
        
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.width.height.mas_equalTo(width);
            make.bottom.offset(0);
            
            if (lastView) {
                
                make.left.equalTo(lastView.mas_right).offset(20);
            }else{
                
                make.left.offset(0);
            }
        }];
        
        lastView = backView;
        
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageNarr[i]]];
        [backView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.offset(5);
            make.width.height.mas_equalTo(@32);
            make.centerX.offset(0);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = iconName[i];
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor blackColor];
        [backView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.offset(0);
            make.centerX.offset(0);
        }];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
        [backView addGestureRecognizer:ges];
    }
    
    return b;
}
- (UITableView*)mainTableView{
    
    if (!_mainTableView) {
        
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = [self creatHeaderView];
        
        _mainTableView.sectionHeaderHeight = 5;
        _mainTableView.sectionFooterHeight = 0;
    }
    return _mainTableView;
}

//delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;
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
    cell.imageView.image = [UIImage imageNamed:item.imageStr];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([LoginStatus sharedManager].login == NO) {
        
        [FYTXHub toast:@"请先登录"];
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            @strongify(self);
            [self.navigationController pushViewController:[LoginViewController new] animated:YES];
        });
    }else{
        
        NSArray *arr = self.dataArr[indexPath.section];
        ItemModel *item = arr[indexPath.row];
        
        Class class = NSClassFromString(item.className);
        if (class) {
            UIViewController *ctrl = class.new;
            ctrl.title = item.titleStr;
            [self.navigationController pushViewController:ctrl animated:YES];
        }
    }
    [self.mainTableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

@end
