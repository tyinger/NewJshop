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

@property (nonatomic , strong) NSArray *arrAll;//总
@property (nonatomic , strong) NSArray *proviceArr;//省
@property (nonatomic , strong) NSArray *cityArr;//市
@property (nonatomic , strong) NSArray *townArr;//县区

@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (copy, nonatomic) NSMutableString *detailAddress; // 具体地址
@property (copy, nonatomic) NSString *areaStr;//所在区域
@end

@implementation AddressController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.addrId) {
        self.shouTextFiled.text = self.firstLabelText;
        self.phoneTextFiled.text = self.secondLabelText;
        self.addrTextFiled.text = self.fourthLabelText;
        UIButton *tempBtn = [self.view viewWithTag:205];
        [tempBtn setTitle:self.thirdLabelText forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.areaStr = self.isModefy ? self.areaId : nil;
    [self calculateFirstData];
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

- (NSMutableString *)detailAddress{
    if (!_detailAddress) {
        _detailAddress = [[NSMutableString alloc] init];
    }
    return _detailAddress;
}

- (void)loadFirstData{

    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"address1" ofType:@"json"];
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

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData
{
    // 拿出省的数组
    [self loadFirstData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.arrAll[self.index1] allValues].firstObject) {
        
        NSString *name1 = cityName.allKeys.firstObject;
        [cityNameArr addObject:name1];
    }
    // 组装对应省下面的市
    self.cityArr = cityNameArr;
    //                             index1对应省的字典         市的数组 index2市的字典   对应县的数组
    self.townArr = [[self.arrAll[self.index1] allValues][0][self.index2] allValues][0];
}


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
//        _provinceTableView.backgroundColor = [UIColor redColor];
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
//        _cityTableView.backgroundColor = [UIColor magentaColor];
        _cityTableView.dataSource = self;
        _cityTableView.delegate = self;
        [self.view addSubview:_cityTableView];
        //隐藏多余cell
        self.cityTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _cityTableView;
}

- (UITableView *)townTableView
{
    if (!_townTableView) {
        _townTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, 120, kDeviceWidth/3, 0) style:UITableViewStylePlain];
//        _townTableView.backgroundColor = [UIColor orangeColor];
        _townTableView.dataSource = self;
        _townTableView.delegate = self;
        [self.view addSubview:_townTableView];
        //隐藏多余cell
        self.townTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
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
    searchAddress.tag = 205;
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
        self.detailAddress = nil;
    }
    [UIView commitAnimations];
}


//保存地址
- (void)saveAction:(UIButton *)btn{
    
    UIButton *tempBtn = [self.view viewWithTag:205];
    if([self.shouTextFiled.text isEqualToString:@""]){
        [FYTXHub toast:@"请填写收货人"];
        return;
    }
    if (![self isMobileNumber:self.phoneTextFiled.text]) {
        [FYTXHub toast:@"请正确填写联系方式"];
        return;
    }
    if ([tempBtn.titleLabel.text isEqualToString:@"请选择搜索区域"]) {
        [FYTXHub toast:@"请选择区域"];
        return;
    }
    if ([self.addrTextFiled.text isEqualToString:@""]) {
        [FYTXHub toast:@"请填写详细地址"];
        return;
    }
    
    
    NSDictionary *dic = self.addrId ? @{@"isDefault":self.isDefualtFlag,
                                        @"areaAdds":tempBtn.titleLabel.text,
                                        @"detailedAdd":self.addrTextFiled.text,
                                        @"userId":[LoginStatus sharedManager].idStr,
                                        @"name":self.shouTextFiled.text,
                                        @"phone":self.phoneTextFiled.text,
                                        @"area.id":self.areaStr,
                                        @"area.name":@"",
                                        @"id":@(self.addrId)}
    :
  @{@"isDefault":@"0",
    @"areaAdds":tempBtn.titleLabel.text,
    @"detailedAdd":self.addrTextFiled.text,
    @"userId":[LoginStatus sharedManager].idStr,
    @"name":self.shouTextFiled.text,
    @"phone":self.phoneTextFiled.text,
    @"area.id":self.areaStr,
    @"area.name":@""};
    
    NSString *pathStr = self.addrId ? @"https://123.56.192.182:8443/app/address/updateUserAddress?" : @"https://123.56.192.182:8443/app/address/saveUserAddress?";
    
    
    [QSCHttpTool post:pathStr parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
        MYLog(@"json = %@",json);
        [self.navigationController popViewControllerAnimated:YES];
    } failure:^(NSError *error) {
        MYLog(@"error  = %@",error);
    }];

}

#pragma mark - UITableViewDataSource AND UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _provinceTableView) {
        return self.proviceArr.count;
    }else if(tableView == _cityTableView){
        return self.cityArr.count;
    }else if(tableView == _townTableView){
        return self.townArr.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.backgroundColor = [UIColor orangeColor];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    if (tableView == _provinceTableView) {
        cell.textLabel.text = self.proviceArr[indexPath.row];
    }else if(tableView == _cityTableView){
        cell.textLabel.text = self.cityArr[indexPath.row];
    }else if(tableView == _townTableView){
        cell.textLabel.text = [self.townArr[indexPath.row] substringFromIndex:9];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _provinceTableView) {
        self.index1 = indexPath.row;
//        self.index2 = 0;
//        self.index3 = 0;
//        self.townArr = nil;
        [self calculateFirstData];
        [self.cityTableView reloadData];
        [self.townTableView reloadData];
        
    }else if(tableView == _cityTableView){
        self.index2 = indexPath.row;
        self.index3 = 0;
        [self calculateFirstData];
        [self.townTableView reloadData];
        
    }else if(tableView == _townTableView){
        self.index3 = indexPath.row;
        if (self.index1 == 0) {
            [self.provinceTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        if (self.index2 == 0){
            [self.cityTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }
        [self.detailAddress appendString:self.proviceArr[self.index1]];
        [self.detailAddress appendString:@"-"];
        [self.detailAddress appendString:self.cityArr[self.index2]];
        [self.detailAddress appendString:@"-"];
        [self.detailAddress appendString:[self.townArr[self.index3] substringFromIndex:9]];
        UIButton *tempBtn = [self.view viewWithTag:205];
        [tempBtn setTitle:self.detailAddress forState:UIControlStateNormal];
        self.areaStr = [self.townArr[self.index3] substringToIndex:9];
        [self chooseAddress:tempBtn];
    }
}

-(void)viewDidLayoutSubviews
{
    if ([self.provinceTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.provinceTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.provinceTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.provinceTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.cityTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.cityTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.cityTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.cityTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.townTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.townTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.townTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.townTableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


// 正则判断手机号码地址格式
- (BOOL)isMobileNumber:(NSString *)mobileNum {
    
    //    电信号段:133/153/180/181/189/177
    //    联通号段:130/131/132/155/156/185/186/145/176
    //    移动号段:134/135/136/137/138/139/150/151/152/157/158/159/182/183/184/187/188/147/178
    //    虚拟运营商:170
    
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
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
