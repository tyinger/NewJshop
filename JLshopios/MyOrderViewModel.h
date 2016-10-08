//
//  MyOrderViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SysPage;
@interface MyOrderViewModel : NSObject<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) SysPage *pageInfo;
- (RACCommand*)getTheData;

@end

@interface SysPage : NSObject
@property(nonatomic , copy ) NSString *type;
@property(nonatomic , copy ) NSString *begin;
@end