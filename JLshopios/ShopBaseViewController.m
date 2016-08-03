//
//  QSCViewController.m
//  qingsongchou
//
//  Created by Chai on 15/8/27.
//  Copyright (c) 2015年 Chai. All rights reserved.
//

#import "ShopBaseViewController.h"
//#import "UIViewController+TableView.h"
//#import <AlicloudMobileAnalitics/ALBBMAN.h>
#import "IQKeyboardManager.h"
@interface ShopBaseViewController ()

@end

@implementation ShopBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addBackView];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder=YES;
    
    MYLog(@"%@ viewDidLoad",self);
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder=YES;
}



- (void)setTitleViewText:(NSString *)text {
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.title = text;
}

- (void)addBackView
{
    CGFloat imageWith = 140.0;
    _backView  = [[UIView alloc]initWithFrame:self.view.frame];
    
    UIImageView *imageView;
    if (iPhone4) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth - imageWith) / 2 , 144 - 64 - 40, imageWith, imageWith)];
    }else{
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth - imageWith) / 2 , 144 - 64, imageWith, imageWith)];
    }
   
    _BCimageView = imageView;
    _BCimageView.hidden = YES;
    [_backView addSubview:imageView];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_BCimageView.frame) + 20, kDeviceWidth, 44)];
    _BCDetailLabel = detailLabel;
    _BCDetailLabel.hidden = YES;
    detailLabel.textColor = [UIColor lightGrayColor];
    [detailLabel setTextAlignment:NSTextAlignmentCenter];
    detailLabel.font = [UIFont systemFontOfSize:15];
    _backView.backgroundColor =[UIColor whiteColor];
    [_backView addSubview:detailLabel];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn = btn;
//    btn.frame = CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(detailLabel.frame) + 20, imageWith, 44);
    btn.frame = CGRectMake(15, KDeviceHeight - 20 - 40 - 64, kDeviceWidth - 30, 40);
    [btn setTitle:@"重新加载" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = QSCTextColor;
    btn.layer.cornerRadius = 20;
//    [btn.layer setBorderWidth:1];
//    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor]; // 边框颜色
    btn.layer.masksToBounds = YES;
    
    btn.hidden = YES;
    [_backView addSubview:btn];
    
    [btn addTarget:self action:@selector(reloadTheData) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_backView];
    _backView.hidden = YES;
}

- (void)reloadTheData
{

}

- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName
{
    [self.view bringSubviewToFront:_backView];
    if (show == YES) {
        _backView.hidden = NO;
        _BCimageView.hidden = NO;
        _BCDetailLabel.hidden = NO;
        _BCimageView.image = [UIImage imageNamed:imageName];
        _btn.hidden = YES;
        _BCDetailLabel.text = message;
    }else if(show == NO){
        _backView.hidden = NO;
        _BCimageView.hidden = YES;
        _BCDetailLabel.hidden = NO;
        _BCDetailLabel.frame = CGRectMake(0, 100, kDeviceWidth, 44);
        _BCDetailLabel.text = message;
        _btn.hidden = YES;
    }
}

- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName btnHidden:(BOOL)hidden
{
    [self.view bringSubviewToFront:_backView];
    if (show == YES) {
        _backView.hidden = NO;
        _BCimageView.hidden = NO;
        _BCDetailLabel.hidden = NO;
        _BCimageView.image = [UIImage imageNamed:imageName];
        _btn.hidden = hidden;
        _BCDetailLabel.text = message;
    }else if(show == NO){
        _backView.hidden = NO;
        _BCimageView.hidden = YES;
        _BCDetailLabel.hidden = NO;
        _BCDetailLabel.frame = CGRectMake(0, 100, kDeviceWidth, 44);
        _BCDetailLabel.text = message;
        _btn.hidden = hidden;
    }

}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}

