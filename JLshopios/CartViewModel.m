//
//  CartViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "CartViewModel.h"
#import "DetailsViewController.h"
#import "tools/QSCHttpTool.h"
@interface CartViewModel (){
}
//随机获取店铺下商品数
//@property (nonatomic, assign) NSInteger random;
@end

@implementation CartViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.cartData;
      
    }
    return self;
}
#pragma mark - PROPERTY
- (NSMutableArray <GoodModel*>*)cartData{
    if (!_cartData) {
        _cartData = [NSMutableArray array];
    }
    return _cartData;
}
- (NSMutableArray<GoodModel *> *)selectArray{
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
        
    }
    return _selectArray;
}

/**
 *  获取 总价
 *
 *  @return
 */
- (float)getAllPrices{
    
    __block float allPrices = 0;
    NSInteger goodCount = self.cartData.count;
    NSInteger goodSelectCount = self.selectArray.count;
    if (goodSelectCount == goodCount && goodCount!=0) {
        self.isSelectAll = YES;
    }
    NSArray *pricesArray = [[[self.cartData.rac_sequence filter:^BOOL(GoodModel* value) {
        if (!value.isSelect) {
            self.isSelectAll = NO;
        }
        return value.isSelect;
    }] map:^id(GoodModel* value) {
         return @([value.num integerValue] * [value.price floatValue]);
    }] array];
    
        for (NSNumber *price in pricesArray) {
            allPrices += price.floatValue;
        }
    __block NSInteger selectedCount = 0;
    self.selectArray =  [[[self.selectArray.rac_sequence map:^id(GoodModel* value) {
        
        selectedCount += [value.num integerValue];
        
        return value;
    }] array]mutableCopy];
//    }
    self.selectedCount = selectedCount;
    return allPrices;
}
- (void)getLocalDataSuccess:(void (^)(void))finish{
//    NSMutableArray * arr = [NSMutableArray array];
    for (int i = 0; i<5; i++) {
        GoodModel * model = [[GoodModel alloc]init];
        model ->_goodName = [NSString stringWithFormat:@"good number %d",i+1];
        model ->_num = [@(i+1) stringValue];
        model.goodid = [@(110) stringValue];
        model ->_price = [@(arc4random()%10) stringValue];
        model ->_iconImage = [UIImage imageWithColor:QSCRandomColor];
        [self.cartData addObject:model];
    }
//    self.cartData = arr;
     finish?finish():nil;
}
- (void)getDataSuccess:(void (^)(void))finish{
//    NSMutableArray *storeArray = [NSMutableArray array];
//    NSMutableArray *shopSelectAarry = [NSMutableArray array];
    [FYTXHub progress:@"正在加载"];
    [self.cartData removeAllObjects];
    //https://123.56.192.182:8443/app/shopCart/listShopCart?&userid=37
    NSString *  urlString = @"https://123.56.192.182:8443/app/shopCart/listShopCart?";
    NSString * idStr = [LoginStatus sharedManager].idStr;
//     NSString * idStr =@"37";
    [QSCHttpTool get:urlString parameters:@{@"userid":idStr} isShowHUD:YES httpToolSuccess:^(id json) {
        [FYTXHub dismiss];
        __block NSInteger totalCount = 0;
        NSMutableArray * arr =[[[((NSArray*)json).rac_sequence map:^id(id value) {
           GoodModel* model =  [[GoodModel alloc] initWithData:value];
            totalCount += [model.num integerValue];
            return model;
        }] array] mutableCopy];
        
        self.cartData = arr;
        [CartManager sharedManager].totalNum = @(totalCount);
        //计算数量
        
        finish?finish():nil;
        
    } failure:^(NSError *error) {
         [FYTXHub dismiss];
//        TTAlert(@"网络请求出错");
    }];
}

- (void)selectAll:(BOOL)isSelect{
    
    __block float allPrices = 0;
    __block float selectedCount = 0;
    self.cartData = [[[[self.cartData rac_sequence] map:^id(GoodModel *value) {
         [value setValue:@(isSelect) forKey:@"isSelect"];
        if (value.isSelect) {
            allPrices += [value.num integerValue]*[value.price floatValue];
        }
            return value;
        }] array] mutableCopy];
    if (isSelect) {
        self.selectArray = self.cartData.mutableCopy;
    }else{
       
        
        [self.selectArray removeAllObjects];
    }
   self.selectArray =  [[[self.selectArray.rac_sequence map:^id(GoodModel* value) {
        
        selectedCount += [value.num integerValue];
       
        return value;
    }] array]mutableCopy];
    
      self.selectedCount = selectedCount;
    self.allPrices = allPrices;
    [self.cartTableView reloadData];
}

