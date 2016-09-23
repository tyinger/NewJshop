//
//  ShangjiaViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShangjiaViewController.h"
#import "AddressController.h"

//按钮TAG范围：100-200；
//textView的tag范围在：200-300
//label 的tag范围在：300-400

static const CGFloat kBottomHeight = 60;
static const CGFloat kquyustartHeight = 44*4 + 1;
@interface ShangjiaViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/** 经营范围tableView */
@property (nonatomic , strong) UITableView *managementTableView;
/** 省份tableView */
@property (nonatomic , strong) UITableView *provinceTableView;
/** 市区tableVIew */
@property (nonatomic , strong) UITableView *cityTableView;
/** 县城tableView */
@property (nonatomic , strong) UITableView *townTableView;
/** 列表 */
@property (nonatomic , strong) UITableView *addressTableView;
/** 底部添加按钮 */
@property (nonatomic , strong) UIButton *addressBtn;
/** 底部白色背景 */
@property (nonatomic , strong) UIView *whiteBackGroundView;
/** footVIew */
@property (nonatomic , strong) UIView *myFootView;

/** 辨别哪个上传图片 */
@property (nonatomic , assign) NSInteger btnTag;//记录哪个按钮选择照片
/** 保存零售业 */
@property (nonatomic , strong) NSMutableArray *jingyingArr;

@property (nonatomic , assign) CGFloat placeFloat;//tableview滚动后的差值

@property (nonatomic , strong) NSArray *arrAll;//总
@property (nonatomic , strong) NSArray *proviceArr;//省
@property (nonatomic , strong) NSArray *cityArr;//市
@property (nonatomic , strong) NSArray *townArr;//县区

@property (nonatomic,assign) NSInteger index1; // 省下标
@property (nonatomic,assign) NSInteger index2; // 市下标
@property (nonatomic,assign) NSInteger index3; // 区下标
@property (copy, nonatomic) NSMutableString *detailAddress; // 具体地址

@property (copy, nonatomic) NSString *businessLicenceStr; // 返回的营业执照链接
@property (copy, nonatomic) NSString *IdentityCard1; // 返回的身份证正面图片链接
@property (copy, nonatomic) NSString *IdentityCard2; // 返回的身份证反面图片链接
@end

@implementation ShangjiaViewController
{
    NSTimer *_timer;
}
- (void)viewDidAppear:(BOOL)animated{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.btnTag = 0;
    self.placeFloat = 0.0;
    // Do any additional setup after loading the view.
//    [self whiteBackGroundView];
    [self calculateFirstData];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera | UIImagePickerControllerSourceTypePhotoLibrary;
    _jingyingArr = [[NSMutableArray alloc] init];
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/appShopController/ProductStatus?" parameters:nil isShowHUD:YES httpToolSuccess:^(id json) {
        [json enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_jingyingArr addObject:obj[@"name"]];
        }];
        [_addressTableView reloadData];
    } failure:^(NSError *error) {
//        [self addressTableView];
    }];
    
    [self addressTableView];
    
}

- (UIView *)whiteBackGroundView
{
    if (!_whiteBackGroundView) {

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomHeight - 64, kDeviceWidth, kBottomHeight)];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"+ 新增地址" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = kCTTextAlignmentCenter;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
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

- (UITableView *)addressTableView
{
    if (!_addressTableView) {
        
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.height - 64) style:UITableViewStylePlain];
        
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        _addressTableView.bounces = NO;
        _addressTableView.tableFooterView = self.myFootView;
        [self.view addSubview:_addressTableView];
    }
    return _addressTableView;
}

- (UITableView *)managementTableView
{
    if (!_managementTableView) {
        UIButton *btn = [self.view viewWithTag:109];
        _managementTableView = [[UITableView alloc] initWithFrame:CGRectMake(btn.x, kquyustartHeight-44, btn.width, 0) style:UITableViewStylePlain];
        
        _managementTableView.dataSource = self;
        _managementTableView.delegate = self;
        _managementTableView.bounces = NO;
        [self.view addSubview:_managementTableView];
        [self.view bringSubviewToFront:_managementTableView];
    }
    return _managementTableView;
}


- (UITableView *)provinceTableView
{
    if (!_provinceTableView) {
        _provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kquyustartHeight, kDeviceWidth/3, 0) style:UITableViewStylePlain];
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
        _cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/3, kquyustartHeight, kDeviceWidth/3, 0) style:UITableViewStylePlain];
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
        _townTableView = [[UITableView alloc] initWithFrame:CGRectMake(kDeviceWidth/3*2, kquyustartHeight, kDeviceWidth/3, 0) style:UITableViewStylePlain];
        //        _townTableView.backgroundColor = [UIColor orangeColor];
        _townTableView.dataSource = self;
        _townTableView.delegate = self;
        [self.view addSubview:_townTableView];
        //隐藏多余cell
        self.townTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _townTableView;
}

