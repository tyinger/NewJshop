//
//  UIViewController+NMExtension.h
//  TestNAC
//
//  Created by tiger on 16/5/16.
//  Copyright © 2016年 zhongwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (UIViewController_NMExtension )

/**
 *   显示头部导航栏隐藏头部导航
 *
 *  @param aflag yes 表示显示
 */
- (void)setNm_wantsNavigationBarVisible:(BOOL)aflag;


/**
 *  隐藏tabbar底部
 *
 *  @param aflag yes表示隐藏
 */
- (void)setNm_HidesBottomBarWhenPushed:(BOOL)aflag;



@end
