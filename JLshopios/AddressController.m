//
//  AddressController.m
//  JLshopios
//
//  Created by 陈霖 on 16/9/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "AddressController.h"
#import "AddressView.h"


static const CGFloat kBottomHeight = 60;
#define LINECOLOR [UIColor grayColor]
@interface AddressController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

/** 底部添加按钮 */
@property (nonatomic , strong) UIButton *addressBtn;
/** 底部白色背景 */
@property (nonatomic , strong) UIView *whiteBackGroundView;

/** 省份tableView */
@property (nonatomic , strong) UITableView *provinceTableView;
/** 市区tableVIew */
@property (nonatomic , strong) UITableView *cityTableView;
/** 县城tableView */
@property (nonatomic , strong) UITableView *townTableView;

/** 收货人textFiled */
@property (nonatomic , strong) UITextField *shouTextFiled;
/** 手机textFilled */
@property (nonatomic , strong) UITextField *phoneTextFiled;
/** 地址textFiled */
@property (nonatomic , strong) UITextField *addrTextFiled;

@property (nonatomic , strong) NSArray *arrAll;
@property (nonatomic , strong) NSArray *proviceArr;
@property (nonatomic , strong) NSArray *cityArr;
@property (nonatomic , strong) NSArray *townArr;
@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadFirstData];
    [self whiteBackGroundView];
    [self createUI];
    
}

- (NSArray *)arrAll{
    if (!_arrAll) {
        _arrAll = [[NSArray alloc] init];
    }
    return _arrAll;
}

- (NSArray *)proviceArr{
    if (!_proviceArr) {
        _proviceArr = [[NSArray alloc] init];
    }
    return _proviceArr;
}

- (NSArray *)cityArr{
    if (!_cityArr) {
        _cityArr = [[NSArray alloc] init];
    }
    return _cityArr;
}

- (NSArray *)townArr{
    if (!_townArr) {
        _townArr = [[NSArray alloc] init];
    }
    return _townArr;
}

- (void)loadFirstData{

    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"address" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:jsonPath usedEncoding:nil error:nil];
    self.arrAll = [jsonStr JSONObject];
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.arrAll)
    {
        NSString *name = dict.allKeys.firstObject;
        [firstName addObject:name];
    }
    // 第一层是省份 分解出整个省份数组
    self.proviceArr = firstName;
}

//// 根据传进来的下标数组计算对应的三个数组
//- (void)calculateFirstData
//{
//    // 拿出省的数组
//    [self loadFirstData];
//    
//    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
//    // 根据省的index1，默认是0，拿出对应省下面的市
//    for (NSDictionary *cityName in [self.arrAll[self.index1] allValues].firstObject) {
//        
//        NSString *name1 = cityName.allKeys.firstObject;
//        [cityNameArr addObject:name1];
//    }
//    // 组装对应省下面的市
//    self.cityArr = cityNameArr;
//    //                             index1对应省的字典         市的数组 index2市的字典   对应县的数组
//    self.districtArr = [[self.arrAll[self.index1] allValues][0][self.index2] allValues][0];
//}


- (UIView *)whiteBackGroundView
{
    if (!_whiteBackGroundView) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomHeight - 64, kDeviceWidth, kBottomHeight)];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = kCTTextAlignmentCenter;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(-10);
            make.left.equalTo(view).offset(20);
            make.right.equalTo(view).offset(-20);
            make.top.equalTo(view).offset(10);
        }];
        self.addressBtn = button;
        self.whiteBackGroundView = view;
        
    }
    return _whiteBackGroundView;
}

- (UITableView *)provinceTableView
{
    if (!_provinceTableView) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 120, kDeviceWidth/3, 0) style:UITableViewStylePlain];
        _provinceTableView.backgroundColor = [UIColor redColor];
        _provinceTableView.dataSource = self;
        _provinceTableView.delegate = self;
        [self.view addSubview:_provinceTableView];
    }
    return _provinceTableView;
}

- (UITableView *)cityTableView
{
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/3, 120, kDeviceWidth/3, 0) style:UITableViewStylePlain];
        _cityTableView.backgroundColor = [UIColor magentaColor];
        _cityTableView.dataSource = self;
        _cityTableView.delegate = self;
        [self.view addSubview:_cityTableView];
    }
    return _cityTableView;
}

- (UITableView *)townTableView
{
    if (!_townTableView) {
        _townTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, 120, kDeviceWidth/3, 0) style:UITableViewStylePlain];
        _townTableView.backgroundColor = [UIColor orangeColor];
        _townTableView.dataSource = self;
        _townTableView.delegate = self;
        [self.view addSubview:_townTableView];
    }
    return _townTableView;
}

