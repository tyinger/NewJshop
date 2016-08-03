//
//  UIBarButtonItem+Addition.m
//  MaiQuan
//
//  Created by 王圆的Mac on 14-1-23.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//

#import "UIBarButtonItem+Addition.h"
#import "UIButton+Bg.h"

@implementation UIBarButtonItem (Addition)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon
{
   //1创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //2设置图片
    UIImage *bg = [UIImage imageNamed:icon];
    UIImage *highlightedBg = [UIImage imageNamed:highlightedIcon];
    
    //3设置按钮的背景图片
    [btn setBackgroundImage:bg forState:UIControlStateNormal];
    [btn setBackgroundImage:highlightedBg  forState:UIControlStateHighlighted];
   
    //4点击监听事件
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    //5设置按钮的frame
    btn.frame = (CGRect){CGPointZero,{18,18}};

    //6设置 UIBarButtonItem 的自定义为btn
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
    
    return barButtonItem;
}

+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置所有状态下的背景图片
    CGSize btnSize = [btn setAllStateBg:icon];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    btn.bounds = (CGRect){CGPointZero, {32,32}};
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

+ (UIBarButtonItem *)barButtonItemWithBg:(NSString *)bg title:(NSString *)title size:(CGSize)size target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 按钮文字
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    // 按钮背景
    [btn setAllStateBg:bg];
    // 按钮边框
    btn.bounds= (CGRect){CGPointZero, size};
    // 监听器
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
