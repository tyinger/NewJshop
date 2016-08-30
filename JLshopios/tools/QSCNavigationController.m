//
//  QSCNavigationController.m
//  qingsongchou
//
//  Created by Chai on 15/8/27.
//  Copyright (c) 2015年 Chai. All rights reserved.
//

#import "QSCNavigationController.h"

@interface QSCNavigationController ()<UINavigationControllerDelegate>
{
    UIImageView *navBarHairlineImageView;
}
@end

@implementation QSCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.delegate = self;
    
    if (iOS7) {
        // 清空手势识别器的代理, 就能恢复以前滑动移除控制器的功能
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    
    navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationBar ];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    navBarHairlineImageView.hidden = NO;
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

#pragma mark 设置导航栏的属性
+ (void)initialize
{
    //1拿到设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    UIBarButtonItem *barButtonItem = [UIBarButtonItem appearance];
    
    //2设置导航栏的背景图片
    if (!iOS7) {
        //1设置navBar的背景图片,设置状态栏的样式
        [navBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
     
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        
        //2设置导航栏上面的barButtonItem的背景图片
        [barButtonItem setBackgroundImage:[UIImage resizedImage:@"nav_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [barButtonItem setBackgroundImage:[UIImage resizedImage:@"nav_back"] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [barButtonItem setBackgroundImage:[UIImage resizedImage:@"nav_back"] forState:UIControlStateDisabled barMetrics:UIBarMetricsDefault];
    }
    
    if (iOS7) {
        [navBar setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
        [navBar setBarTintColor: RGB(248, 248, 248)];
        [navBar setTintColor:RGB(248, 248, 248)];
    }
    
    
    //3设置导航栏标题颜色
    [navBar setTitleTextAttributes:@{
                                     
                                     NSFontAttributeName : [UIFont boldSystemFontOfSize:20],
                                     UITextAttributeTextColor : [UIColor blackColor],
                                     UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
                                     
                                     }];
    
    
    //4.1设置导航栏barButtonItem的文字在普通状态下的属性
    [barButtonItem setTitleTextAttributes:@{
                                            
                                            NSFontAttributeName : [UIFont systemFontOfSize:iOS7? 15 : 13],
                                            UITextAttributeTextColor : [UIColor blackColor],
                                            UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
                                            
                                            } forState:UIControlStateNormal];
    //4.2设置导航栏barButtonItem的文字在高亮状态下的属性
    [barButtonItem setTitleTextAttributes:@{
                                            UITextAttributeTextShadowOffset : [NSValue valueWithUIOffset:UIOffsetZero]
                                            
                                            } forState:UIControlStateHighlighted];
    
    
    if (iOS7) {
        [barButtonItem setTitleTextAttributes:@{
                                               NSForegroundColorAttributeName : RGB(220, 220, 220)

                                                } forState:UIControlStateDisabled];
    }
    
    
}

//判断是否为根控制器展示元素
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏nav条
    if ( viewController == self) {
        [navigationController setNavigationBarHidden:YES animated:animated];
    }
    else if ( [navigationController isNavigationBarHidden] ) {
        [navigationController setNavigationBarHidden:NO animated:animated];
    }
    
    //判断将要显示的是否为根控制器
    if (viewController != navigationController.viewControllers[0] && viewController.navigationItem.leftBarButtonItem == nil) {
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) icon:@"nav_back" highlightedIcon:@"nav_back"];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(back) icon:@"nav_back" highlightedIcon:@"nav_back"];
    }
    [super pushViewController:viewController animated:animated];
}

//返回
- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