-(UIView *)myFootView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
//    view.backgroundColor = [UIColor yellowColor];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(0, 0, 40, 40);
    [agreeBtn setImage:[UIImage imageNamed:@"xn_circle_normal"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"xn_circle_select"] forState:UIControlStateSelected];
    agreeBtn.tag = 102;
    agreeBtn.selected = YES;
    [agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kDeviceWidth, 40)];
    label.text = @"同意用啥商家注册协议";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [label setAttributedText:str];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PushToAgreeDelegate:)];
    [label addGestureRecognizer:tapGes];
    
    //底部分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kDeviceWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(10, 45, kDeviceWidth - 20, 30);
    commitButton.tag = 101;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    commitButton.enabled = NO;
    commitButton.layer.masksToBounds = YES;
    commitButton.layer.cornerRadius = 5;
    commitButton.backgroundColor = [UIColor lightGrayColor];
    [commitButton addTarget:self action:@selector(commitAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //添加到footView
    [view addSubview:label];
    [view addSubview:agreeBtn];
    [view addSubview:lineView];
    [view addSubview:commitButton];
    return view;
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

#pragma mark -----tableView Delegate And Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _provinceTableView) {
        return self.proviceArr.count;
    }else if(tableView == _cityTableView){
        return self.cityArr.count;
    }else if(tableView == _townTableView){
        return self.townArr.count;
    }else if (tableView == _managementTableView){
        return self.jingyingArr.count;
    }
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (tableView == _addressTableView) {
//    if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
        switch (indexPath.row) {
            case 0:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  为必填项";
                label.textColor = [UIColor redColor];
                [cell addSubview:label];
            }
                break;
            case 1:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  商户名称";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.tag = 201;
                
                [cell addSubview:filed];
                [cell addSubview:label];
            }
                break;
            case 2:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  经营范围";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(CGRectGetMaxX(label.frame), 0, self.view.width - label.width, label.height);
                _jingyingArr.count == 0 ? [btn setTitle:@"" forState:UIControlStateNormal]:[btn setTitle:_jingyingArr[0] forState:UIControlStateNormal];
                btn.tag = 109;
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                btn.titleLabel.textAlignment = NSTextAlignmentCenter;
                [btn addTarget:self action:@selector(managermentAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell addSubview:btn];
                [cell addSubview:label];
            }
                break;
            case 3:
            {
                UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label3.text = @"*  所在城市";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label3.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label3 setAttributedText:str];
                
                UIButton *searchAddress = [UIButton buttonWithType:UIButtonTypeCustom];
                searchAddress.tag = 110;
                [searchAddress setTitle:@"请选择搜索区域" forState:UIControlStateNormal];
                [searchAddress setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                searchAddress.titleLabel.font = [UIFont systemFontOfSize:15];
                searchAddress.titleLabel.textAlignment = NSTextAlignmentCenter;
                searchAddress.frame = CGRectMake(CGRectGetMaxX(label3.frame), 0, kDeviceWidth - CGRectGetWidth(label3.frame), CGRectGetHeight(label3.frame));
                [searchAddress addTarget:self action:@selector(chooseAddress:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell addSubview:searchAddress];
                [cell addSubview:label3];
            }
                break;
            case 4:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  详细地址";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.tag = 202;
                
                [cell addSubview:filed];
                
                [cell addSubview:label];
            }
                break;
            case 5:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  联系人";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.tag = 203;
                
                [cell addSubview:filed];
                
                [cell addSubview:label];
            }
                break;
            case 6:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  联系电话";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.tag = 204;
                
                [cell addSubview:filed];
                
                [cell addSubview:label];
            }
                break;
            case 7:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
                label.text = @"*  营业执照";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.editable = NO;
                filed.tag = 205;
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
                btn.tag = 103;
                [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell addSubview:btn];
                [cell addSubview:filed];
                [cell addSubview:label];
            }
                break;
            case 8:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
                label.text = @"*  身份证正面照片";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.editable = NO;
                filed.tag = 206;
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
                btn.tag = 104;
                [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell addSubview:btn];
                [cell addSubview:filed];
                [cell addSubview:label];
            }
                break;
            case 9:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
                label.text = @"*  身份证反面照片";
                NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
                [label setAttributedText:str];
                
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.editable = NO;
                filed.tag = 207;
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
                btn.tag = 105;
                [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
                
                [cell addSubview:btn];
                [cell addSubview:filed];
                [cell addSubview:label];
            }
                break;
            case 10:
            {
                UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
                label.text = @"   我在其他平台商铺";
                label.font = [UIFont systemFontOfSize:16];
                UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
                filed.font = [UIFont systemFontOfSize:17];
                filed.delegate = self;
                filed.tag = 208;
                
                UILabel *placeLabel = [[UILabel alloc] initWithFrame:filed.frame];
                placeLabel.x = 0;
                placeLabel.y = -1;
                placeLabel.text = @" 填写店铺连接";
                placeLabel.textColor = [UIColor lightGrayColor];
                placeLabel.tag = 301;
                [filed addSubview:placeLabel];
                
                [cell addSubview:filed];
                [cell addSubview:label];
            }
                break;
            
                
            default:
                break;
        }
    }else{
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.textLabel.font = [UIFont systemFontOfSize:15];
        }
        if (tableView == _provinceTableView) {
            cell.textLabel.text = self.proviceArr[indexPath.row];
        }else if(tableView == _cityTableView){
            cell.textLabel.text = self.cityArr[indexPath.row];
        }else if(tableView == _townTableView){
            cell.textLabel.text = self.townArr[indexPath.row];
        }else if(tableView == _managementTableView){
            cell.backgroundColor = [UIColor lightGrayColor];
            cell.textLabel.text = self.jingyingArr[indexPath.row];
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _provinceTableView) {
        self.index1 = indexPath.row;
        self.index2 = 0;
        //        self.index3 = 0;
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
        [self.detailAddress appendString:self.townArr[self.index3]];
        UIButton *tempBtn = [self.view viewWithTag:110];
        [tempBtn setTitle:self.detailAddress forState:UIControlStateNormal];
        [self chooseAddress:tempBtn];
    }else if (tableView == _managementTableView){
        UIButton *tempBtn =[self.view viewWithTag:109];
        [tempBtn setTitle:_jingyingArr[indexPath.row] forState:UIControlStateNormal];
        [self managermentAction:tempBtn];
        [self.managementTableView removeFromSuperview];
        self.managementTableView = nil;
    }
}
#pragma mark -- button Action
- (void)addAddressAction:(UIButton *)btn
{
    Class class = NSClassFromString(@"AddressController");
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = @"新建收货地址";
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)agreeAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)PushToAgreeDelegate:(UITapGestureRecognizer *)tap{
    MYLog(@"我就是不跳这么滴");
}

