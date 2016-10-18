//
//  ScoreViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreDetailModel.h"
#import "ScoreViewController.h"
@interface ScoreViewModel : NSObject
@property (nonatomic, strong) NSMutableArray<ScoreDetailModel*> * scoreDetailData;
@property (nonatomic, weak) ScoreViewController * owner;
@property (nonatomic, copy) NSString *userusedScore;
@property (nonatomic, copy) NSString *totalScore;
@property (nonatomic, copy) NSString *canUseScore;

- (RACSignal *)getTheScore;
- (RACSignal *)getTheScoreDetailWithPage:(NSInteger)page;
@end
