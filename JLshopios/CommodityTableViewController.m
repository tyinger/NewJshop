//
//  CommodityTableViewController.m
//  jdmobile
//
//  Created by SYETC02 on 15/6/19.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import "CommodityTableViewController.h"
#import "PPiFlatSegmentedControl.h"
#import "NSString+FontAwesome.h"
#import "SearchBarView.h"
//#import "JDNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "CommodityModel.h"
#import "CommodityTableViewCell.h"
//#import "DetailsViewController.h"
#import "ShopNextController.h"
#import "JLFlowLayout.h"
#import "JLCommdoityCollectionCell.h"
#import "UIScrollView+MJRefresh.h"
#import "DetailsViewController.h"
#import <UIImageView+WebCache.h>

@interface CommodityTableViewController ()<SearchBarViewDelegate,UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate>
{
    UITableView *_tableView;
    JLFlowLayout * _layout;
    UICollectionView * _collectionView;
    NSMutableArray *_commodity;
    NSString *_OderTypeStr;
    NSString *_OderDesStr;
    BOOL _isOderTypeSoldNum;
    BOOL _isOderDesUp;
    NSInteger _tabbarNum;
}
@property (strong, nonatomic) UILabel *backGroundLabel;
@end

@implementation CommodityTableViewController

- (instancetype)initWithType:(NSInteger)tabbarNum{
    self = [super init];
    if (self) {
        _tabbarNum = tabbarNum;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = RGB(239, 243, 246);
    //初始化数据
    [self initData:self.secondMenuIDStr];
    //设置导航栏
    [self setupNavigationItem];
    //初始化视图
    [self initView:_tabbarNum];
}

-(void)refresh
{
    NSLog(@"上啦刷新");
    [_tableView.mj_header endRefreshing];
}

-(void)loadMore
{
    NSLog(@"下啦刷新");
    [_tableView.mj_footer endRefreshing];
}
#pragma mark 加载数据
-(void)initData:(NSString *)menuID{

    _commodity=[[NSMutableArray alloc]init];
    
    NSString *parameterStr = [NSString stringWithFormat:@"{\"name\":\"\",\"goodsType\":\"2\",\"id\":\"%@\",\"pageno\":\"0\",\"pagesize\":\"10\",\"orderType\":\"soldNum\",\"orderDes\":\"0\"}",menuID];
    NSDictionary *dic = @{@"arg0":parameterStr};
    [FYTXHub progress:@"正在加载。。。"];
    NSLog(@" ------ %@ ------",dic[@"arg0"]);
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/listGoods?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        [_commodity setArray:json];
            if (!_tableView) {
                //创建一个分组样式的UITableView
                _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 40, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64-40) style:UITableViewStylePlain];
                //设置数据源，注意必须实现对应的UITableViewDataSource协议
                _tableView.dataSource=self;
                //设置代理
                _tableView.delegate=self;
                _tableView.rowHeight = 90;
                _tableView.backgroundColor=RGB(240, 243, 245);
                [self.view addSubview:_tableView];
                
                [_tableView registerNib:[UINib nibWithNibName:@"CommodityTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
                _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
                
                _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
            }
        
        } failure:^(NSError *error) {
            [FYTXHub dismiss];
            //添加提示信息
            [self.view addSubview:[self backGroundLabel]];
            NSLog(@"-----%@",error);
    }];
}
- (void)setupNavigationItem {
 
//    self.navigationItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"back_bt_7" highBackgroudImageName:nil target:self action:@selector(backClick)];

    UIBarButtonItem *chooseBtn = [[UIBarButtonItem alloc]initWithTitle:@"666" style:UIBarButtonItemStyleDone target:self action:@selector(chooseBtnAction)];
    
    NSArray * arr = [[NSArray alloc] initWithObjects:self.navigationItem.leftBarButtonItem,chooseBtn, nil];
    self.navigationItem.leftBarButtonItems = arr;
    //将搜索条放在一个UIView上
    SearchBarView *searchView;// = [[SearchBarView alloc]init];
    
    if (!_tabbarNum) {
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem BarButtonItemWithBackgroudImageName:@"main_bottom_tab_cart_focus" highBackgroudImageName:nil target:self action:@selector(changeClick:)];
        searchView = [[SearchBarView alloc] initWithFrame:CGRectMake(250, 0, 240 , 30)];
    }else{
        searchView = [[SearchBarView alloc] initWithFrame:CGRectMake(250,
                                      0,
                                      self.view.width - CGRectGetMaxX(self.navigationItem.backBarButtonItem.customView.frame)*2,
                                      30)];
    }
    searchView.delegate=self;
    NSLog(@"%@",NSStringFromCGRect(searchView.frame));
    searchView.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = searchView;
    self.navigationController.navigationBar.shadowImage=[[UIImage alloc]init];
}