- (void)photoAction:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传照片" message:@"" preferredStyle:0];
    self.btnTag = btn.tag;
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.cameraOverlayView.userInteractionEnabled = NO;
        _imagePickerController.showsCameraControls = YES;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        
        [alert addAction:action2];
        [alert addAction:action3];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (void)chooseAddress:(UIButton *)button{
    
    button.selected = !button.selected;
    _addressTableView.scrollEnabled = !button.selected;
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    if (button.selected) {
        
        //改变它的frame的x,y的值
        self.provinceTableView.frame = CGRectMake(0, kquyustartHeight - self.placeFloat, kDeviceWidth/3, _addressTableView.height - kquyustartHeight + self.placeFloat);
        
        self.cityTableView.frame = CGRectMake(kDeviceWidth/3, kquyustartHeight - self.placeFloat, kDeviceWidth/3, _addressTableView.height - kquyustartHeight + self.placeFloat);
        
        self.townTableView.frame = CGRectMake(kDeviceWidth/3*2, kquyustartHeight - self.placeFloat, kDeviceWidth/3, _addressTableView.height - kquyustartHeight + self.placeFloat);
        //        tempLabel.frame=CGRectMake(0,300 + 0.5, 100,40);
    }else{
        
        self.provinceTableView.frame = CGRectMake(0, kquyustartHeight - self.placeFloat, kDeviceWidth/3, 0);
        
        self.cityTableView.frame = CGRectMake(kDeviceWidth/3, kquyustartHeight - self.placeFloat, kDeviceWidth/3, 0);
        
        self.townTableView.frame = CGRectMake(kDeviceWidth/3*2, kquyustartHeight - self.placeFloat, kDeviceWidth/3, 0);
        
        //        tempLabel.frame=CGRectMake(0,120.5, 100,40);
        self.detailAddress = nil;
    }
    [UIView commitAnimations];
}

