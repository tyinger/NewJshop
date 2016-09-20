//
//  WodeerweimaController.m
//  JLshopios
//
//  Created by 洪彬 on 16/9/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "WodeerweimaController.h"

@implementation WodeerweimaController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请扫描我的二维码，轻松注册";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.offset(30);
    }];
    
    
    UIImageView *image = [[UIImageView alloc] init];
    image.contentMode = UIViewContentModeScaleAspectFit;
    [image sd_setImageWithURL:[NSURL URLWithString:[LoginStatus sharedManager].recommendCodePic]];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(@300);
        make.centerY.centerX.offset(0);
    }];
}

@end