- (void)initView:(NSInteger)tabbNum{
    NSArray *arr = [[NSArray alloc] init];
    arr = tabbNum ? @[@{@"text":@"附近"},
                    @{@"text":@"智能排序"}] : @[@{@"text":@"销量"},
                                            @{@"text":@"价格",@"icon":@"icon-sort"}];
    _isOderTypeSoldNum = YES;
    _isOderDesUp = NO;
    PPiFlatSegmentedControl *segmented = [[PPiFlatSegmentedControl alloc]
                                        initWithFrame:CGRectMake(0, 0, self.view.width, 40)
                                        items:arr
                                        iconPosition:IconPositionRight
                                        andSelectionBlock:^(NSUInteger segmentIndex) {
                                            
                                             MYLog(@"第几个%ld",segmentIndex);
                                            switch (segmentIndex) {
                                                    
    
                                                case 0:
                                                {
                                                    _isOderTypeSoldNum = !_isOderTypeSoldNum;
                                                    
                                                    if (_isOderTypeSoldNum) {
                                                         _OderTypeStr = @"soldNum";
                                                        _OderDesStr = @"0";
                                                    }else{
                                                        
                                                        _OderTypeStr = @"soldNum";
                                                        _OderDesStr = @"1";
                                                        
                                                    }
                                                    
                                                }
                                                    break;
                                                case 1:
                                                {
                                                    _isOderDesUp = !_isOderDesUp;
                                                    if (_isOderDesUp) {
                                                        _OderTypeStr = @"price";
                                                        _OderDesStr = @"1";
                                                    }else{
                                                        _OderTypeStr = @"price";
                                                        _OderDesStr = @"0";
                                                    }
                                                }
                                                    break;
                                                case 2:
                                                    
                                                    break;
                                                case 3:
//                                                    [self.navigationController showRightMenu];
                                                    
                                                   
                                                    break;
                                                    
                                                default:
                                                    break;
                                                    
                                            }
                                            NSString *parameterStr = [NSString stringWithFormat:@"{\"name\":\"\",\"goodsType\":\"2\",\"id\":\"%@\",\"pageno\":\"0\",\"pagesize\":\"0\",\"orderType\":\"%@\",\"orderDes\":\"%@\"}",self.secondMenuIDStr,_OderTypeStr,_OderDesStr];
                                            NSDictionary *dic = @{@"arg0":parameterStr};
                                            [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/listGoods?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
                                                [_commodity setArray:json];
                                                [_tableView reloadData];
                                            } failure:^(NSError *error) {
                                                NSLog(@"-----%@",error);
                                            }];
                                        }];
    
//    segmented.color=[UIColor colorWithPatternImage:[UIImage imageNamed:@"navigationbar_background"]];
    segmented.borderColor=[UIColor darkGrayColor];
    //segmented.selectedColor=[UIColor colorWithRed:0.0f/255.0 green:141.0f/255.0 blue:176.0f/255.0 alpha:1];
    segmented.textAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                NSForegroundColorAttributeName:RGB(135, 127, 141)};
    segmented.selectedTextAttributes=@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                        NSForegroundColorAttributeName:RGB(243, 106, 107)};
    
    [self.view addSubview:segmented];
    
}


