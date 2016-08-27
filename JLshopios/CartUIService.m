//
//  CartUIService.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "CartUIService.h"
#import "CartViewModel.h"
#import "CartCell.h"
\
#import "GoodModel.h"
#import "ChartNumberCountView.h"
#import "CartManager.h"
@interface CartUIService ()

@end
@implementation CartUIService
#pragma mark - UITableView Delegate/DataSource

- (instancetype)init{
    self = [super init];
    if (self) {
        SX_WEAK
        CartManager * manager = [CartManager sharedManager];
        [RACObserve(manager, cartGoodNum) subscribeNext:^(NSNumber* x) {
           //根据X刷新UI
           SX_STRONG
            [self refreshUIwithCount:x];
            
        }];
    }
    return self;
}
- (void)refreshUIwithCount:(NSNumber *)count{
    if (count&&![count isEqualToNumber:@(0)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewModel.cartPlaceholderView.hidden = YES;
        });
        
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            self.viewModel.cartPlaceholderView.hidden = NO;
        });
       
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.viewModel.cartData.count;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    [CartManager sharedManager].cartGoodNum = @(self.viewModel.cartData.count);
    return [self.viewModel.cartData count];
}

#pragma mark - header view
/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [JSCartHeaderView getCartHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    JSCartHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JSCartHeaderView"];
    //店铺全选
    [[[headerView.selectStoreGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:headerView.rac_prepareForReuseSignal] subscribeNext:^(UIButton *xx) {
        xx.selected = !xx.selected;
        BOOL isSelect = xx.selected;
        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
        for (JSCartModel *model in shopArray) {
            [model setValue:@(isSelect) forKey:@"isSelect"];
        }
        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
        self.viewModel.allPrices = [self.viewModel getAllPrices];
    }];
    //店铺选中状态
    headerView.selectStoreGoodsButton.selected = [self.viewModel.shopSelectArray[section] boolValue];
    
    //    [RACObserve(headerView.selectStoreGoodsButton, selected) subscribeNext:^(NSNumber *x) {
    //
    //        BOOL isSelect = x.boolValue;
    //
    //        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
    //        for (JSCartModel *model in shopArray) {
    //            [model setValue:@(isSelect) forKey:@"isSelect"];
    //        }
    //        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    //    }];
    
    return headerView;
}

#pragma mark - footer view

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [JSCartFooterView getCartFooterHeight];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    JSCartFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"JSCartFooterView"];
    
    footerView.shopGoodsArray = shopArray;
    
    return footerView;
}
 */

/**
 *  删除
 */
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    [self.viewModel deleteAction];
    
}
//
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [CartCell getCartCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CartCell"
                                                       forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(CartCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    GoodModel *model = self.viewModel.cartData[row];
    //cell 选中
    SX_WEAK
    [[[cell.selectShopGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton *x) {
        SX_STRONG
        x.selected = !x.selected;
        [self.viewModel rowSelect:x.selected IndexPath:indexPath];
    }];
    //数量改变
    cell.nummberCount.NumberChangeBlock = ^(NSInteger changeCount){
        SX_STRONG
        [self.viewModel rowChangeQuantity:changeCount indexPath:indexPath];
    };
    cell.model = model;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.viewModel goToDetailWithID:[self.viewModel.cartData[indexPath.row] goodid]];
}

@end
