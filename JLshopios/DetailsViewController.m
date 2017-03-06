//
//  DetailseViewController.m
//  jdmobile
//
//  Created by 丁博洋 on 15/6/22.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//
#import "MyOrderDetailViewController.h"
#import "DetailsViewController.h"
#import "SDCycleScrollView.h"
#import "AppDelegate.h"
#import "CellConfig.h"
#import "JLTabMainController.h"
//#import "CartViewController.h"
#import "CommodityInfoCell.h"
#import "CommoditySelectCell.h"
#import "LoginViewController.h"
#import "QSCNavigationController.h"
#import "DetailsMode.h"
#import "ShopingCartController.h"
#import "CustomBadge.h"
#import "UIButton+CustomBadge.h"

@class QSCHttpTool;
@interface DetailsViewController ()<UITableViewDataSource, UITableViewDelegate,SDCycleScrollViewDelegate,MBProgressHUDDelegate,UIWebViewDelegate,UIAlertViewDelegate>
{
    MBProgressHUD *HUD;
    NSMutableArray *_images;
    UILabel *_indexPage;
    UIButton * _cart;
}
@property (nonatomic, strong) UITableView *tableView;
/// cellConfig数据源
@property (nonatomic, strong) NSMutableArray *dataArray;
/// 数据模型
@property (nonatomic, strong) DetailsMode *modelToShow;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic,strong) UISegmentedControl *segment;

@property (nonatomic,strong) UIWebView *webView;

@end

@implementation DetailsViewController


