//
//  UITableView+placeHolder.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (placeHolder)
- (void)showEmptyWithDataSource:(NSInteger)count Msg:(NSString*)msg;
@end
