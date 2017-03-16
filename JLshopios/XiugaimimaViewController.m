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

@property (nonatomic,strong) NSString *registerYzm;

@end

@implementation XiugaimimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.title = @"修改密码";
    self.view.backgroundColor = [UIColor colorWithRed:242/256.0 green:242/256.0 blue:242/256.0 alpha:1.0];
    
    [self creatUI];
    
    @weakify(self);
    [[self.phoneTextF.rac_textSignal deliverOnMainThread] subscribeNext:^(NSString *x) {
        
        @strongify(self);
        if (x.length > 10) {
            
            self.codeButton.enabled = YES;
            [self.codeButton setBackgroundColor:[UIColor redColor]];
        }else{
            
            self.codeButton.enabled = NO;
            [self.codeButton setBackgroundColor:[UIColor colorWithRed:185/256.0 green:185/256.0 blue:185/256.0 alpha:1]];
        }
    }];
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
        
        make.width.mas_equalTo(@53);
        make.top.equalTo(phoneLabel.mas_bottom).offset(padding);
        make.left.offset(10);
    }];
    
    self.codeButton = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.codeButton setFont:[UIFont systemFontOfSize:14]];
    [self.codeButton setBackgroundColor:[UIColor colorWithRed:185/256.0 green:185/256.0 blue:185/256.0 alpha:1]];
    self.codeButton.layer.cornerRadius = 5;
    [self.codeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.codeButton addTarget:self action:@selector(sendCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.codeButton];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.offset(-10);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@29);
        make.centerY.equalTo(codeLabel.mas_centerY).offset(0);
    }];
    
    self.codeTextF = [[UITextField alloc] init];
    self.codeTextF.borderStyle = UITextBorderStyleRoundedRect;
    self.codeTextF.placeholder = @"验证码";
    [backView addSubview:self.codeTextF];
    [self.codeTextF mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(codeLabel.mas_centerY).offset(0);
        make.left.equalTo(codeLabel.mas_right).offset(5);
        make.right.equalTo(self.codeButton.mas_left).offset(-5);
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
    self.actionButton.layer.cornerRadius = 5;
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

- (void)sendCodeAction:(JKCountDownButton *)btn{
    
    if ([self youxiaodianhua:self.phoneTextF.text]) {
        
        NSLog(@"%@",self.phoneTextF.text);
        
        //获取验证码的
        NSDictionary *dic = @{@"phoneNum":self.phoneTextF.text};
        [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getRegisterYzm?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
            NSLog(@"json = msg %@",json[@"msg"]);
            
            if (![json[@"msg"] isEqualToString:@""] && json[@"msg"] != nil) {
                
                [FYTXHub toast:json[@"msg"]];
            }else{
                
                btn.enabled = NO;
                [btn startCountDownWithSecond:60];
                
                [btn countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    
                    NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                    return title;
                }];
                [btn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                    
                    countDownButton.enabled = YES;
                    return @"重新获取";
                }];
                
                self.registerYzm = json[@"registerYzm"];
            }
        } failure:^(NSError *error) {
            
            [FYTXHub toast:@"获取验证码失败"];
        }];
        
    }else{
        
        [FYTXHub toast:@"请输入正确的手机号码"];
    }
}

- (void)sureBtnAction:(UIButton *)btn{
    
    @weakify(self);
    [[RACSignal combineLatest:@[self.phoneTextF.rac_textSignal,self.codeTextF.rac_textSignal,self.passwordText1.rac_textSignal,self.passwordText2.rac_textSignal]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        NSString *s1 = x.first;
        NSString *s2 = x.second;
        NSString *s3 = x.third;
        NSString *s4 = x.fourth;
        
        if (s1.length < 10) {
            
            [FYTXHub toast:@"请输入正确的手机号"];
        }else{
            
            if (s2.length <= 0) {
                
                [FYTXHub toast:@"请输入正确的验证码"];
            }else{
                
                if (s3.length <6 || s3.length > 12) {
                    
                    [FYTXHub toast:@"请输入正确格式的密码"];
                }else{
                    
                    if (s3 != s4) {
                        
                        [FYTXHub toast:@"请确保两次输入的密码一致"];
                    }else{
                        
                        
                    }
                }
            }
        }
    }];
}














- (BOOL)youxiaodianhua:(NSString*)str{
    
    if (str.length == 11) {
        
        NSString* number=@"^[0-9]+$";
        NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
        return [numberPre evaluateWithObject:str];
    }
    return NO;
}

@end