//- (DetailsMode *)modelToShow
//{
//    if (!_modelToShow) {
//        _modelToShow = [[DetailsMode alloc] initWithDictionary:self.dataDic];
//        NSLog(@"modelToShow%@",_modelToShow);
//    }
//    return _modelToShow;
//}
/**
 *  改变不同类型cell的顺序、增删时，只需在此修改即可，
 *  无需在多个tableView代理方法中逐个修改
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        
        // 二维数组作为tableView的结构数据源
        _dataArray = [NSMutableArray array];

        // 购买信息
        CellConfig *comInfo = [CellConfig cellConfigWithClassName:NSStringFromClass([CommodityInfoCell class]) title:@"购买信息" showInfoMethod:@selector(showInfo:) heightOfCell:_modelToShow.cellHeight cellType:NO];
        
//        CellConfig *comSelect = [CellConfig cellConfigWithClassName:@"CommoditySelectCell" title:@"已选" showInfoMethod:@selector(showInfo:) heightOfCell:80.0f cellType:YES];
//        
//        CellConfig *comAddress = [CellConfig cellConfigWithClassName:@"CommodityAddressCell" title:@"地址" showInfoMethod:@selector(showInfo:) heightOfCell:180.0f cellType:YES];
        
//        CellConfig *comPack = [CellConfig cellConfigWithClassName:@"CommodityPackCell" title:@"包装" showInfoMethod:@selector(showInfo:) heightOfCell:50.0f cellType:YES];
//        
//        CellConfig *comPraise = [CellConfig cellConfigWithClassName:@"CommodityPraiseCell" title:@"评价" showInfoMethod:@selector(showInfo:) heightOfCell:80.0f cellType:YES];
//        
//        CellConfig *comSection = [CellConfig cellConfigWithClassName:@"CommoditySectionCell" title:@"专区" showInfoMethod:@selector(showInfo:) heightOfCell:110.0f cellType:YES];
//        
//        CellConfig *comComponent = [CellConfig cellConfigWithClassName:@"CommodityComponentCell" title:@"配件" showInfoMethod:@selector(showInfo:) heightOfCell:50.0f cellType:YES];
        
        [_dataArray addObject:@[comInfo]];//,comSelect,comAddress,comPack,comPraise,comSection,comComponent]];
        // 注意，是self.dataArray二维数组，所以这里要套一层数组
        
    }
     return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //设置导航栏
    [self setupNavigationItem];
    
    [self getSourceData:self.productIDStr];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO];
}


- (void)getSourceData:(NSString *)productIDStr
{
    [FYTXHub progress:nil];
    NSString * userId = [LoginStatus sharedManager].status ? [LoginStatus sharedManager].idStr:@"";
    NSDictionary *dic = @{@"sellType":@"normal",@"id":productIDStr,@"userId":userId};
    NSLog(@" ------ %@ ------",dic);
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/goodsDetail?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
        NSLog(@"正确返回%@",json[@"goods"][@"goodsDetail"]);
        [FYTXHub success:nil delayClose:0 compelete:^{
                
            _modelToShow = [[DetailsMode alloc] initWithDictionary:json];
            //初始化视图
            [self initView];
        }];
//            NSLog(@"%@",json[@"shop"][@"id"]);
//            self.dataDic = [NSDictionary dictionaryWithDictionary:json];
//            NSLog(@"dataDic%@",json);
//            NSString *path = @"/Users/mymac/Desktop/";
//            NSString *fileName = [path stringByAppendingPathComponent:@"Product.plist"];
//            NSFileManager *fm = [NSFileManager defaultManager];
//            [fm createFileAtPath:fileName contents:nil attributes:nil];
//            [json writeToFile:fileName atomically:YES];

        } failure:^(NSError *error) {
            [FYTXHub dismiss];
            [FYTXHub toast:@"网络错误!"];
            NSLog(@"错误返回%@",error);
    }];
}

- (void)setupNavigationItem {
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.rightBarButtonItems =@[[UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ware_more" highBackgroudImageName:nil target:self action:@selector(wareMoreClick)], [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"ware_histroy" highBackgroudImageName:nil target:self action:@selector(wareMoreClick)]];
    
    self.navigationItem.titleView = self.segment;
}

- (UISegmentedControl *)segment{
    
    if (!_segment) {
        
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"商品详情",@"视频"]];
        _segment.tintColor = [UIColor clearColor];
        _segment.selectedSegmentIndex = 0;
        
        NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]};
        NSDictionary *normolTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor grayColor]};
        
        [_segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        [_segment setTitleTextAttributes:normolTextAttributes forState:UIControlStateNormal];
        
        [_segment addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

- (void)segmentAction:(UISegmentedControl *)seg{
    
    if (seg.selectedSegmentIndex == 0) {
        
        self.tableView.hidden = NO;
        self.webView.hidden = YES;
    }else{
        
        self.tableView.hidden = YES;
        self.webView.hidden = NO;
    }
}

- (void)initView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-100) style:UITableViewStyleGrouped];
    
    [self.view addSubview:self.tableView];
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView =[self addHeaderView];
    self.tableView.tableFooterView =[self addFooterView];
    
    UIView * view =[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-60, self.view.width, 60)];
    view.backgroundColor=RGBA(0, 0, 0, 0.8);
    [self.view addSubview:view];
    
    UIButton * addCart =[UIButton createButtonWithFrame:CGRectMake(view.size.width-160, 0, 160, view.size.height) Title:@"加入购物车" Target:self Selector:@selector(addCartClick)];
    [addCart.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [addCart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [addCart setBackgroundColor:RGB(255, 100, 98)];

    [view addSubview:addCart];
    UIView * view1=[[UIView alloc]initWithFrame:CGRectMake(0, 0, view.size.width-addCart.size.width, view.size.height)];
    [view addSubview:view1];
    UIButton * focus;
    if ([_modelToShow.detailsIsFoucs isEqualToString:@"0"]) {
        focus =[UIButton createButtonWithImage:@"wareb_focus" Title:@"关注" Target:self Selector:@selector(wareMoreClick:)];
    }else{
        focus =[UIButton createButtonWithImage:@"wareb_focus_end" Title:@"关注" Target:self Selector:@selector(wareMoreClick:)];
        focus.selected = YES;
    }
    
    [focus setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    focus.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 20, 0);
    focus.titleEdgeInsets = UIEdgeInsetsMake(40,-35, 0, 0);
    [view1 addSubview:focus];
    
    _cart =[UIButton createButtonWithImage:@"btn_ware_buy_h" Title:@"购物车" Target:self Selector:@selector(cartClick)];
    [_cart setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cart.imageEdgeInsets = UIEdgeInsetsMake(0, 25, 20, 0);
    _cart.titleEdgeInsets = UIEdgeInsetsMake(40,-35, 0, 0);
//    [_cart setBadgeWithNumber:@5];
    [view1 addSubview:_cart];
    [MasonyUtil equalSpacingView:@[focus,_cart]
                       viewWidth:view1.size.width/2
                      viewHeight:view1.size.height
                  superViewWidth:view1.size.width];
//TODO:Mars修改
    UIButton * purchaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [purchaseButton setFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/3, 0, [UIScreen mainScreen].bounds.size.width/3*2, focus.height)];
    [purchaseButton setTitle:@"直接购买" forState:0];
    [purchaseButton setTitleColor:[UIColor whiteColor] forState:0];
    purchaseButton.backgroundColor = [UIColor redColor];
    [[purchaseButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        //去购买
        NSLog(@"去购买");

        UIAlertView * AV = [[UIAlertView alloc] init];
        AV.alertViewStyle = UIAlertViewStylePlainTextInput;
        AV.title = @"请选择数量";
        [AV addButtonWithTitle:@"取消"];
        [AV addButtonWithTitle:@"确定"];
        AV.delegate = self;
        [[AV textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
        [AV show];
    

    }];
    focus.width = [UIScreen mainScreen].bounds.size.width/3;
    //两个按钮  addCart   _cart
    if ([_modelToShow.shopid intValue] == 1) {
        //加入购物车
        addCart.hidden = NO;
        _cart.hidden = NO;
        [purchaseButton removeFromSuperview];
    }else{
        addCart.hidden = YES;
        _cart.hidden = YES;
        view1.width = [UIScreen mainScreen].bounds.size.width;
             [view1 addSubview:purchaseButton];
        [MasonyUtil equalSpacingView:@[focus,purchaseButton]
                           viewWidth:view1.size.width/2
                          viewHeight:view1.size.height
                      superViewWidth:view1.size.width];
    }
    
    [RACObserve([CartManager sharedManager], totalNum) subscribeNext:^(NSNumber *x) {
        [_cart setBadgeWithNumber:x];
    }];
    
    self.webView.hidden = YES;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_modelToShow.videoUrl]]];
    [self.view addSubview:self.webView];
}

- (UIView*)addHeaderView{

//    _images = @[
//                [UIImage imageNamed:@"h1.jpg"],
//                [UIImage imageNamed:@"h2.jpg"],
//                [UIImage imageNamed:@"h3.jpg"],
//                [UIImage imageNamed:@"h4.jpg"]
//                 ];
    UIView * view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
    view.backgroundColor = [UIColor whiteColor];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

       dispatch_async(dispatch_get_main_queue(), ^{
           
           _images = [NSMutableArray arrayWithCapacity:0];
           for (int i = 0; i < _modelToShow.previewImgs.count; i++) {
               [_images addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_modelToShow.previewImgs[i][@"path"]]]]];
           }
           SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, view.size.width, view.size.height) imageNamesGroup:_images];
           cycleScrollView.placeholderImage = [UIImage imageWithName:@"img_home_banner1"];
           cycleScrollView.autoScroll = NO;
           cycleScrollView.infiniteLoop = NO;
           cycleScrollView.delegate = self;
           cycleScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
           
           [view addSubview:cycleScrollView];
           UIImageView * imageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"circleBackground"]];
           imageView.frame=CGRectMake(cycleScrollView.size.width-70, cycleScrollView.size.height-70, 50, 50);
           [cycleScrollView addSubview:imageView];
           _indexPage=[[UILabel alloc]initWithFrame:CGRectMake(0,0, imageView.size.width, imageView.size.height)];
           _indexPage.textAlignment = NSTextAlignmentCenter;
           _indexPage.font=[UIFont systemFontOfSize:24];
           _indexPage.textColor=[UIColor whiteColor];
           _indexPage.text=[NSString stringWithFormat:@"%i/%i",cycleScrollView.indexPage+1,(int)_images.count];
           [imageView addSubview:_indexPage];
        });
    });
    return view;
}

- (UIView *)addFooterView{
//        NSString *strHTML = @"<p><img src=\"http://123.56.192.182/http_resource/image/ueditor/201610221477119211606038854.jpg\" title=\"201610221477119211606038854.jpg\" alt=\"劲酒.jpg\"/></p>";
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    [webView loadHTMLString:_modelToShow.detailsImgZX baseURL:nil];
//    webView.scalesPageToFit = YES;
//    webView.userInteractionEnabled = NO;
//    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.width)];
//    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_modelToShow.detailsImgZX dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    textView.attributedText = attributedString;
    return webView;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if (webView.tag != 1001) {
        
        //    NSString *meta = [NSString stringWithFormat:@"document.getElementsByName(\"viewport\")[0].content = \"width=%f, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no\"",320.0];
        //    [webView stringByEvaluatingJavaScriptFromString:meta];
        double aaa = [UIScreen mainScreen].bounds.size.width - 20;
        NSString *str = [NSString stringWithFormat:@"var script = document.createElement('script');"
                         "script.type = 'text/javascript';"
                         "script.text = \"function ResizeImages() { "
                         "var myimg,oldwidth;"
                         "var maxwidth=%f;" //缩放系数
                         "for(i=0;i <document.images.length;i++){"
                         "myimg = document.images[i];"
                         "if(myimg.width > maxwidth){"
                         "oldwidth = myimg.width;"
                         "myimg.width = maxwidth;"
                         "myimg.height = myimg.height * (maxwidth/oldwidth+0.3);"
                         "}"
                         "}"
                         "}\";"
                         "document.getElementsByTagName('head')[0].appendChild(script);",aaa];
        [webView stringByEvaluatingJavaScriptFromString:str];
        
        [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    }else{
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {


    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

   return [self.dataArray[section] count];
}

#pragma mark 设置cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 拿到cellConfig
    CellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];
    // 拿到对应cell并根据模型显示
    UITableViewCell *cell = [cellConfig cellOfCellConfigWithTableView:tableView dataModel:self.modelToShow cellForRowAtIndexPath:indexPath];

    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    CellConfig *cellConfig = self.dataArray[indexPath.section][indexPath.row];

    return _modelToShow.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}
#pragma mark - TableView Delegate
#pragma mark 选中cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==5) {
        return 15;
    }
    return 0.001;
}


- (void)wareMoreClick:(UIButton *)btn {
    
    if (![LoginStatus sharedManager].status) {
        [FYTXHub toast:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
        return;
    }
    btn.selected = !btn.selected;
    [[CartManager sharedManager] followActionType:0 ID:[NSString stringWithFormat:@"%lld",_modelToShow.Id] isFollow:btn.selected :^(id obj) {
        
            if (btn.selected) {
                
                UIImage *Image = [[UIImage imageWithName:@"wareb_focus_end"] scaleImageWithSize:CGSizeMake(35, 35)];
                [btn setImage:Image forState:UIControlStateNormal];
                [btn setImage:[UIImage imageWithName:nil] forState:UIControlStateHighlighted];
                [FYTXHub toast:@"关注成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [FYTXHub dismiss];
                });

            }else{
                UIImage *Image = [[UIImage imageWithName:@"wareb_focus"] scaleImageWithSize:CGSizeMake(35, 35)];
                [btn setImage:Image forState:UIControlStateNormal];
            }
        } :^(id obj) {
        MYLog(@"操作失败");
    }];
}

-(void)showLoginView{

    QSCNavigationController *loginView = [[QSCNavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    
    [self presentViewController:loginView animated:YES completion:nil];
}
- (void)addCartClick{
    
//    post方式提交
//    goodid,num,jsFlag=0,Price,userid,goodName,goodImg,shopid=-1
//    说明:goodid是商品id，num=1，price是商品价格，userid是用户id，goodName是商品名，goodImg是商品logo
    if ([LoginStatus sharedManager].status) {

        NSDictionary *dic = @{@"goodid":[NSString stringWithFormat:@"%lld",_modelToShow.Id],
                              @"num":@"1",
                              @"jsFlag":@"0",
                              @"Price":_modelToShow.detailsPrice,
                              @"userid":[LoginStatus sharedManager].idStr,
                              @"goodName":_modelToShow.detailsName,
                              @"goodImg":_productIconStr,
                              @"shopid":@"-1"};
        
        [QSCHttpTool post:@"https://123.56.192.182:8443/app/shopCart/saveShopCart?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
            MYLog(@"加入购物车%@",json);
            [CartManager sharedManager].totalNum = [NSNumber numberWithInteger:[[CartManager sharedManager].totalNum integerValue]+1];
//            [RACObserve([CartManager sharedManager], totalNum) subscribeNext:^(NSNumber *x) {
//                [_cart setBadgeWithNumber:x];
//            }];
            
        } failure:^(NSError *error) {
            MYLog(@"加入购物车失败%@",error);
        }];
    }else{
    
        [FYTXHub toast:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
    }
}

- (void)cartClick{
    
    if (![LoginStatus sharedManager].status){
        
        [FYTXHub toast:@"请先登录"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
        
    }else{
    
    //TODO:要做登录判断
        AppDelegate *app = [UIApplication sharedApplication].delegate;
        app.window.rootViewController = [JLTabMainController shareJLTabVC];
        [JLTabMainController shareJLTabVC].selectedIndex = 3;
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
    
}

- (void)payAction:(NSString*)count{
   
    GoodModel * good = [[GoodModel alloc] init];
    good.goodid = [NSString stringWithFormat:@"%lld",_modelToShow.Id];
    good.goodName = _modelToShow.detailsName;
    good.num = count;
    [[[PayManager manager] getTheOrderCurrent:good shop:_modelToShow.shop] subscribeNext:^(id x) {
        
        if ([x[@"success"] boolValue]==NO)  {
            TTAlert(x[@"msg"]);
            
            return ;
        }
        
        SysOrderReturn * orderReturn = [SysOrderReturn objectWithKeyValues:x];
        orderReturn.order = [SysOrder objectWithKeyValues:orderReturn.order];
        orderReturn.order.orderDetails = [SysOrderDetail objectArrayWithKeyValuesArray:orderReturn.order.orderDetails];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            MyOrderDetailViewController * orderVC = [[MyOrderDetailViewController alloc] initWithNibName:@"MyOrderDetailViewController" bundle:nil];
            orderVC.orderReturn = orderReturn;
            [self.navigationController pushViewController:orderVC animated:YES];
        });
        
        NSLog(@"%@",x);
        
    }];
}

- (UIWebView *)webView{
    
    if (!_webView) {
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 164)];
        _webView.tag = 1001;
        _webView.delegate = self;
    }
    return _webView;
}

#pragma mark - AlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        UITextField *tf=[alertView textFieldAtIndex:0];
        if ([tf.text integerValue]<=0) {
            [FYTXHub toast:@"请输入正确数量"];
            return;
        }else{
            [self payAction:tf.text];
        }
    }
}
#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    _indexPage.text=[NSString stringWithFormat:@"%i/%i",(int)index+1,(int)_images.count];
}
@end
