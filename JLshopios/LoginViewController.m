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


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"登录";
    self.navigationController.navigationBarHidden = NO;
}
- (IBAction)changePasswordTextFAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passwordTextF.secureTextEntry = sender.selected;
}

- (IBAction)loginAction:(id)sender {

    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getLoginUser?loginName=1234556&password=12345" parameters:nil isShowHUD:NO httpToolSuccess:^(id json) {
        
        
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
