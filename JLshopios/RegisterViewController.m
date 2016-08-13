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


#pragma mark - action
- (void)gesAction:(UIGestureRecognizer*)ges{
    
    [self.view endEditing:YES];
}
- (void)xieyiAction{
    
    self.tiaoliLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] init];
    [self.tiaoliLabel addGestureRecognizer:ges];
    [[ges rac_gestureSignal] subscribeNext:^(id x) {
        
        
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
        
        btn.enabled = NO;
        [btn startCountDownWithSecond:60];
        
        [btn countDownChanging:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            
            NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
            return title;
        }];
        [btn countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
            
            countDownButton.enabled = YES;
            return @"点击重新获取";
        }];
    }else{
        
        [FYTXHub toast:@"请输入正确的手机号码"];
    }
}
- (void)sureButtonAction:(UIButton*)btn{
    
    
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
