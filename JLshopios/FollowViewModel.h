//
//  FollowViewModel.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MyFollowViewController;
@interface FollowViewModel : NSObject
@property (nonatomic, weak)MyFollowViewController * followViewController;

- (void)goToDetailWithID:(NSString *)goodID;

@end
