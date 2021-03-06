//
//  ShouhoudizhiViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShouhoudizhiViewController.h"
#import "ShouHuoTableViewCell.h"
#import "AddressController.h"
#import "ShouHuoModel.h"

static const CGFloat kBottomHeight = 60;
@interface ShouhoudizhiViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

/** 列表 */
@property (nonatomic , strong) UITableView *addressTableView;
/** 底部添加按钮 */
@property (nonatomic , strong) UIButton *addressBtn;
/** 底部白色背景 */
@property (nonatomic , strong) UIView *whiteBackGroundView;

@property (nonatomic , strong) NSMutableArray*allArr;

@end

@implementation ShouhoudizhiViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [FYTXHub progress:@"列表加载中..."];
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/address/listUserAddressByUserId?" parameters:@{@"userId" : [NSNumber numberWithInteger:[[LoginStatus sharedManager].idStr integerValue]]} isShowHUD:YES httpToolSuccess:^(id json) {
        _allArr = json;
        [_addressTableView reloadData];
        [FYTXHub dismiss];
        MYLog(@"收货地址列表error = %@",json);
    } failure:^(NSError *error) {
        
        MYLog(@"收货地址列表error = %@",error);
        [FYTXHub toast:@"加载失败"];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _allArr = [[NSMutableArray alloc] init];
    [self whiteBackGroundView];
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
        
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
//        _addressTableView.backgroundColor = [UIColor greenColor];
        [self.view addSubview:_addressTableView];
        [_addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).offset(0);
            make.bottom.equalTo(self.whiteBackGroundView.mas_top).offset(0);
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
        }];
        [_addressTableView registerNib:[UINib nibWithNibName:@"ShouHuoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        //隐藏多余cell
        _addressTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    
    return _addressTableView;
}


#pragma mark -----tableView Delegate And Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _allArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShouHuoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ShouHuoModel *shouModel = [[ShouHuoModel alloc] initWithDictionary:_allArr[indexPath.row]];
    cell.cellBtnBlock = ^(UIButton *sender){
        [self cellBtnAction:sender AndModel:shouModel];
    };
//    cell.backgroundColor = [UIColor blueColor];
    cell.isDefaultBtn.selected = [shouModel.isDefault integerValue];
    cell.manName.text = shouModel.name;
    cell.phoneLabel.text = shouModel.phone;
    cell.detailAddr.text = shouModel.detailedAdd;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 112;
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

#pragma mark ---------------默认地址，编辑列表，删除列表----------------
- (void)cellBtnAction:(UIButton *)sender AndModel:(ShouHuoModel *)model{
    switch (sender.tag) {
        case 331:
        {
            if ([model.isDefault integerValue] == 1) {
                sender.selected = YES;
                [FYTXHub dismiss];
                return;
            }
            [QSCHttpTool get:@"https://123.56.192.182:8443/app/address/updateDefault?" parameters:@{@"userId":[LoginStatus sharedManager].idStr,@"newId":@(model.addrId)} isShowHUD:YES httpToolSuccess:^(id json) {
                    [QSCHttpTool get:@"https://123.56.192.182:8443/app/address/listUserAddressByUserId?" parameters:@{@"userId" : [NSNumber numberWithInteger:[[LoginStatus sharedManager].idStr integerValue]]} isShowHUD:YES httpToolSuccess:^(id json) {
                            _allArr = json;
                        
                        [FYTXHub success:@"设置成功" delayClose:1.0f compelete:^{
                            [_addressTableView reloadData];
                            sender.selected = NO;
                        }];
                        MYLog(@"收货地址列表error = %@",json);
                    } failure:^(NSError *error) {
                        
                        MYLog(@"收货地址列表error = %@",error);
                    }];
                
                MYLog(@"默认地址成功%@",json);
            } failure:^(NSError *error) {
                
                MYLog(@"默认地址失败%@",error);
                [FYTXHub toast:@"操作失败"];
            }];
        }
            break;
        case 332:
        {
            AddressController *addVC = [[AddressController alloc] init];
            addVC.firstLabelText = model.name;
            addVC.secondLabelText = model.phone;
            addVC.thirdLabelText = model.areaAdds;
            addVC.fourthLabelText = model.detailedAdd;
            addVC.isDefualtFlag = model.isDefault;
            addVC.addrId = model.addrId;
            addVC.areaId = model.areaId;
            addVC.isModefy = YES;
            [self.navigationController pushViewController:addVC animated:YES];

        }
            break;
        case 333:
        {
            UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定删除?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [[av rac_buttonClickedSignal] subscribeNext:^(NSNumber* index) {
                if ([index isEqualToNumber:@(1)]) {
                    [FYTXHub progress:@"正在删除..."];
                    //点击了确定
                    [QSCHttpTool get:@"https://123.56.192.182:8443/app/address/deleteUserAddressById?" parameters:@{@"id":@(model.addrId)} isShowHUD:YES httpToolSuccess:^(id json) {
                        [QSCHttpTool get:@"https://123.56.192.182:8443/app/address/listUserAddressByUserId?" parameters:@{@"userId" : [NSNumber numberWithInteger:[[LoginStatus sharedManager].idStr integerValue]]} isShowHUD:YES httpToolSuccess:^(id json) {
                                _allArr = json;
                                
                                [FYTXHub success:@"删除成功" delayClose:1.0f compelete:^{
                                    [_addressTableView reloadData];
                                }];
                            MYLog(@"收货地址列表error = %@",json);
                        } failure:^(NSError *error) {
                            
                            MYLog(@"收货地址列表error = %@",error);
                        }];

                        MYLog(@"删除成功%@",json);
                    } failure:^(NSError *error) {
                        
                        MYLog(@"删除失败%@",error);
                        [FYTXHub toast:@"删除失败"];
                    }];
                }
            }];
            [av show];
                
        }
            break;
            
        default:
            break;
    }
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
