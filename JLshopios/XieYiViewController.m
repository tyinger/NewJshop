//
//  XieYiViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "XieYiViewController.h"

@interface XieYiViewController ()

@end

@implementation XieYiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"《用户协议》";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = [UIColor grayColor];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.offset(100);
        make.centerX.offset(0);
    }];
}

@end
