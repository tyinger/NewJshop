//
//  UIViewController+NMExtension.m
//  TestNAC
//
//  Created by tiger on 16/5/16.
//  Copyright © 2016年 zhongwu. All rights reserved.
//

#import "UIViewController+NMExtension.h"
#import "JZNavigationExtension.h"

@implementation UIViewController (UIViewController_NMExtension)


/**
 *   显示头部导航栏隐藏头部导航
 *
 *  @param aflag yes 表示显示
 */
- (void)setNm_wantsNavigationBarVisible:(BOOL)aflag{
    self.jz_wantsNavigationBarVisible = aflag;
}


/**
 *  隐藏tabbar底部
 *
 *  @param aflag yes表示隐藏
 */
- (void)setNm_HidesBottomBarWhenPushed:(BOOL)aflag{
    
    self.hidesBottomBarWhenPushed = aflag;
}












































@end


