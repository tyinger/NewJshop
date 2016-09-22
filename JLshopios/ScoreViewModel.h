//
//  ScoreViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreViewModel : NSObject
@property (nonatomic, strong) NSMutableArray * scoreDetailData;
@property (nonatomic, copy) NSString *userusedScore;
@property (nonatomic, copy) NSString *totalScore;
@property (nonatomic, copy) NSString *canUseScore;
@property (nonatomic, copy) NSMutableArray * scoreDetailArray;
- (RACSignal *)getTheScore;
- (RACSignal *)getTheScoreDetail;
@end
