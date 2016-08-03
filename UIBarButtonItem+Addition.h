//
//  UIBarButtonItem+Addition.h
//  MaiQuan
//
//  Created by 王圆的Mac on 14-1-23.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//  UIBarButtonItem自定义的封装

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Addition)

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon;

+ (UIBarButtonItem *)barButtonItemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)barButtonItemWithBg:(NSString *)bg title:(NSString *)title size:(CGSize)size target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action icon:(NSString *)icon highlightedIcon:(NSString *)highlightedIcon heights:(CGFloat)heights widths:(CGFloat)widths;
@end
