//
//  MyOrderViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MyOrderViewModel.h"
#import "QSCHttpTool.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderDetailViewController.h"
@interface MyOrderViewModel()
{
    NSInteger  _page ;
}
@end
@implementation MyOrderViewModel
- (NSMutableArray<SysOrder *> *)dataInfo{
    if (!_dataInfo) {
        _dataInfo = [NSMutableArray array];
    }
    return _dataInfo;
}
- (RACCommand *)getTheDataWithPage:(NSInteger)page{
    _page = page;
    return [self getTheData];
    
}
- (RACCommand *)getTheData{
     return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            /*
             https://123.56.192.182:8443/app/appOrderController/ajaxOrderRecdsPage?
             */
            [FYTXHub progress:@"正在加载"];
            
            NSString *  urlString = @"https://123.56.192.182:8443/app/appOrderController/ajaxOrderRecdsPage?";
                NSString * idStr = [LoginStatus sharedManager].idStr;
//            NSString * idStr = @"6";
            
            //这个type根据 owner的type 请求不同
            NSString * type ;
            NSArray * typeArray = @[@"waitpay",@"waitsend",@"waitreceive",@"waitComment",@""];
            type = typeArray[self.owner.mainType];
            NSDictionary * paraDic = @{@"id":idStr,@"begin":[NSString stringWithFormat:@"%ld",_page*10],@"type":type};
            
            NSString * prarString = [paraDic JSONString];
            NSDictionary *dic = @{@"arg0":prarString};
            
            
            [QSCHttpTool get:urlString parameters:dic isShowHUD:YES httpToolSuccess:^(id json) {
                [FYTXHub dismiss];
                [self.owner.mainView.mj_header endRefreshing];
                 [self.owner.mainView.mj_footer endRefreshing];
                if (((NSArray*)json).count!=10) {
                    [self.owner.mainView.mj_footer noticeNoMoreData];
                }
                NSLog(@"json 9627 === %@",json);
                for (NSDictionary* value in json) {
                    SysOrder * order =  [ SysOrder objectWithKeyValues:value];
                    order.orderDetails = [SysOrderDetail objectArrayWithKeyValuesArray:order.orderDetails];
                    order.invoice = [SysInvoice objectWithKeyValues:order.invoice];
                    [self.dataInfo  addObject:order];
                }
                
                [self.owner.mainView reloadData];
            } failure:^(NSError *error) {
                [self.owner.mainView.mj_header endRefreshing];
                [self.owner.mainView.mj_footer endRefreshing];
                
                   NSLog(@"/*****************************    **********************************/%@",error);
                     [FYTXHub dismiss];
            }];
            
       

            
            
            
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (RACCommand *)payAction{
     return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            TTAlert(@"pay");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (RACCommand *)cancelAction{
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            TTAlert(@"cancel");
            [subscriber sendCompleted];
            return nil;
        }];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyOrderTableViewCell class])];
    NSLog(@"%@",indexPath);
    SX_WEAK
    cell.actionButton.rac_command =  [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            SX_STRONG
            [self pushToDetai:self.dataInfo[indexPath.row]];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
   
    cell.cancelButton.rac_command =   [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            __block UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定取消" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [av show];
            //点击了确定
            SX_WEAK
            [[av rac_buttonClickedSignal] subscribeNext:^(NSNumber* index) {
                if ([index isEqualToNumber:@(1)]) {
                    
                    av = nil;
                    [[[PayManager manager] cancelTheOrder:self.dataInfo[indexPath.row]] subscribeNext:^(id x) {
                        SX_STRONG
                        [self.owner.mainView.mj_header beginRefreshing];
                        
                    }];
                    
                }
            }];
            

            [subscriber sendCompleted];
            return nil;
        }];
    }];
    /*
    [[cell.cancelButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        __block UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否确定取消" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [av show];
        //点击了确定
        SX_WEAK
        [[av rac_buttonClickedSignal] subscribeNext:^(NSNumber* index) {
            if ([index isEqualToNumber:@(1)]) {
               
                 av = nil;
                [[[PayManager manager] cancelTheOrder:self.dataInfo[indexPath.row]] subscribeNext:^(id x) {
                    SX_STRONG
                    [self.owner.mainView.mj_header beginRefreshing];
                    
                }];
              
            }
        }];
       
       
    }];
     */
    
    if (self.dataInfo.count) {
        cell.order = self.dataInfo[indexPath.row];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataInfo.count;
}


- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"暂无订单,快去挑选商品吧！"];
}

- (void)pushToDetai:(SysOrder *)order{
    MyOrderDetailViewController * detail = [[MyOrderDetailViewController alloc] init];
    SysOrderReturn * orderReturn = [[SysOrderReturn alloc] init];
    orderReturn.serialNumber = order.serialNumber;
    orderReturn.order = order;
     detail.orderReturn = orderReturn;
    [self.owner.navigationController pushViewController:detail animated:YES];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self pushToDetai:self.dataInfo[indexPath.row]];
}
@end
