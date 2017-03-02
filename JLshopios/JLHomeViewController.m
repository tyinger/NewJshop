//
//  JLHomeViewController.m
//  JLshopios
//
//  Created by imao on 16/6/5.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLHomeViewController.h"
#import "JLShopCollectionViewCell.h"
#import "JLShopsViewController.h"
#import "SDCycleScrollView.h"
#import "JLTypeListView.h"
#import "SearchController.h"
#import "BAddressPickerController.h"

#import "JLCityController.h"

#import "QSCHttpTool.h"

#import "JLShopModel.h"

#import "JLGoodModel.h"

#import "MultilevelMenu.h"
#import "JLShopTypeModel.h"

#import "DetailsViewController.h"
#import "ShopDetailController.h"

#define JLHomeCell @"JLHomeViewShopingCell"

#import "OtherListViewController.h"
//#define kDuration 0.3
//static const double kDuration = 0.3;


@interface JLHomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,SDCycleScrollViewDelegate,JLCityControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIButton *cityPickerButton;

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) SDCycleScrollView *cycleScrollview;
@property (weak, nonatomic) IBOutlet UIView *topSearchView;

@property (nonatomic,strong) JLTypeListView *typeListView;

// banner 的数据数组
@property (nonatomic,strong) NSArray *bannerArray;

//推荐商品接口
@property (nonatomic,strong) NSArray *hotGoodsArray;


@property (nonatomic,strong) NSArray *typeListArray;

@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,assign) CGFloat collectionHight;
@end

@implementation JLHomeViewController
{
    UIView *citySelectWindow_;
    
}

-(void)netWorkTest{
    //获取验证码的
    //    NSDictionary *dic = @{@"phoneNum":@"18643212316"};
    //    //loginName=18643212316 password=
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/getRegisterYzm?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
    //        NSLog(@"json = msg %@",json[@"msg"]);
    //    } failure:^(NSError *error) {
    //
    //    }];
    
    //注册接口
    //123.56.192.182:8443/app/user/registNewUser?
    
    /**
     *  phoneNum,checkCode
     pwd(MD5大写),recommendCode
     
     手机号 验证码 md5  推荐码
     */
    
    //    NSDictionary *dic = @{@"phoneNum":@"13631564265",@"checkCode":@"123123",@"pwd":@"IUOIJIWJEIWJEWOEJOWIEJWOIEJIWJEWIEJIWEQQQQ",@"recommendCode":@""};
    //    //loginName=18643212316 password=
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/user/registNewUser?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
    //        NSLog(@"json = msg %@",json[@"msg"]);
    //    } failure:^(NSError *error) {
    //
    //    }];
    
    //    //首页轮播的接口
    NSDictionary *dic = @{@"adType":@"1"};
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/ad/getAdResource?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *jsonArray = json;
            
            NSMutableArray *marray = [[NSMutableArray alloc]init];
            NSMutableArray *imageArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dics in jsonArray) {
                JLShopModel *model = [JLShopModel initWithDictionary:dics];
                [marray addObject:model];
                [imageArray addObject:dics[@"image"]];
            }
            
            self.bannerArray = [marray copy];
            self.cycleScrollview.imageURLStringsGroup = imageArray;
            if ([LoginStatus sharedManager].status)
                [[CartManager sharedManager] getCartGoodCount];
        });
    } failure:^(NSError *error) {
    }];
    
    
    
    //    //推荐商品接口 //begin=0
    //    NSDictionary *dic1 = @{@"begin":@"0"};
    //    //https://123.56.192.182:8443/app/product/recommendGoods?
    //    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/recommendGoods?" parameters:dic1 isShowHUD:YES httpToolSuccess:^(id json) {
    //        NSArray *jsonArray = json;
    //        NSMutableArray *marray = [[NSMutableArray alloc]init];
    //        for (NSDictionary *dics in jsonArray) {
    //            JLGoodModel *model = [JLGoodModel initWithDictionary:dics];
    //            [marray addObject:model];
    //        }
    //        self.hotGoodsArray = [marray copy];
    //
    //            } failure:^(NSError *error) {
    //    }];
    
    //分类列表接口
    //    https://123.56.192.182:8443/app/product/listClass?arg0={"name":"","type":"1","id":"","level":"","firstSeplling":""}
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.mainView.y = 64;
    self.mainView.height = self.mainView.height - 64;//防止遮挡住导航栏
    [self.view addSubview:self.mainView];
    [self netWorkTest];
    self.topSearchView.layer.cornerRadius = 6;
    self.topSearchView.layer.borderColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1].CGColor;
    self.topSearchView.layer.borderWidth = 1;
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction:)];
    [self.topSearchView addGestureRecognizer:tap];
    [self getCollectionHight];
    [self loadCollectionView];
    //判断是否有选择过城市，有就加载之前的，没有就弹出选择器
    [self isSelectedCity];
}

