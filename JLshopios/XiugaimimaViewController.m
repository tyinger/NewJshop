//
//  XiugaimimaViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "XiugaimimaViewController.h"
#import "JKCountDownButton.h"

@interface XiugaimimaViewController ()

@property (nonatomic,strong) UITextField *phoneTextF;
@property (nonatomic,strong) UITextField *codeTextF;

@property (nonatomic,strong) JKCountDownButton *codeButton;

@property (nonatomic,strong) UITextField *passwordText1;
@property (nonatomic,strong) UITextField *passwordText2;

@property (nonatomic,strong) UIButton *actionButton;

@end

@implementation XiugaimimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithRed:242/256.0 green:242/256.0 blue:242/256.0 alpha:1.0];
    
    [self creatUI];
}

- (void)creatUI{
    
    CGFloat padding = 30;
    
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(10);
        make.right.left.offset(0);
        make.height.mas_equalTo(@200);
    }];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    phoneLabel.text = @"手机号:";
    phoneLabel.font = [UIFont systemFontOfSize:15];
    [phoneLabel sizeToFit];
    [backView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(15);
        make.left.offset(10);
        make.width.mas_equalTo(@53);
    }];
    
    self.phoneTextF = [[UITextField alloc] init];
    self.phoneTextF.borderStyle = UITextBorderStyleRoundedRect;
    self.phoneTextF.placeholder = @"手机号";
    [backView addSubview:self.phoneTextF];
    [self.phoneTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(phoneLabel.mas_right).offset(5);
        make.centerY.equalTo(phoneLabel.mas_centerY).offset(0);
        make.right.offset(-10);
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    codeLabel.font = [UIFont systemFontOfSize:15];
    codeLabel.text = @"验证码:";
    [codeLabel sizeToFit];
    [backView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(phoneLabel.mas_bottom).offset(padding);
        make.left.offset(10);
    }];
    
    self.codeTextF = [[UITextField alloc] init];
    self.codeTextF.borderStyle = UITextBorderStyleRoundedRect;
    self.codeTextF.placeholder = @"验证码";
    [backView addSubview:self.codeTextF];
    [self.codeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(codeLabel.mas_centerY).offset(0);
        make.left.equalTo(codeLabel.mas_right).offset(5);
        make.right.offset(-10);
    }];
    
    UILabel *pasword = [[UILabel alloc] init];
    pasword.font = [UIFont systemFontOfSize:15];
    pasword.text = @"密码:";
    [pasword sizeToFit];
    [backView addSubview:pasword];
    [pasword mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(codeLabel.mas_bottom).offset(padding);
        make.left.offset(10);
    }];
    
    self.passwordText1 = [[UITextField alloc] init];
    self.passwordText1.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText1.placeholder = @"6-12位密码";
    [backView addSubview:self.passwordText1];
    [self.passwordText1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(pasword.mas_centerY).offset(0);
        make.left.equalTo(pasword.mas_right).offset(5);
        make.right.offset(-10);
    }];
    
    UILabel *pasword2 = [[UILabel alloc] init];
    pasword2.font = [UIFont systemFontOfSize:15];
    pasword2.text = @"确认密码:";
    [pasword2 sizeToFit];
    [backView addSubview:pasword2];
    [pasword2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(pasword.mas_bottom).offset(padding);
        make.left.offset(10);
    }];
    
    self.passwordText2 = [[UITextField alloc] init];
    self.passwordText2.borderStyle = UITextBorderStyleRoundedRect;
    self.passwordText2.placeholder = @"6-12位密码";
    [backView addSubview:self.passwordText2];
    [self.passwordText2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(pasword2.mas_centerY).offset(0);
        make.left.equalTo(pasword2.mas_right).offset(5);
        make.right.offset(-10);
    }];
    
    self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.actionButton setTitle:@"确定" forState:UIControlStateNormal];
    [self.actionButton addTarget:self action:@selector(sureBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.actionButton setBackgroundColor:[UIColor colorWithRed:225/156.0 green:225/156.0 blue:225/156.0 alpha:1.0]];
    [self.actionButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:self.actionButton];
    [self.actionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(backView.mas_bottom).offset(20);
        make.right.offset(-15);
        make.left.offset(15);
        make.height.mas_equalTo(@30);
    }];
}

- (void)sureBtnAction:(UIButton *)btn{
    
    [[RACSignal combineLatest:@[self.phoneTextF.rac_textSignal,self.codeTextF.rac_textSignal,self.passwordText1.rac_textSignal,self.passwordText2.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        
        
    }];
}

@end
