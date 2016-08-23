//
//  JLTabMainController.m
//  JLshopios
//
//  Created by imao on 16/6/5.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLTabMainController.h"
#import "JLHomeViewController.h"
#import "JLMeViewController.h"
#import "JLHomeViewController.h"
#import "JLShopsViewController.h"
#import "CategoryViewController.h"
#import "ShopingCartController.h"

@interface JLTabMainController ()

@end

@implementation JLTabMainController

+ (JLTabMainController *)shareJLTabVC{
    static JLTabMainController *jlTabVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        jlTabVC = [[JLTabMainController alloc] init];
    });
    return jlTabVC;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadControllers];
}

- (void)loadControllers{
    JLHomeViewController *vcHome = [JLHomeViewController viewController:ShopSBNameHome];
    QSCNavigationController *bnHome = [[QSCNavigationController alloc]initWithRootViewController:vcHome];
    
    [vcHome setNm_wantsNavigationBarVisible:NO];
    
    CategoryViewController *vcCate = [[CategoryViewController alloc]init];
    QSCNavigationController *bnCate = [[QSCNavigationController alloc]initWithRootViewController:vcCate];
    
    JLShopsViewController *vcShop = [[JLShopsViewController alloc]init];
    QSCNavigationController *bnShop = [[QSCNavigationController alloc]initWithRootViewController:vcShop];
    
    ShopingCartController *cart  = [[ShopingCartController alloc] init];
    QSCNavigationController *shopNav = [[QSCNavigationController alloc] initWithRootViewController:cart];
    
    JLMeViewController *vcMe = [[JLMeViewController alloc]init];
    QSCNavigationController *bnMe = [[QSCNavigationController alloc]initWithRootViewController:vcMe];
    
    [self setViewControllers:@[bnHome,bnCate,bnShop,shopNav,bnMe]animated:YES];

    self.selectedIndex = 0;
    
    [self tabBarItemWithTitle:@"" imageName:@"main_bottom_tab_home_focus"
            selectedImageName:@"main_bottom_tab_home_normal" index:0];
    [self tabBarItemWithTitle:@"" imageName:@"main_bottom_tab_category_focus"
            selectedImageName:@"main_bottom_tab_category_normal" index:1];
    [self tabBarItemWithTitle:@"" imageName:@"main_bottom_tab_faxian_focus"
            selectedImageName:@"main_bottom_tab_faxian_normal" index:2];
    [self tabBarItemWithTitle:@"" imageName:@"main_bottom_tab_cart_focus"
            selectedImageName:@"main_bottom_tab_cart_normal" index:3];
    [self tabBarItemWithTitle:@"" imageName:@"main_bottom_tab_personal_focus"
            selectedImageName:@"main_bottom_tab_personal_normal" index:4];
    
    [self loadBGview:0];
}




-(void) tabBarItemWithTitle:(NSString *)atitle imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName  index:(NSInteger)index
{
    UITabBarItem *tabBarItem = [self.tabBar.items objectAtIndex:index];
    tabBarItem.title = atitle;
    [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                        [UIColor colorWithRed:0x7a/255.0 green:0x49/255.0 blue:0xdf/255.0 alpha:1.0], UITextAttributeTextColor,
                                        nil] forState:UIControlStateSelected];
    tabBarItem.imageInsets=UIEdgeInsetsMake(6, 0,-6, 0);
    
    if ( imageName != nil && selectedImageName != nil  ) {
        UIImage *unselectedImage = [UIImage imageNamed:imageName];
        UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
        [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem setSelectedImage:[selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
}



-(void)loadBGview:(NSInteger)index{
    UIView *sview = [[UIView alloc]init];
    [sview setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.tabBar.frame.size.height)];
    [sview setBackgroundColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]];
    [self.tabBar insertSubview:sview atIndex:index];
    
    
}



@end
