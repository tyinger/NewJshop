//
//  MyOrderViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyOrderViewController.h"
#import "OrderModel.h"
@class SysPage;
@interface MyOrderViewModel : NSObject<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) SysPage *pageInfo;
@property (nonatomic, strong) NSMutableArray < SysOrder*> * dataInfo;
@property (nonatomic, weak) MyOrderViewController * owner;
- (RACCommand*)getTheData;

- (RACCommand*)getTheDataWithPage:(NSInteger)page;

- (RACCommand*)payAction;
- (RACCommand*)cancelAction;
@end

@interface SysPage : NSObject
@property(nonatomic , copy ) NSString *type;
@property(nonatomic , copy ) NSString *begin;
@end