//
//  RegisterViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/7.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "RegisterViewController.h"

#import <JKCountDownButton/JKCountDownButton.h>

@interface RegisterViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet JKCountDownButton *sendCodeButton;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;
@property (weak, nonatomic) IBOutlet UITextField *codeTextF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFT;
@property (weak, nonatomic) IBOutlet UITextField *tuijianCode;

@property (weak, nonatomic) IBOutlet UILabel *tiaoliLabel;

@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@property (nonatomic,strong) NSString *registerYzm;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sureButton.enabled = NO;
    
    self.view.backgroundColor = [UIColor colorWithRed:247/256.0 green:247/256.0 blue:247/256.0 alpha:1];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
    [self.view addGestureRecognizer:ges];
    
    [self.agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.sendCodeButton addTarget:self action:@selector(sendCodeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self youxiaoSureButton];
    
    [self xieyiAction];
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
}

- (void)dealloc{

    
}

#pragma mark - action
- (void)gesAction:(UIGestureRecognizer*)ges{
    [self.view endEditing:YES];
   
    
}
- (void)xieyiAction{
    
    self.tiaoliLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] init];
    [self.tiaoliLabel addGestureRecognizer:ges];
    
    @weakify(self);
    [[ges rac_gestureSignal] subscribeNext:^(id x) {
        
        @strongify(self);
        Class class = NSClassFromString(@"XieYiViewController");
        UIViewController *ctl = class.new;
        ctl.title = @"用户协议";
        [self.navigationController pushViewController:ctl animated:YES];
    }];
}
- (void)agreeButtonAction:(UIButton*)btn{
    
    btn.selected = !btn.selected;
    if (btn.selected) {
        
        if ([self youxiaoshuzi:self.phoneNumTextF.text] && [self youxiaoshuzi:self.codeTextF.text] && [self youxiao:self.passwordTextF.text] && [self youxiao:self.passwordTextFT.text] && [self.passwordTextF.text isEqualToString:self.passwordTextFT.text]) {
            
            self.sureButton.enabled = YES;
            [self.sureButton setBackgroundColor:[UIColor redColor]];
            [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            self.sureButton.enabled = NO;
            [self.sureButton setBackgroundColor:[UIColor colorWithRed:221/256.0 green:221/256.0 blue:221/256.0 alpha:1.0]];
            [self.sureButton setTitleColor:[UIColor colorWithRed:164/256.0 green:164/256.0 blue:164/256.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }else{
        
        self.sureButton.enabled = NO;
        [self.sureButton setBackgroundColor:[UIColor colorWithRed:221/256.0 green:221/256.0 blue:221/256.0 alpha:1.0]];
        [self.sureButton setTitleColor:[UIColor colorWithRed:164/256.0 green:164/256.0 blue:164/256.0 alpha:1.0] forState:UIControlStateNormal];
    }
}
- (void)sendCodeButtonAction:(JKCountDownButton*)btn{
    
    if ([self youxiaodianhua:self.phoneNumTextF.text]) {
        
        NSLog(@"%@",self.phoneNumTextF.text);
        
        //获取验证码的
        NSDictionary *dic = @{@"phoneNum":self.phoneNumTextF.text};
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
- (void)sureButtonAction:(UIButton*)btn{
    
    //注册接口
    //123.56.192.182:8443/app/user/registNewUser?
    
    /**
     *  phoneNum,checkCode
     pwd(MD5大写),recommendCode
     
     手机号 验证码 md5  推荐码
     */
    
    NSString *tuijian;
    if (self.tuijianCode.text == nil || [self.tuijianCode.text isEqualToString:@""]) {
        
        tuijian = @"";
    }else{
        
        tuijian = self.tuijianCode.text;
    }
    NSString *code;
    if (self.codeTextF.text == nil || [self.codeTextF.text isEqualToString:@""]) {
        
        code = @"";
    }else{
        
        code = self.codeTextF.text;
    }
    
    NSDictionary *dic = @{@"phoneNum":self.phoneNumTextF.text,@"checkCode":code,@"pwd":[NSString changemd:self.passwordTextF.text],@"recommendCode":tuijian};
        //loginName=18643212316 password=
        [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/registNewUser?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
            
            if (json[@"msg"] != nil) {
                
                NSString *str = [NSString stringWithFormat:@"%@",json[@"msg"]];
                [FYTXHub toast:str];
                if ([str rangeOfString:@"成功"].location != NSNotFound) {
                    
                    [self loginAction];
                }
            }
            
        } failure:^(NSError *error) {
            
            [FYTXHub toast:@"网络请求失败"];
        }];
}

- (void)loginAction{
    
    NSDictionary *d = @{@"loginName":self.phoneNumTextF.text,@"password":[NSString changemd:self.passwordTextF.text]};
    
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getLoginUser?" parameters:d isShowHUD:NO httpToolSuccess:^(id json) {
        
        [[LoginStatus sharedManager] setJson:json];
        [LoginStatus sharedManager].login = YES;
        [[CartManager sharedManager] getCartGoodCount];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.navigationController popToViewController:[self.navigationController.viewControllers firstObject] animated:YES];
        });
        
    } failure:^(NSError *error) {
        
        [FYTXHub toast:@"登录失败"];
    }];
}



- (void)youxiaoSureButton{
    
    @weakify(self);
    [[[RACSignal combineLatest:@[self.phoneNumTextF.rac_textSignal,self.codeTextF.rac_textSignal,self.passwordTextF.rac_textSignal,self.passwordTextFT.rac_textSignal,self.tuijianCode.rac_textSignal]] deliverOnMainThread] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        if (self.agreeButton.selected) {
            
            if ([self youxiaoshuzi:x.first] && [self youxiaoshuzi:x.second] && [self youxiao:x.third] && [self youxiao:x.fourth] && [x.third isEqualToString:x.fourth]) {
                
                self.sureButton.enabled = YES;
                [self.sureButton setBackgroundColor:[UIColor redColor]];
                [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                
                self.sureButton.enabled = NO;
                [self.sureButton setBackgroundColor:[UIColor colorWithRed:221/256.0 green:221/256.0 blue:221/256.0 alpha:1.0]];
                [self.sureButton setTitleColor:[UIColor colorWithRed:164/256.0 green:164/256.0 blue:164/256.0 alpha:1.0] forState:UIControlStateNormal];
            }
        }else{
            
            self.sureButton.enabled = NO;
            [self.sureButton setBackgroundColor:[UIColor colorWithRed:221/256.0 green:221/256.0 blue:221/256.0 alpha:1.0]];
            [self.sureButton setTitleColor:[UIColor colorWithRed:164/256.0 green:164/256.0 blue:164/256.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }];
    
    
    [[[self.phoneNumTextF rac_textSignal] deliverOnMainThread] subscribeNext:^(NSString *x) {
        
        @strongify(self);
        if (x.length == 11) {
            
            [self.sendCodeButton setBackgroundColor:[UIColor redColor]];
        }else{
            
            [self.sendCodeButton setBackgroundColor:[UIColor colorWithRed:185/256.0 green:185/256.0 blue:185/256.0 alpha:1]];
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
- (BOOL)youxiaoshuzi: (NSString*)str{
    
    NSString* number=@"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:str];
}
- (BOOL)youxiao:(NSString*)str{
    
    if ([str isEqualToString:@""] || str.length == 0) {
        
        return NO;
    }
    return YES;
}










@end