- (void)managermentAction:(UIButton *)button{
    button.selected = !button.selected;
    _addressTableView.scrollEnabled = !button.selected;
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.2];
    [UIView setAnimationDelegate:self];
    if (button.selected) {
        //改变它的frame的x,y的值
        self.managementTableView.frame = CGRectMake(button.x, kquyustartHeight - self.placeFloat-44, button.width, 44*self.jingyingArr.count);

    }else{
        
        self.managementTableView.frame = CGRectMake(button.x, kquyustartHeight-44 - self.placeFloat, button.width, 0);
        
        self.detailAddress = nil;
    }
    [UIView commitAnimations];

}
/*
    Integer id;			//主键
	private Integer userId;		//用户id
	private String shopName;	//商铺名称
	private Integer shopClass;	//类型
	private String business;	//经营范围
	private String city;		//所在城市
	private String address;		//详细地址
	private String contact;		//联系人
	private String phone;		//联系方式
	private String businessLicence;		//营业执照
	private String shopUrl;				//店铺在其他平台连接
	private Short  status;		//处理状态
	private String IdentityCard1 ; //身份证正面图片   （客户要求加上2016-02-17 qiuwei）
	private String IdentityCard2; // 身份证反面图片
 */
- (void)commitAction:(UIButton *)button{
    UITextView *textView1 = [self.view viewWithTag:201];//商户名称
    UITextView *textView2 = [self.view viewWithTag:202];//详细地址
    UITextView *textView3 = [self.view viewWithTag:203];//联系人
    UITextView *textView4 = [self.view viewWithTag:204];//联系电话
//    UITextView *textView5 = [self.view viewWithTag:205];//营业执照
//    UITextView *textView6 = [self.view viewWithTag:206];//身份证正面
//    UITextView *textView7 = [self.view viewWithTag:207];//身份证反面

    UIButton *btn1 = [self.view viewWithTag:109];//经营范围
    UIButton *btn2 = [self.view viewWithTag:110];//经营区域
    
    if (![self isMobileNumber:textView4.text]) {
        [FYTXHub toast:@"请正确填写联系电话"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
        return;
    }
    
//    NSDictionary *dic = @{@"id":@"",
//                          @"userId":[LoginStatus sharedManager].idStr,
//                          @"shopName":textView1.text,
//                          @"shopClass":@"",
//                          @"business":btn1.titleLabel.text,
//                          @"city":btn2.titleLabel.text,
//                          @"address":textView2.text,
//                          @"contact":textView3.text,
//                          @"phone":textView4.text,
//                          @"businessLicence":self.businessLicenceStr,
//                          @"shopUrl":@"",
//                          @"status":@"0",
//                          @"IdentityCard1":self.IdentityCard1,
//                          @"IdentityCard2":self.IdentityCard2};
    
    NSString *parameterStr = [NSString stringWithFormat:@"{\"userId\":\"%@\",\"shopName\":\"%@\",\"business\":\"%@\",\"city\":\"%@\",\"address\":\"%@\",\"contact\":\"%@\",\"phone\":\"%@\",\"businessLicence\":\"%@\",\"IdentityCard1\":\"%@\",\"IdentityCard2\":\"%@\"}",[LoginStatus sharedManager].idStr,textView1.text,btn1.titleLabel.text,btn2.titleLabel.text,textView2.text,textView3.text,textView4.text,self.businessLicenceStr,self.IdentityCard1,self.IdentityCard2];
    NSDictionary *dic = @{@"arg0":parameterStr};
    
    [QSCHttpTool post:@"https://123.56.192.182:8443/app/appShopController/DoAddJoinningShop?" parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
//        [json[@"status"] integerValue] == 0
        [FYTXHub toast:json[@"msg"]];
        MYLog(@"上传商家json = %@",json);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
    } failure:^(NSError *error) {
        [FYTXHub toast:@"提交失败"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [FYTXHub dismiss];
        });
         MYLog(@"上传商家error = %@",error);
    }];
}

