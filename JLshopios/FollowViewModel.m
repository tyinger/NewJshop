
//
//  FollowViewModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "FollowViewModel.h"
#import "DetailsViewController.h"
@implementation FollowViewModel


- (void)goToDetailWithID:(NSString *)goodID{
    DetailsViewController * detail = [[DetailsViewController alloc] init];
    detail.productIDStr = goodID;
    [((UIViewController*)self.followViewController).navigationController pushViewController:detail animated:YES];
}
@end
