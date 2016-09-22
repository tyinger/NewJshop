//
//  FollowUIModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FollowViewModel.h"
@interface FollowUIModel : NSObject
@property (nonatomic, strong) FollowViewModel * viewModel;
@property (nonatomic, strong) UITableView * mainTableView;
- (void)reloadData:(VCType)type;
@end
