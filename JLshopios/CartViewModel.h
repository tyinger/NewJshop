//
//  CartViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoodModel.h"
#import "CartPlaceHolderView.h"
@class ShopingCartController;
@interface CartViewModel : NSObject

@property (nonatomic, strong) NSMutableArray  <GoodModel*>* cartData;
@property (nonatomic, weak  ) ShopingCartController *cartVC;
@property (nonatomic, weak  ) UITableView          *cartTableView;
@property (nonatomic, weak  ) CartPlaceHolderView* cartPlaceholderView;
/**
 *  被选中的数组
 */
@property (nonatomic, strong) NSMutableArray <GoodModel*> *selectArray;
/**
 *  carbar 观察的属性变化
 */
@property (nonatomic, assign) float                 allPrices;
//选中的数量
@property (nonatomic, assign) float                 selectedCount;
/**
 *  carbar 全选的状态
 */
@property (nonatomic, assign) BOOL                  isSelectAll;

#pragma mark - method
//获取网络数据
- (void)getDataSuccess:(void(^)(void))finish;
//获取本地数据
- (void)getLocalDataSuccess:(void(^)(void))finish;
/*   两个BAR的操作     */

//两种选择（两个bar公用）
//      ①全选
- (void)selectAll:(BOOL)isSelect;
//      ②row select
- (void)rowSelect:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath;

/**
 *  payBar 的结算
 */
- (void)payAction;
/**
 *  editBar 的操作
 *  ① FOLLOW    ② DELETE
 */
- (void)followAction;
- (void)deleteAction;

//row change quantity
- (void)rowChangeQuantity:(NSInteger)quantity indexPath:(NSIndexPath *)indexPath;
//获取价格
- (float)getAllPrices;

///触发事件
//      点击详情
- (void)goToDetailWithID:(NSString *)goodID;
//      点击登录
- (void)loginAction;
//      点击秒杀 (控制器中跳转一下 暂时不需要提进来)
//- (void)quickBuyAction;
@end
