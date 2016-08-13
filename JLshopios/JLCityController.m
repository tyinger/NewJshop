//
//  JLCityController.m
//  JLshopios
//
//  Created by daxiongdi on 16/8/5.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLCityController.h"
#import "BAddressPickerController.h"

@interface JLCityController ()<BAddressPickerDelegate,BAddressPickerDataSource>

@end


@implementation JLCityController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //适配ios7
    self.title = @"切换城市";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    
    BAddressPickerController *addressPickerController = [[BAddressPickerController alloc] initWithFrame:self.view.frame];
    addressPickerController.dataSource = self;
    addressPickerController.delegate = self;
    
    [self addChildViewController:addressPickerController];
    [self.view addSubview:addressPickerController.view];
}

-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


#pragma mark - BAddressController Delegate
- (NSArray*)arrayOfHotCitiesInAddressPicker:(BAddressPickerController *)addressPicker{
    return @[@"北京",@"上海",@"深圳",@"杭州",@"广州",@"武汉",@"天津",@"重庆",@"成都",@"苏州"];
}

- (void)addressPicker:(BAddressPickerController *)addressPicker didSelectedCity:(NSString *)city{
    if ([self.delegate respondsToSelector:@selector(chooseCity:)]) {
        [self.delegate chooseCity:city];
        
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)beginSearch:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)endSearch:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


@end