- (void)createUI
{
    
    [self createShouHuoRen];
    [self createPhoneNumber];
    [self createAddress];
    [self createDetailAddress];

}

- (void)createShouHuoRen{
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView1.backgroundColor = LINECOLOR;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5, 100, 40)];
    label1.text = @"收货人：";
    label1.textAlignment = NSTextAlignmentCenter;
    [label1 addSubview:lineView1];
    
    self.shouTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(label1.width, label1.y, kDeviceWidth - label1.width, label1.height)];
    self.shouTextFiled.delegate = self;
    [self.view addSubview:self.shouTextFiled];
    
    [self.view addSubview:label1];
    
    
}

- (void)createPhoneNumber{
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView2.backgroundColor = LINECOLOR;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5 + 40, 100, 40)];
    label2.text = @"手机号码：";
    label2.textAlignment = NSTextAlignmentCenter;
    [label2 addSubview:lineView2];
    
    self.phoneTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(label2.width, label2.y, kDeviceWidth - label2.width, label2.height)];
    self.phoneTextFiled.delegate = self;
    [self.view addSubview:self.phoneTextFiled];
    
    [self.view addSubview:label2];
}

- (void)createAddress{
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView3.backgroundColor = LINECOLOR;
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5 + 80, 100, 40)];
    label3.text = @"所在地区：";
    label3.textAlignment = NSTextAlignmentCenter;
    [label3 addSubview:lineView3];
    [self.view addSubview:label3];
    
    UIButton *searchAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchAddress setTitle:@"请选择搜索区域" forState:UIControlStateNormal];
    [searchAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchAddress.titleLabel.font = [UIFont systemFontOfSize:15];
    searchAddress.titleLabel.textAlignment = NSTextAlignmentCenter;
    searchAddress.frame = CGRectMake(CGRectGetMaxX(label3.frame), CGRectGetMinY(label3.frame), kDeviceWidth - CGRectGetWidth(label3.frame), CGRectGetHeight(label3.frame));
    [searchAddress addTarget:self action:@selector(chooseAddress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:searchAddress];
}

- (void)createDetailAddress{
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 1)];
    lineView4.backgroundColor = LINECOLOR;
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0.5 + 120, 100, 40)];
    label4.text = @"详细地址：";
    label4.textAlignment = NSTextAlignmentCenter;
    label4.tag = 100;
    [label4 addSubview:lineView4];
    
    self.addrTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(label4.width, label4.y, kDeviceWidth - label4.width, label4.height)];
    self.addrTextFiled.delegate = self;
    [self.view addSubview:self.addrTextFiled];
    [self.view addSubview:label4];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0.5 + 40, kDeviceWidth, 1)];
    lineView5.backgroundColor = LINECOLOR;
    [label4 addSubview:lineView5];
}


#pragma mark - ButtonAction


- (void)chooseAddress:(UIButton *)button{
    
    button.selected = !button.selected;
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    UILabel *tempLabel = [self.view viewWithTag:100];
    if (button.selected) {

        //改变它的frame的x,y的值
        self.provinceTableView.frame = CGRectMake(0, 120.5, kDeviceWidth/3, self.view.height - tempLabel.y);
        self.cityTableView.frame = CGRectMake(kDeviceWidth/3, 120.5, kDeviceWidth/3, self.view.height - tempLabel.y);
        self.townTableView.frame = CGRectMake(kDeviceWidth/3*2, 120.5, kDeviceWidth/3, self.view.height - tempLabel.y);
//        tempLabel.frame=CGRectMake(0,300 + 0.5, 100,40);
    }else{
        
        self.provinceTableView.frame = CGRectMake(0, 120.5, kDeviceWidth/3, 0);
        self.cityTableView.frame = CGRectMake(kDeviceWidth/3, 120.5, kDeviceWidth/3, 0);
        self.townTableView.frame = CGRectMake(kDeviceWidth/3*2, 120.5, kDeviceWidth/3, 0);
//        tempLabel.frame=CGRectMake(0,120.5, 100,40);
    }
    [UIView commitAnimations];
}


//保存地址
- (void)saveAction:(UIButton *)btn{
    
}

#pragma mark - UITableViewDataSource AND UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _provinceTableView) {
        return self.proviceArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.backgroundColor = [UIColor orangeColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    cell.textLabel.text = self.proviceArr[indexPath.row];
    
    return cell;
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
