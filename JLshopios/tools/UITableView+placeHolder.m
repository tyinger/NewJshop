//
//  UITableView+placeHolder.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "UITableView+placeHolder.h"

@implementation UITableView (placeHolder)
- (void)showEmptyWithDataSource:(NSInteger)count Msg:(NSString *)msg{
     [self numberOfRowsInSection:0];
}
@end
