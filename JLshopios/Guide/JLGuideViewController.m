//
//  JLGuideViewController.m
//  JLshopios
//
//  Created by daxiongdi on 16/6/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLGuideViewController.h"
#import "FYTXGuideFactory.h"
@interface JLGuideViewController ()

@property (nonatomic,strong) id<FYTXGEViewProtocol> gview;

@end

@implementation JLGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gview = [FYTXGuideFactory guideView];
    UIView *sview = (UIView *)self.gview;
    [sview setFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:sview];
    
    
    
    // Do any additional setup after loading the view.
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
