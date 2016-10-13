//
//  MyOrderDetailViewController.m
//  JLshopios
//
//  Created by 孙鑫 on 16/10/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyOrderDetailViewController.h"
#import "MyOrderDetailTableViewCell.h"
#import "OrderDteailFooter.h"
@interface MyOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainView;
@property (strong, nonatomic) IBOutlet UIView *tableHeader;
@property (strong, nonatomic) IBOutlet UIView *tableFooter;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

@property (strong, nonatomic)  UILabel *orderDiscountLabel;
@property (strong, nonatomic)  UILabel *orderPostalLabel;
@property (strong, nonatomic)  UILabel *orderRealPriceLabel; //实付款
@property (strong, nonatomic)  UILabel *orderTotalPriceLabel;



@property (strong, nonatomic) IBOutlet UIButton *payButton;

@property (weak, nonatomic) IBOutlet  UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *userAddress;

@property (strong, nonatomic) UIView * footerView;
@property (strong, nonatomic) SysOrder * order;
@property (copy, nonatomic) NSArray <SysOrderDetail*>* orderDetails;
@end

@implementation MyOrderDetailViewController
- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kDeviceWidth , 100)];
        _footerView.backgroundColor = [UIColor whiteColor];
        NSArray * rectArray = @[[NSValue valueWithCGRect:CGRectMake(10, 5, 60, 18)],[NSValue valueWithCGRect:CGRectMake(10, 28, 60, 18)],[NSValue valueWithCGRect:CGRectMake(10, 49, 60, 18)]];
        NSArray * titleArray = @[@"商品总额",@"-优惠",@"+邮费"];
        NSArray * fontArray = @[@15,@13,@13];
        NSArray * colorArray  = @[[UIColor blackColor],[UIColor lightGrayColor],[UIColor lightGrayColor]];
        
        for (int i = 0; i < 3; i++) {
            UILabel * label = [[UILabel alloc] initWithFrame:[rectArray[i] CGRectValue]];
            label.text = titleArray[i];
            label.font = [UIFont systemFontOfSize:[fontArray[i] floatValue]];
            label.textColor = colorArray[i];
            [_footerView addSubview:label];
        }
        _orderTotalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 5, 100, 17)];
        _orderTotalPriceLabel.textColor = [UIColor redColor];
        _orderTotalPriceLabel.textAlignment = NSTextAlignmentRight;
        _orderTotalPriceLabel.font = [UIFont  systemFontOfSize:13];
        
        _orderDiscountLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 28, 100, 17)];
        _orderDiscountLabel.textColor = [UIColor redColor];
        _orderDiscountLabel.textAlignment = NSTextAlignmentRight;
        _orderDiscountLabel.font = [UIFont  systemFontOfSize:13];
        
        
        _orderPostalLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 49, 100, 17)];
        _orderPostalLabel.textColor = [UIColor redColor];
        _orderPostalLabel.textAlignment = NSTextAlignmentRight;
        _orderPostalLabel.font = [UIFont  systemFontOfSize:13];
        
        
        _orderRealPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth-100, 80, 100, 20)];
        _orderRealPriceLabel.textColor = [UIColor redColor];
        _orderRealPriceLabel.textAlignment = NSTextAlignmentRight;
        _orderRealPriceLabel.font = [UIFont  systemFontOfSize:15];
      
        
        [_footerView addSubview:_orderTotalPriceLabel];
         [_footerView addSubview:_orderRealPriceLabel];
         [_footerView addSubview:_orderDiscountLabel];
         [_footerView addSubview:_orderPostalLabel];
        
        UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, kDeviceWidth, 5)];
        lineView.backgroundColor = RGB(230, 230, 230);
        [_footerView addSubview:lineView];
    }
    return _footerView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"订单详情";
    self.view.backgroundColor = RGB(230, 230, 230);
    [_mainView registerNib:[UINib nibWithNibName:NSStringFromClass([MyOrderDetailTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([MyOrderDetailTableViewCell class])];
    _mainView.rowHeight = 70;
    _mainView.tableHeaderView = self.tableHeader;
    _mainView.tableFooterView = self.footerView;
    [self setData];
    
    
    [[_payButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [[[PayManager manager] doAlipayPayWithGood:self.orderReturn] execute:nil];
    }];
    // Do any additional setup after loading the view from its nib.
}
- (void)setData{
    _orderReturn = self.orderReturn;
    _order = self.orderReturn.order;
    _orderNoLabel.text = _orderReturn.serialNumber;
    
    _orderDiscountLabel.text = _order.payScore;
    _orderPostalLabel.text = _order.deliveryFee;
    _nameLabel.text = _order.receiveUser;
    _userPhoneLabel.text = _order.userPhone;
    _userAddress.text = _order.receiveAdd;
    _orderDetails = _order.orderDetails;
    
    _orderTotalPriceLabel.text = [NSString stringWithFormat:@"%.2f",[_order.money floatValue]];
    _orderPostalLabel.text = [NSString stringWithFormat:@"%.2f",[_order.deliveryFee floatValue]];
    
    _orderDiscountLabel.text =  [NSString stringWithFormat:@"%.2f",[_order.payScore floatValue]];
    NSMutableAttributedString * real = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"实付款：%.2f",[_order.payMoney floatValue]]];
    [real addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, 4)];
    _orderRealPriceLabel.attributedText = real;
    
     [self.mainView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderDetailTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyOrderDetailTableViewCell class])];
    if (self.orderDetails.count) {
        cell.model = self.orderDetails[indexPath.row];
    }

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 15;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 23;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 23)];
    label.font = SXFont(16);
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentLeft;
    label.text = self.order.shop.name;
    label.backgroundColor = [UIColor whiteColor];
    UIView * line = [[UIView alloc] initWithFrame:CGRectMake(0, 22, kDeviceWidth, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [label addSubview:line];
    return label;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderDetails.count;
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return  [[NSAttributedString alloc] initWithString:@"暂无数据"];
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