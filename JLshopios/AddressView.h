//
//  AddressView.h
//  JLshopios
//
//  Created by 陈霖 on 16/9/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressView : UIView<UITableViewDelegate,UITableViewDataSource>

/** 省份tableView */
@property (nonatomic , strong) UITableView *provinceTableView;
/** 市区tableVIew */
@property (nonatomic , strong) UITableView *cityTableView;
/** 县城tableView */
@property (nonatomic , strong) UITableView *townTableView;


@end