- (void)rowSelect:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    GoodModel *model = self.cartData[row];
    [model setValue:@(isSelect) forKey:@"isSelect"];
    //判断是都到达足够数量
    __block NSInteger isSelectCount = 0;
    if (isSelect) {
        [self.selectArray addObject:model];
    }else{
        [self.selectArray removeObject:model];
    }
    //此处遍历的全部数组 所以下面的count 直接相等就OK
   self.selectArray = [[[self.selectArray.rac_sequence map:^id(GoodModel* value) {
        if (value.isSelect == NO) {
            UIAlertView * AV = [[UIAlertView alloc] initWithTitle:@"BUG" message:@"报错了 有没有选中的商品在选中列表" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [AV show];
        }
        isSelectCount += [value.num integerValue];
        return value;
    }] array] mutableCopy];
    
    [self.cartTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.selectedCount = isSelectCount;
    self.allPrices = [self getAllPrices];
}

- (void)rowChangeQuantity:(NSInteger)quantity indexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    GoodModel *model = self.cartData[row];
    [model setValue:@(quantity) forKey:@"num"];
    [[CartManager sharedManager] updateCartGoodNum:[@(quantity) stringValue] ID:self.cartData[indexPath.row].Id :^{
        NSLog(@"操作成功");
    } :^{
        NSLog(@"操作失败");
    }];
    [self.cartTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.allPrices = [self getAllPrices];
}

#pragma mark - ACTION
- (void)goToDetailWithID:(NSString *)goodID AndIconUrl:(NSString *)goodImg{
    DetailsViewController * detail = [[DetailsViewController alloc] init];
    detail.productIDStr = goodID;
    detail.productIconStr = goodImg;
    [((UIViewController*)self.cartVC).navigationController pushViewController:detail animated:YES];
}
- (void)followAction{
//    TTAlert(@"FollowClick");
    
    NSArray * followArrayID = [[self.selectArray.rac_sequence map:^id(GoodModel* value) {
        return value.goodid;
    }] array];
    NSArray <RACSignal *>* signalArray = [[followArrayID.rac_sequence map:^id(id value) {
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            [[CartManager sharedManager] followActionType:FollowTypeGood ID:value isFollow:YES :^(id obj){
                [subscriber sendNext:@(YES)];
                [subscriber sendCompleted];
            } :^(id error){
                [subscriber sendNext:@(NO)];
                [subscriber sendCompleted];
            }];
          
            return nil;
        }];
    }] array];
    
    [[RACSignal combineLatest:signalArray] subscribeNext:^(RACTuple *x) {
        if ([[x last] isEqualToValue:@(YES)]) {
            [FYTXHub successDarkStyle:@"关注成功" delayClose:1];
        }else{
             [FYTXHub toast:@"关注失败"];   
        }
        
    }];
}
- (void)deleteRow:(NSInteger)row{
    GoodModel * model = self.cartData[row];
    SX_WEAK
    [self deleteWithID:model.Id :^{
        dispatch_async(dispatch_get_main_queue(), ^{
            SX_STRONG
            [self.cartData removeObject:model];
            [self.selectArray removeAllObjects];
             self.cartVC.cartBar.seletedCount = 0;
            self.cartVC.cartBar.money = 0;
            [self.cartTableView reloadData];
        });
        
    }];
}
- (void)deleteAction{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:TTKeyWindow() animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
//    hud.labelText = @"请求中";
 
   NSArray * deleteIDArr = [[self.selectArray.rac_sequence map:^id(GoodModel* value) {
        return value;
    }] array];
    SX_WEAK
//     TTAlert([NSString stringWithFormat:@"%@",deleteIDArr]);
    
   NSArray <RACSignal*>* singalArr =  [[deleteIDArr.rac_sequence map:^id(GoodModel* value) {
       return  [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
           SX_STRONG
           [self deleteWithID:value.Id :^{
               [subscriber sendNext:value];
               [subscriber sendCompleted];
               
           }];
        
           return nil;
       }] ;
        
    }] array];
  
    
    [[RACSignal combineLatest:singalArr] subscribeNext:^(RACTuple* x) {
//        TTAlert(@"删除成功");
        for (int i = 0; i < x.count; i++) {
//             RACTupleUnpack(GoodModel * obj) = ;
            GoodModel * model = x[i];
           
            [self.cartData removeObject:model];
            [self.selectArray removeAllObjects];
             self.cartVC.cartBar.seletedCount = 0;
             self.cartVC.cartBar.money = 0;
        }
        
        
        
        [self.cartTableView reloadData];
        [MBProgressHUD hideHUDForView:TTKeyWindow() animated:YES];
    }];
    
 /*
    @weakify(self);
    [[[[[deleteIDArr.rac_sequence.signal deliverOnMainThread] flattenMap:^RACStream *(NSString * value) {

        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext:@(YES)];
            [subscriber sendCompleted];
            return nil;
        }];
//            return nil;
//        }];
    }] filter:^BOOL(id value) {
        
        return [value boolValue];
    }] take:1] subscribeNext:^(id x) {
        TTAlert(@"删除成功");
        
    }];
    */
}
- (void)deleteWithID:(NSString *)ID :(void(^)(void))success{
    NSLog(@"%@",ID);
    [[CartManager sharedManager] deleteWholeGoodWith:ID :^{
        if (success) {
            success();
        }
    } :^{
        
    }];
   
    
}
- (void)payAction{
     TTAlert(@"PayClick");
}
- (void)loginAction{
    [((UIViewController*)self.cartVC).navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    
//    TTAlert(@"login");
}
@end