+ (instancetype)viewController:(QSCSBName)sbName {
    
    switch (sbName) {
        case ShopSBNameHome:
        {
            static UIStoryboard * s_storyboardHome = nil;
            
            if ( !s_storyboardHome ){
                s_storyboardHome = [UIStoryboard storyboardWithName:@"ShopHome" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardHome instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameCategory:
        {
            static UIStoryboard * s_storyboardMSG = nil;
            
            if ( !s_storyboardMSG ){
                s_storyboardMSG = [UIStoryboard storyboardWithName:@"Category" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardMSG instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameShops:
        {
            static UIStoryboard * s_storyboardRelease = nil;
            
            if ( !s_storyboardRelease ){
                s_storyboardRelease = [UIStoryboard storyboardWithName:@"Release" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardRelease instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameME:
        {
            static UIStoryboard * s_storyboardIM = nil;
            
            if ( !s_storyboardIM ){
                s_storyboardIM = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardIM instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameLogin:
        {
            static UIStoryboard * s_storyboardIM = nil;
            
            if ( !s_storyboardIM ){
                s_storyboardIM = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardIM instantiateViewControllerWithIdentifier:identifier];
            break;
        }
       
            
        default:
        {
            static UIStoryboard * s_storyboardLogin = nil;
            
            if ( !s_storyboardLogin ){
                s_storyboardLogin = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardLogin instantiateViewControllerWithIdentifier:identifier];
        }
            break;
    }
}

@end

@implementation ShopBaseTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _page = 1;
    
//    [self hiddenCellLine:self.tableView];ho
    [self addBackView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [IQKeyboardManager sharedManager].shouldShowTextFieldPlaceholder=YES;
}



- (void)setTitleViewText:(NSString *)text {
    
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:17],NSFontAttributeName, nil];
    
    self.navigationController.navigationBar.titleTextAttributes = attributes;
    self.title = text;
}

- (void)addBackView
{
    CGFloat imageWith = 80.0;
    _backView  = [[UIView alloc]initWithFrame:self.view.frame];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((kDeviceWidth - imageWith) / 2 , 144 - 64, imageWith, imageWith)];
    _imageView = imageView;
//    _imageView.image = [UIImage imageNamed:@"msg_product_tips"];
    _imageView.hidden = YES;
    [_backView addSubview:imageView];
    
    UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 20, kDeviceWidth, 44)];
    _detailLabel = detailLabel;
    _detailLabel.hidden = YES;
    detailLabel.textColor = [UIColor lightGrayColor];
    [detailLabel setTextAlignment:NSTextAlignmentCenter];
    detailLabel.font = [UIFont systemFontOfSize:15];
    _backView.backgroundColor =[UIColor whiteColor];
    [_backView addSubview:detailLabel];

    [self.view addSubview:_backView];
    _backView.hidden = YES;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn = btn;
    //    btn.frame = CGRectMake(imageView.frame.origin.x, CGRectGetMaxY(detailLabel.frame) + 20, imageWith, 44);
    btn.frame = CGRectMake(15, KDeviceHeight - 20 - 40 - 64, kDeviceWidth - 30, 40);
    [btn setTitle:@"重新加载" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = QSCTextColor;
    btn.layer.cornerRadius = 20;
    //    [btn.layer setBorderWidth:1];
    //    btn.layer.borderColor = [[UIColor lightGrayColor] CGColor]; // 边框颜色
    btn.layer.masksToBounds = YES;
    
    btn.hidden = YES;
    [_backView addSubview:btn];
    
    [btn addTarget:self action:@selector(reloadTheData) forControlEvents:UIControlEventTouchUpInside];
}

-(void)reloadTheData
{


}



- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName
{
    [self.view bringSubviewToFront:_backView];
    if (show == YES) {
        _backView.hidden = NO;
        _imageView.hidden = NO;
        _detailLabel.hidden = NO;
        _imageView.image = [UIImage imageNamed:imageName];
        _detailLabel.text = message;
        _btn.hidden = YES;
    }else if(show == NO){
        _backView.hidden = NO;
        _imageView.hidden = YES;
        _detailLabel.hidden = NO;
        _detailLabel.frame = CGRectMake(0, 100, kDeviceWidth, 44);
        _detailLabel.text = message;
        _btn.hidden = YES;
    }
}

- (void)showBackViewWithNoListImage:(BOOL)show detailMessage:(NSString *)message imageName:(NSString *)imageName btnHidden:(BOOL)hidden
{
    [self.view bringSubviewToFront:_backView];
    if (show == YES) {
        _backView.hidden = NO;
        _imageView.hidden = NO;
        _detailLabel.hidden = NO;
        _imageView.image = [UIImage imageNamed:imageName];
        _btn.hidden = hidden;
        _detailLabel.text = message;
    }else if(show == NO){
        _backView.hidden = NO;
        _imageView.hidden = YES;
        _detailLabel.hidden = NO;
        _detailLabel.frame = CGRectMake(0, 100, kDeviceWidth, 44);
        _detailLabel.text = message;
        _btn.hidden = hidden;
    }
}


- (void)hiddenBackgroundView:(BOOL)hidden
{
    if (hidden == YES) {
        _backView.hidden = YES;
    }else{
        _backView.hidden = NO;
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    

}

//-(void)viewDidLayoutSubviews
//{
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//    }
//    
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
//    }
//}
//
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}

+ (instancetype)viewController:(QSCSBName)sbName{
    
    switch (sbName) {
        case ShopSBNameHome:
        {
            static UIStoryboard * s_storyboardHome = nil;
            
            if ( !s_storyboardHome ){
                s_storyboardHome = [UIStoryboard storyboardWithName:@"Home" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardHome instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameCategory:
        {
            static UIStoryboard * s_storyboardBrand = nil;
            
            if ( !s_storyboardBrand ){
                s_storyboardBrand = [UIStoryboard storyboardWithName:@"Category" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardBrand instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameShops:
        {
            static UIStoryboard * s_storyboardRelease = nil;
            
            if ( !s_storyboardRelease ){
                s_storyboardRelease = [UIStoryboard storyboardWithName:@"Shops" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardRelease instantiateViewControllerWithIdentifier:identifier];
            break;
        }
      
        case ShopSBNameME:
        {
            static UIStoryboard * s_storyboardME = nil;
            
            if ( !s_storyboardME ){
                s_storyboardME = [UIStoryboard storyboardWithName:@"ME" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardME instantiateViewControllerWithIdentifier:identifier];
            break;
        }
        case ShopSBNameLogin:
        {
            static UIStoryboard * s_storyboardLogin = nil;
            
            if ( !s_storyboardLogin ){
                s_storyboardLogin = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardLogin instantiateViewControllerWithIdentifier:identifier];
            break;
        }
            
            
        default:
        {
            static UIStoryboard * s_storyboardLogin = nil;
            
            if ( !s_storyboardLogin ){
                s_storyboardLogin = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
            }
            NSString * identifier = NSStringFromClass([self class]);
            return [s_storyboardLogin instantiateViewControllerWithIdentifier:identifier];
        }
        break;
    }
}

@end
