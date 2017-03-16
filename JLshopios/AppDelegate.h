//
//  AppDelegate.h
//  JLshopios
//
//  Created by daxiongdi on 16/6/4.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLShopModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) JLShopModel *model;
@property (nonatomic,strong) UIView *backView;

@end

