//
//  SearchController.m
//  JLshopios
//
//  Created by 陈霖 on 16/8/30.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "SearchController.h"
#import "CommodityTableViewController.h"

static const CGFloat kItemSpace = 7;
static const CGFloat kLeftItemWidth = 35;
static const CGFloat kTitleViewHeight = 30;
static const CGFloat kBackItemWidth = 40;
static const CGFloat kRightItemWidth = 40;

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    //设置左导航按钮
    UIBarButtonItem *itemBtn = [[UIBarButtonItem alloc] initWithTitle:@"商品" style:UIBarButtonItemStylePlain target:self action:@selector(exchange:)];
    itemBtn.width = kBackItemWidth;
//    self.navigationItem.leftBarButtonItem.width = kLeftItemWidth;
    
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"flight_title_back_normal"] style:UIBarButtonItemStylePlain target:self action:@selector(backRoot)];
    itemBack.width = 50;
    NSArray * arr = [[NSArray alloc] initWithObjects:itemBack,itemBtn, nil];
    self.navigationItem.leftBarButtonItems = arr;
    
    //设置右导航按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithTitle:@"搜索" style:UIBarButtonItemStylePlain target:self action:@selector(searchAction)];
    [self.navigationItem.rightBarButtonItem setWidth:kRightItemWidth];
    
    self.navigationItem.titleView = [self titleView];
    
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:lineView];
}

- (UIView *)titleView{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 2, [UIScreen mainScreen].bounds.size.width - kRightItemWidth - kLeftItemWidth - 60, kTitleViewHeight)];
//    titleView.backgroundColor = [UIColor blackColor];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:titleView.frame];
//    imgView.backgroundColor = [UIColor redColor];
    imgView.image = [UIImage imageNamed:@"HomePageSH_searchBack_bg"];
    [titleView addSubview:imgView];
//    titleView
   UITextField * textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 2, [UIScreen mainScreen].bounds.size.width - kRightItemWidth - kLeftItemWidth - kBackItemWidth, kTitleViewHeight)];
    textField.placeholder = @" 搜索";
    textField.font = [UIFont systemFontOfSize:14];
    textField.tintColor = [UIColor blackColor];
    [titleView addSubview:textField];
    self.textField = textField;
    return titleView;
}

- (void) exchange:(UIBarButtonItem *)itemBtn{
    
    if ([self.view viewWithTag:666]) {
        UIView *view = [self.view viewWithTag:666];
        [view removeFromSuperview];
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(self.navigationItem.leftBarButtonItems[0].width, 0, itemBtn.width, 60)];
    view.tag = 666;
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    for (int i = 0; i < 2; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.frame = CGRectMake(0, 30*i, 40, 30);
        NSString *textStr = i == 0? @"商品" : @"商铺";
        [btn setTitle:textStr forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(chooseAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btn];
    }
    MYLog(@"item事件");
}

- (void)chooseAction:(UIButton *)btn {
    [self.navigationItem.leftBarButtonItems[1] setTitle:btn.titleLabel.text];
    [btn.superview removeFromSuperview];
}

- (void)searchAction
{
    MYLog(@"右侧搜索");
    if ([_textField.text isEqualToString:@""]) {
        [FYTXHub toast:@"请输入查询信息!"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
        return;
    }
    
    if ([self.navigationItem.leftBarButtonItems[1].title isEqualToString:@"商品"]) {
        CommodityTableViewController *commod = [[CommodityTableViewController alloc] initWithType:0];
        commod.secondMenuIDStr = @"";
        commod.searchNameStr = _textField.text;
        [self.navigationController pushViewController:commod animated:YES];
    }else if ([self.navigationItem.leftBarButtonItems[1].title isEqualToString:@"商铺"]){
        CommodityTableViewController *commod = [[CommodityTableViewController alloc] initWithType:1];
        commod.secondMenuIDStr = @"";
        commod.searchNameStr = _textField.text;
        [self.navigationController pushViewController:commod animated:YES];
    }
}

- (void)backRoot{
    [self.navigationController popViewControllerAnimated:YES];
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