-(void)loadCollectionView{
    UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical]; // 垂直滚动
    [layout setHeaderReferenceSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, 260)];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor colorWithRed:244/255.0 green:244/255.0 blue:247/255.0 alpha:1];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollsToTop = YES;
    {
        UIView *pview = self.mainView;
        UICollectionView *sview = self.collectionView;
        [pview addSubview:sview];
        
        [sview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.topView.mas_bottom);
            make.left.mas_equalTo(pview);
            make.width.mas_equalTo(pview.mas_width);
            make.height.mas_equalTo(pview.height - self.topView.height);
        }];
        
    }
    
    [_collectionView registerNib:[UINib nibWithNibName:@"JLShopCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:JLHomeCell];
    
    self.collectionView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [self.collectionView reloadData];
        [self.collectionView.mj_header endRefreshing];
//        [self.mainView removeFromSuperview];
//        [self viewDidLoad];
        
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    [self loadSrollView];
    [self loadJLTypeListView];
}

-(void)loadSrollView{
    CGFloat creenWidth = [UIScreen mainScreen].bounds.size.width;
    self.cycleScrollview = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, creenWidth, 125) delegate:self placeholderImage:[UIImage imageNamed:@"FYTXCategories_page_dot_press"]];
    
    _cycleScrollview.currentPageDotImage = [UIImage imageNamed:@"FYTXCategories_page_dot_press"];
    _cycleScrollview.autoScrollTimeInterval = 5.0f;
    _cycleScrollview.backgroundColor = [UIColor colorWithRed:0 green:139/255.0 blue:139/255.0 alpha:1];
    _cycleScrollview.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    [self.collectionView addSubview:_cycleScrollview];
    
    {
        SDCycleScrollView *sview = _cycleScrollview;
        UIView *pview = self.collectionView;
        [pview addSubview:sview];
        [sview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(pview);
            make.left.mas_equalTo(pview);
            make.width.mas_equalTo(creenWidth);
            make.height.mas_equalTo(140);
        }];
    }
}

-(void)loadJLTypeListView{
    self.typeListView = [[JLTypeListView alloc]init];
    
    UIView *sview = self.typeListView;
    UICollectionView *pview = self.collectionView;
    [pview addSubview:sview];
    [sview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pview);
        make.top.mas_equalTo(self.cycleScrollview.mas_bottom);
        make.width.mas_equalTo(pview);
        make.height.mas_equalTo(140);
    }];
    __weak typeof(self) weakSelf = self;
    self.typeListView.listBtnBlock = ^(NSInteger btnTag){
        MYLog(@"btnTag = %ld",btnTag);
        [weakSelf listViewBtnAction:btnTag];
        
    };
}



- (void)listViewBtnAction:(NSInteger )btnTag{
    if (btnTag != 7) {
        HomeListBtnClickYes;
        [self.tabBarController setSelectedIndex:2];

        QSCNavigationController *s = [self.tabBarController.viewControllers objectAtIndex:2];
        JLShopsViewController *q = s.viewControllers.lastObject;
        q.numRow = btnTag;
        q.isSelected = YES;
        
        
        
    }else{
        OtherListViewController *otherListVC = [[OtherListViewController alloc] init];
        [self.navigationController pushViewController:otherListVC animated:YES];
    }
    
}

