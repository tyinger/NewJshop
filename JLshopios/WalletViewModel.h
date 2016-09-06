//
//  WalletViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WalletViewModel : NSObject
@property (nonatomic, strong) NSMutableArray * scoreDetailData;

- (void)getTheScore;
- (void)getTheScoreDetail;
- (void)payAction;
@end
