//
//  GerenziliaoxiugaiController.m
//  JLshopios
//
//  Created by 洪彬 on 16/9/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "GerenziliaoxiugaiController.h"

@interface GerenziliaoxiugaiController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *mainTableview;
@property (nonatomic,copy) NSArray *arr;


@property (nonatomic,strong) UIImageView *Nimage;
@property (nonatomic,strong) UITextField *textF;
//@property (nonatomic,strong) U

@end

@implementation GerenziliaoxiugaiController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.arr = @[@"头像",@"昵称",@"性别",@"生日"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableview];
    [self.mainTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.offset(0);
    }];
    
    UIView *b = [[UIView alloc] init];
    b.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:b];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.left.offset(0);
        make.height.mas_equalTo(@70);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [b addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] init];
    [self.view addGestureRecognizer:ges];
    @weakify(self);
    [[ges rac_gestureSignal] subscribeNext:^(id x) {
        
        @strongify(self);
        [self.view endEditing:YES];
    }];
}

- (UITableView *)mainTableview{
    
    if (!_mainTableview) {
        
        _mainTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableview.delegate = self;
        _mainTableview.dataSource = self;
        _mainTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _mainTableview;
}

- (void)btnAction:(UIButton*)b{
    
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 80;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        UIImageView *image = [[UIImageView alloc] init];
        image.contentMode = UIViewContentModeScaleAspectFit;
        image.layer.masksToBounds = YES;
        [image sd_setImageWithURL:[NSURL URLWithString:[LoginStatus sharedManager].headPic]];
        [cell addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-35);
            make.width.height.mas_equalTo(@70);
            make.centerY.offset(0);
        }];
    }
    if (indexPath.row == 1) {
        
        UITextField *textF = [[UITextField alloc] init];
        textF.borderStyle = UITextBorderStyleNone;
        textF.text = [LoginStatus sharedManager].name;
        textF.placeholder = @"请输入喜欢的用户名";
        [cell addSubview:textF];
        textF.backgroundColor = [UIColor redColor];
        [textF mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.offset(0);
            make.left.offset(60);
        }];
    }
    
    return cell;
}

@end
