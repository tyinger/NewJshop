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
    //https://123.56.192.182:8443/app/shopCart/listShopCart?&userid=37
    NSString *  urlString = @"https://123.56.192.182:8443/app/shopCart/listShopCart?";
    [QSCHttpTool get:urlString parameters:@{@"userid":@"37"} isShowHUD:YES httpToolSuccess:^(id json) {
        
        NSMutableArray * arr =[[[((NSArray*)json).rac_sequence map:^id(id value) {
            return [[GoodModel alloc] initWithData:value];
        }] array] mutableCopy];
        
        self.cartData = arr;
        finish?finish():nil;
//        [((NSArray*)json).rac_sequence.signal subscribeNext:^(id x) {
//            GoodModel * model =[[GoodModel alloc] initWithData:x];
//            [storeArray addObject:model];
//            [shopSelectAarry addObject:@(NO)];
//
//        } completed:^{
//            [self.cartData addObject:storeArray];
//            self.shopSelectArray = shopSelectAarry;
//            finish?finish():nil;
//        }];
//        for (NSDictionary * dic in json) {
//            GoodModel * model =[[GoodModel alloc] init];
//            [model setValuesForKeysWithDictionary:dic];
//            [storeArray addObject:model];
//            [shopSelectAarry addObject:@(NO)];
//        }
//        [self.cartData addObject:storeArray];
//        self.shopSelectArray = shopSelectAarry;
//        if (finish) {
//            finish();
//        }
    } failure:^(NSError *error) {
        
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
    [self.cartTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    self.allPrices = [self getAllPrices];
}

#pragma mark - ACTION
- (void)goToDetailWithID:(NSString *)goodID{
    DetailsViewController * detail = [[DetailsViewController alloc] init];
    detail.productIDStr = goodID;
    [((UIViewController*)self.cartVC).navigationController pushViewController:detail animated:YES];
}
- (void)followAction{
    TTAlert(@"FollowClick");
}
- (void)deleteAction{
     TTAlert(@"DeleteClick");
}
- (void)payAction{
     TTAlert(@"PayClick");
}
- (void)loginAction{
    TTAlert(@"login");
}
@end