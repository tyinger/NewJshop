//
//  SaomazhuceViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "SaomazhuceViewController.h"
#import "RegisterViewController.h"

@interface SaomazhuceViewController ()

@end

@implementation SaomazhuceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码注册";
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array{
    
    if (array.count > 0) {
        
        for (LBXScanResult *result in array) {
            
            if (result.strScanned != nil && ![result.strScanned isEqualToString:@""]) {
                
                [FYTXHub success:@"扫码成功" delayClose:.5 compelete:^{
                    
                    RegisterViewController *ctl = [[RegisterViewController alloc] initWithCode:result.strScanned];
                    [self.navigationController pushViewController:ctl animated:YES];
                }];

            }
        }
    }
}

@end
