//
//  QSCViewController.h
//  qingsongchou
//
//  Created by Chai on 15/8/27.
//  Copyright (c) 2015年 Chai. All rights reserved.
//
typedef NS_ENUM(NSInteger, QSCSBName)
{
    ShopSBNameHome = 0,
    ShopSBNameCategory,
    ShopSBNameShops,
    ShopSBNameME,
    ShopSBNameLogin
};


#import <UIKit/UIKit.h>

@interface ShopBaseViewController : UIViewController
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *BCimageView;
@property (nonatomic,strong) UILabel *BCDetailLabel;
@property (nonatomic,strong) UIButton *btn;

+ (instancetype) viewController:(QSCSBName)sbName;
- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName;
- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName btnHidden:(BOOL)hidden;

- (void) setTitleViewText:(NSString *)text;
- (void)reloadTheData;

@end

@interface ShopBaseTableViewController : UITableViewController
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *detailLabel;
@property (nonatomic,strong) UIButton *btn;
@property (nonatomic, assign) NSInteger page;



//设置刷新
//- (void) setUpRefreshController;
+ (instancetype) viewController:(QSCSBName)sbName;

/**
 *  设置没有数据的显示背景图
 */

- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName;
- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName btnHidden:(BOOL)hidden;

- (void) setTitleViewText:(NSString *)text;

/**
 *  隐藏背景图
 */

- (void)hiddenBackgroundView:(BOOL)hidden;

- (void)reloadTheData;

@end
