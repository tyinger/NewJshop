//
//  OtherListViewController.m
//  JLshopios
//
//  Created by 陈霖 on 16/8/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "OtherListViewController.h"

@interface OtherListViewController ()

@end

@implementation OtherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor redColor];
    self.navigationItem.title = @"更多";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
