//
//  ScoreUIService.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/21.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreViewModel.h"
@interface ScoreUIService : NSObject
@property(nonatomic, strong) UITableView * mainTableView;
@property (nonatomic, strong) ScoreViewModel * viewModel;

@end