- (void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)changeClick:(UIButton*)rightButton{
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = [JLTabMainController shareJLTabVC];
    [JLTabMainController shareJLTabVC].selectedIndex = 3;
    [self.navigationController popToRootViewControllerAnimated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource数据源方法
//#pragma mark 返回分组数
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 1;
//}

#pragma mark 返回每组行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_commodity.count == 0) {
        _tableView.hidden = YES;
    }
    return _commodity.count;
}

#pragma mark返回每行的单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier=@"Cell";
     CommodityTableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if(cell==nil){
////           cell=[[NSBundle mainBundle] loadNibNamed:@"CommodityTableViewCell" owner:self options:nil][0];
//    }

    CommodityModel *commodity = [[CommodityModel alloc] initWithDictionary:_commodity[indexPath.row]];
    
    [cell.commodityImg sd_setImageWithURL:[NSURL URLWithString:commodity.commodityImageUrl]];
    cell.commodityName.text=commodity.commodityName;
    cell.commodityPrice.text=[NSString stringWithFormat:@"￥%@",commodity.commodityPrice];
//    cell.commodityZX.image=[UIImage imageNamed:commodity.commodityZX];
//    cell.commodityPraise.text=commodity.praise;
    
    return cell;
}

#pragma mark - UITableViewDelegate代理方法

#pragma mark 每行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"cell selected at index path %i", (int)indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DetailsViewController * detailsTVC = [[DetailsViewController alloc]init];
//    [self.navigationController pushViewController:detailsTVC animated:YES];
    CommodityModel *commodity = [[CommodityModel alloc] initWithDictionary:_commodity[indexPath.row]];
    DetailsViewController *next = [[DetailsViewController alloc] init];
    next.productIDStr = [NSString stringWithFormat:@"%lld",commodity.Id];
    [self.navigationController pushViewController:next animated:YES];
}

//获取数据
- (void)loadDataFromClientWithMenuID:(NSString *)menuID andPageno:(NSString *)pageno andOrderType:(NSString *)orderType andOrderDes:(NSString *)orderDes{
    
    NSString *parameterStr = [NSString stringWithFormat:@"{\"name\":\"\",\"goodsType\":\"2\",\"id\":\"%@\",\"pageno\":\"%@\",\"pagesize\":\"10\",\"orderType\":\"%@\",\"orderDes\":\"%@\"}",menuID,pageno,orderType,orderDes];
    NSDictionary *dic = @{@"arg0":parameterStr};
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/listGoods?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
        
        [_commodity setArray:json];
        [_tableView reloadData];
        
    } failure:^(NSError *error) {
        
        NSLog(@"-----%@",error);
        
    }];
    
}

#pragma mark 滑动事件
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    NSLog(@"scroll view did begin dragging");
    
}

#pragma mark 写入plist文件

- (void)writeToLocalPlist:(id)json{
    NSString *path = @"/Users/mymac/Desktop/";
    NSString *fileName = [path stringByAppendingPathComponent:@"secondProduct.plist"];
    NSFileManager *fm = [NSFileManager defaultManager];
    [fm createFileAtPath:fileName contents:nil attributes:nil];
    [json writeToFile:fileName atomically:YES];
}

- (UILabel *)backGroundLabel{
    UILabel *backLabel = [[UILabel alloc] init];
    backLabel.size = CGSizeMake(200, 30);
    backLabel.centerX = self.view.centerX;
    backLabel.centerY = self.view.centerY - 50;
    backLabel.text = @"对不起，目前无更多信息";
    backLabel.textColor = RGB(93, 93, 93);
    backLabel.font = [UIFont boldSystemFontOfSize:17];
    return backLabel;
}

@end
