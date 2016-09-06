//
//  CommodityTableTableViewController.h
//  jdmobile
//
//  Created by SYETC02 on 15/6/19.
//  Copyright (c) 2015年 SYETC02. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommodityTableViewController : UIViewController
@property (nonatomic, copy) NSString *secondMenuIDStr;
@property (nonatomic, copy) NSString *searchNameStr;

- (instancetype)initWithType:(NSInteger)tabbarNum;
@end
