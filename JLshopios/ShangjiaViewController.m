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
/** footVIew */
@property (nonatomic , strong) UIView *myFootView;

@end

@implementation ShangjiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self whiteBackGroundView];
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
        
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.height - 64) style:UITableViewStylePlain];
        
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        _addressTableView.bounces = NO;
        _addressTableView.tableFooterView = self.myFootView;
        [self.view addSubview:_addressTableView];
//        [_addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view).offset(0);
//            make.bottom.equalTo(self.whiteBackGroundView.mas_top).offset(0);
//            make.left.equalTo(self.view.mas_left).offset(0);
//            make.right.equalTo(self.view.mas_right).offset(0);
//        }];
    }
    return _addressTableView;
}

-(UIView *)myFootView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
//    view.backgroundColor = [UIColor yellowColor];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(0, 0, 40, 40);
    [agreeBtn setImage:[UIImage imageNamed:@"xn_circle_normal"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"xn_circle_select"] forState:UIControlStateSelected];
    [agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kDeviceWidth, 40)];
    label.text = @"同意用啥商家注册协议";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [label setAttributedText:str];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PushToAgreeDelegate:)];
    [label addGestureRecognizer:tapGes];
    
    //底部分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kDeviceWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(10, 45, kDeviceWidth - 20, 30);
    commitButton.tag = 101;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    commitButton.layer.masksToBounds = YES;
    commitButton.layer.cornerRadius = 5;
    commitButton.backgroundColor = [UIColor lightGrayColor];
    
    //添加到footView
    [view addSubview:label];
    [view addSubview:agreeBtn];
    [view addSubview:lineView];
    [view addSubview:commitButton];
    return view;
}

#pragma mark -----tableView Delegate And Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    switch (indexPath.row) {
        case 0:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  为必填项";
            label.textColor = [UIColor redColor];
            [cell addSubview:label];
        }
            break;
        case 1:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  商户名称";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 201;
            
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 2:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  经营范围";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            [cell addSubview:label];
        }
            break;
        case 3:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  所在城市";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            [cell addSubview:label];
        }
            break;
        case 4:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  详细地址";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 202;
            
            [cell addSubview:filed];
            
            [cell addSubview:label];
        }
            break;
        case 5:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  联系人";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 203;
            
            [cell addSubview:filed];
            
            [cell addSubview:label];
        }
            break;
        case 6:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  联系电话";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 204;
            
            [cell addSubview:filed];
            
            [cell addSubview:label];
        }
            break;
        case 7:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  营业执照";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 205;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
            [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 8:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
            label.text = @"*  身份证正面照片";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 206;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
            [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 9:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
            label.text = @"*  身份证反面照片";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 207;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
            [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 10:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
            label.text = @"   我在其他平台商铺";
//
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.tag = 208;
            
            UILabel *placeLabel = [[UILabel alloc] initWithFrame:filed.frame];
            placeLabel.x = 0;
            placeLabel.y = -1;
            placeLabel.text = @" 填写店铺连接";
            placeLabel.textColor = [UIColor lightGrayColor];
            [filed addSubview:placeLabel];
            
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        
            
        default:
            break;
    }
    
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

- (void)agreeAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)PushToAgreeDelegate:(UITapGestureRecognizer *)tap{
    MYLog(@"我就是不跳这么滴");
}

- (void)photoAction:(UIButton *)btn{
    
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
