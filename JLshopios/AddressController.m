//
//  AddressController.m
//  JLshopios
//
//  Created by 陈霖 on 16/9/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "AddressController.h"

static const CGFloat kBottomHeight = 60;
#define LINECOLOR [UIColor grayColor]
@interface AddressController ()

/** 底部添加按钮 */
@property (nonatomic , strong) UIButton *addressBtn;
/** 底部白色背景 */
@property (nonatomic , strong) UIView *whiteBackGroundView;

@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self whiteBackGroundView];
    [self createUI];
}

- (UIView *)whiteBackGroundView
{
    if (!_whiteBackGroundView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomHeight - 64, kDeviceWidth, kBottomHeight)];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = kCTTextAlignmentCenter;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (void)createUI
{
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView1.backgroundColor = LINECOLOR;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5, 100, 40)];
    label1.text = @"收货人：";
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 addSubview:lineView1];
    [self.view addSubview:label1];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView2.backgroundColor = LINECOLOR;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5 + 40, 100, 40)];
    label2.text = @"手机号码：";
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 addSubview:lineView2];
    [self.view addSubview:label2];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView3.backgroundColor = LINECOLOR;
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5 + 80, 100, 40)];
    label3.text = @"所在地区：";
    label3.textAlignment = NSTextAlignmentCenter;
    [label3 addSubview:lineView3];
    [self.view addSubview:label3];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView4.backgroundColor = LINECOLOR;
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5 + 120, 100, 40)];
    label4.text = @"详细地址：";
    label4.textAlignment = NSTextAlignmentCenter;
    [label4 addSubview:lineView4];
    [self.view addSubview:label4];
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5 + 160, kDeviceWidth, 1)];
    lineView5.backgroundColor = LINECOLOR;
    [self.view addSubview:lineView5];
    
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
