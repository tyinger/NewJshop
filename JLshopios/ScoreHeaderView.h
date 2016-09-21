//
//  ScoreHeaderView.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreViewModel.h"
@interface ScoreHeaderView : UIView
@property (nonatomic, copy) NSString * userusedScore;
@property (nonatomic, copy) NSString * totalScore;
@property (nonatomic, copy) NSString * canUseScore;
@property (nonatomic, strong) ScoreViewModel * viewModel;
@end
