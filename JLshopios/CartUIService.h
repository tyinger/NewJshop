//
//  CartUIService.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CartViewModel;
@interface CartUIService : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CartViewModel *viewModel;

@end
