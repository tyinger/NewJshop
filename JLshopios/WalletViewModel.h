//
//  WalletViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WallteDetailModel.h"
#import "WalletViewController.h"
@interface WalletViewModel : NSObject <UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property (nonatomic, strong) NSMutableArray<WallteDetailModel*> * walletDetailData;
@property (nonatomic, copy) NSString* userablemoney; //可用的money
@property (nonatomic, copy) NSString* totalprofit; //总共的money
@property (nonatomic, weak) WalletViewController * owner;
- (RACSignal*)getTheScore;
- (RACSignal * )getTheScoreDetailWithPage:(NSInteger )page;
- (void)payAction;
@end
