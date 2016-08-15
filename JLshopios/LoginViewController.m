//
//  LoginViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/7/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "LoginViewController.h"

#import "QSCHttpTool.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextF;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.navigationController.navigationBarHidden = NO;
    
    self.sureButton.enabled = NO;
    
    @weakify(self);
    [[RACSignal combineLatest:@[[self.userNameTextF rac_textSignal],[self.passwordTextF rac_textSignal]]] subscribeNext:^(RACTuple *x) {
        
        @strongify(self);
        
        NSString *first = x.first;
        NSString *second = x.second;
        if (first.length > 0 && second.length > 0) {
            
            self.sureButton.enabled = YES;
            [self.sureButton setBackgroundColor:[UIColor redColor]];
            [self.sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        }else{
            
            self.sureButton.enabled = NO;
            [self.sureButton setBackgroundColor:[UIColor colorWithRed:230/256.0 green:230/256.0 blue:230/256.0 alpha:1.0]];
            [self.sureButton setTitleColor:[UIColor colorWithRed:100/256.0 green:100/256.0 blue:100/256.0 alpha:1.0] forState:UIControlStateNormal];
        }
    }];
}
- (IBAction)changePasswordTextFAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passwordTextF.secureTextEntry = sender.selected;
}

- (IBAction)loginAction:(id)sender {

    NSDictionary *d = @{@"loginName":self.userNameTextF.text,@"password":[NSString changemd:self.passwordTextF.text]};
    
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getLoginUser?" parameters:d isShowHUD:NO httpToolSuccess:^(id json) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (IBAction)registerAction:(id)sender {
    
    Class class = NSClassFromString(@"RegisterViewController");
    if (class) {
        
        UIViewController *ctl = class.new;
        ctl.title = @"手机快速注册";
        [self.navigationController pushViewController:ctl animated:YES];
    }
}
- (IBAction)foundoutPassword:(id)sender {
    
    
}

@end