- (void)timer:(NSTimer *)timer{
    UIButton *btn1 = [self.view viewWithTag:101];//提交按钮
    UIButton *btn2 = [self.view viewWithTag:102];//协议同意按钮
    UIButton *btn3 = [self.view viewWithTag:110];//经营区域
    
    UITextView *textView1 = [self.view viewWithTag:201];//商户名称
    UITextView *textView2 = [self.view viewWithTag:202];//详细地址
    UITextView *textView3 = [self.view viewWithTag:203];//联系人
    UITextView *textView4 = [self.view viewWithTag:204];//联系电话
    UITextView *textView5 = [self.view viewWithTag:205];//营业执照
    UITextView *textView6 = [self.view viewWithTag:206];//身份证正面
    UITextView *textView7 = [self.view viewWithTag:207];//身份证反面
//    UITextView *textView8 = [self.view viewWithTag:208];
    
    if (![textView1.text isEqualToString:@""] && ![textView2.text isEqualToString:@""] && ![textView3.text isEqualToString:@""] && ![textView4.text isEqualToString:@""] && ![textView5.text isEqualToString:@""] && ![textView6.text isEqualToString:@""] && ![textView7.text isEqualToString:@""] && btn2.selected && ![btn3.titleLabel.text isEqualToString:@"请选择搜索区域"]) {
        btn1.enabled = YES;
        [btn1 setTitle:@"提交" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor redColor];
    }else{
        btn1.enabled = NO;
        [btn1 setTitle:@"提交" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor lightGrayColor];
    }
}


#pragma mark - TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    MYLog(@"开始了");
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    MYLog(@"结束了");
}

- (void)textViewDidChange:(UITextView *)textView{
    if(textView.tag == 208 && ![textView.text isEqualToString:@""]){
        UILabel *label = [self.view viewWithTag:301];
        label.text = @"";
    }else{
        UILabel *label = [self.view viewWithTag:301];
        label.text = @" 填写店铺连接";
    }
}


/**
 *  选择完照片后调用的方法
 *
 *
 *  @param info   所有相片的信息都在这个字典
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //从字典key获取image的地址
    UIImage *image = [self imageCompressForWidth:info[UIImagePickerControllerOriginalImage] targetWidth:400];
    
    NSData *_data = UIImageJPEGRepresentation(image, 0.01);
    NSString *_encodedImageStr = [_data base64Encoding];
    
    [FYTXHub progress:@"正在上传..."];
    NSDictionary *dic = @{@"imgFile":_encodedImageStr,@"userId":[LoginStatus sharedManager].idStr};
    NSString *str = self.btnTag > 103 ? @"https://123.56.192.182:8443/app/user/updateIdentityCardImg" : @"https://123.56.192.182:8443/app/user/updateLicenceImg";
    
    [QSCHttpTool uploadImagePath:str params:dic kHeadimgName:nil image:nil success:^(id JSON) {
        MYLog(@"照片json = %@",JSON);
        UITextView *textView = [self.view viewWithTag:self.btnTag + 102];
        [FYTXHub dismiss];
        switch (self.btnTag) {
            case 103:
            {
                self.businessLicenceStr = JSON[@"url"];
            }
                break;
            case 104:
            {
                self.IdentityCard1 = JSON[@"url"];
            }
                break;
            case 105:
            {
                self.IdentityCard2 = JSON[@"url"];
            }
                break;
            default:
                break;
        }
        textView.text = @"已上传";
    } failure:^(NSError *error) {
        MYLog(@"照片error = %@",error);
        [FYTXHub toast:@"上传失败"];
    }];
    MYLog(@"选完照片了%lu",(unsigned long)_data.length);
    
    
}

-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//压缩图像
+(NSData *)imageData:(UIImage *)myimage
{
    NSData *data=UIImageJPEGRepresentation(myimage, 1.0);
    if (data.length>1000*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data=UIImageJPEGRepresentation(myimage, 0.1);
        }else if (data.length>512*1024) {//0.5M-1M
            data=UIImageJPEGRepresentation(myimage, 0.5);
        }else if (data.length>200*1024) {//0.25M-0.5M
            data=UIImageJPEGRepresentation(myimage, 0.9);
        }
    }
    return data;
}

- (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(image, compression);
        image = [UIImage imageWithData:imageData];
    }
    
//    UIImage *compressedImage = [UIImage imageWithData:imageData];
    return imageData;
}

//用来调节tableview滚动过程中其他tableview的位置
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView != _addressTableView) return;
    self.placeFloat = scrollView.mj_offsetY;
    self.provinceTableView.frame = CGRectMake(0, kquyustartHeight - self.placeFloat, kDeviceWidth/3, 0);
    
    self.cityTableView.frame = CGRectMake(kDeviceWidth/3, kquyustartHeight - self.placeFloat, kDeviceWidth/3, 0);
    
    self.townTableView.frame = CGRectMake(kDeviceWidth/3*2, kquyustartHeight - self.placeFloat, kDeviceWidth/3, 0);
}

- (NSMutableString *)detailAddress{
    if (!_detailAddress) {
        _detailAddress = [[NSMutableString alloc] init];
    }
    return _detailAddress;
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