- (void)isSelectedCity
{
    BOOL isSelectedCity = [[NSUserDefaults standardUserDefaults] objectForKey:@"SELECTEDCITY"] ? YES : NO;
    if (!isSelectedCity) {
        [self cityPicker:_cityPickerButton];
    }else{
        [_cityPickerButton setTitle:[[NSUserDefaults standardUserDefaults] objectForKey:@"SELECTEDCITY"] forState:UIControlStateNormal];
    }
}

- (void)searchAction:(UITapGestureRecognizer *)tap
{
    [self.navigationController pushViewController:[SearchController new] animated:NO];
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    JLShopModel *model = self.bannerArray[index];
    NSLog(@"---点击了第%@张图片", model);
//    NSString *strHTML = @"<p><img src=\"http://123.56.192.182/http_resource/image/ueditor/201610221477119211606038854.jpg\" title=\"201610221477119211606038854.jpg\" alt=\"劲酒.jpg\"/></p>";
//    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:webView];
//    
//    [webView loadHTMLString:strHTML baseURL:nil];
//        [[self.mainViewModel openBannerWith:index]execute:nil];

//    DetailsViewController *next = [[DetailsViewController alloc] init];
//    next.productIDStr = [NSString stringWithFormat:@"%lld",model.adId];
//    next.productIconStr = model.image;
//    [self.navigationController pushViewController:next animated:YES];
    
    ShopDetailController *next = [[ShopDetailController alloc] init];
    next.productIDStr = [NSString stringWithFormat:@"%d",model.adId];
    next.productIconStr = model.image;
    next.tabbarNum = 1;
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController pushViewController:next animated:YES];


}

- (void)getCollectionHight{
    
        NSDictionary *dic1 = @{@"begin":@"0"};
        [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/recommendGoods?" parameters:dic1 isShowHUD:YES httpToolSuccess:^(id json) {
            
                NSArray *jsonArray = json;
                NSMutableArray *marray = [[NSMutableArray alloc]init];
                for (NSDictionary *dics in jsonArray) {
                    JLGoodModel *model = [JLGoodModel initWithDictionary:dics];
                    [marray addObject:model];
                }
                self.hotGoodsArray = [marray copy];
            if (self.hotGoodsArray.count == 0) {
                self.collectionHight = 238;
            }else
                self.collectionHight = 270 + (self.view.frame.size.width*0.5 + 30)*self.hotGoodsArray.count/2;
            
                [self.collectionView reloadData];
            
        } failure:^(NSError *error) {
            
        }];
    
}

#pragma mark - <<<<<<<<<<<<<<<  ButtonMethed  >>>>>>>>>>>>>>>

- (IBAction)cityPicker:(UIButton *)sender
{
    JLCityController *ctrl = [[JLCityController alloc]init];
    [ctrl setDelegate:self];
    UINavigationController *na = [[UINavigationController alloc]initWithRootViewController:ctrl];
    [self presentViewController:na animated:YES completion:^{
    }];
}

#pragma mark ----------------- citydelegate

-(void)chooseCity:(NSString *)city{
    [_cityPickerButton setTitle:city forState:UIControlStateNormal];
    
    [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"SELECTEDCITY"];
}


#pragma mark - <<<<<<<<<<<<<<<  collectionViewDelegate  >>>>>>>>>>>>>>>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    JLShopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:JLHomeCell forIndexPath:indexPath];
    cell.tuiJianBlock = ^(JLGoodModel *goodModel){
        
        DetailsViewController * detail = [[DetailsViewController alloc] init];
        detail.productIDStr = goodModel.goodID;
        detail.productIconStr = goodImg;
    };
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    
    CGSize bsize = CGSizeMake(cellWidth, self.collectionHight);

    return bsize;
}

//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);//分别为上、左、下、右
}

//每个section中不同的行之间的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}



@end
