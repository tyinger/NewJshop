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
    
    
}
- (IBAction)changePasswordTextFAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    self.passwordTextF.secureTextEntry = sender.selected;
}

- (IBAction)loginAction:(id)sender {
    
    //123.56.192.182:8443/app/user/getLoginUser?
    //loginName,password
//    [QSCHttpTool post:@"http://123.56.192.182:8443/app/user/getLoginUser?" parameters:@{@"loginName":@"123456789",@"password":@"12346"} isShowHUD:NO httpToolSuccess:^(id json) {
//        
//        
//    } failure:^(NSError *error) {
//        
//        
//    }];
    
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getLoginUser?loginName=1234556&password=12345" parameters:nil isShowHUD:NO httpToolSuccess:^(id json) {
        
        
    } failure:^(NSError *error) {
        
        
    }];
}

- (IBAction)registerAction:(id)sender {
    
    
}
- (IBAction)foundoutPassword:(id)sender {
    
    
}

@end
