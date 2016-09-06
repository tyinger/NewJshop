//
//  JLHomeViewController.h
//  JLshopios
//
//  Created by imao on 16/6/5.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopBaseViewController.h"

typedef void(^CellRowBlock)(NSInteger rowNumber);
@interface JLHomeViewController : ShopBaseViewController
@property (copy, nonatomic) CellRowBlock cellRowBlock;
@end
