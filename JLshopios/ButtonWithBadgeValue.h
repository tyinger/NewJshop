//
//  ButtonWithBadgeValue.h
//  ButtonWithBadgeValue
//
//  Created by QSQ on 14/11/26.
//  Copyright (c) 2014年 QSQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonWithBadgeValue : UIButton
@property (nonatomic,copy) NSString *badgeValue;
@property (nonatomic,assign) CGFloat radius;
@property (nonatomic,assign) CGFloat centerX;
@property (nonatomic,assign) CGFloat centerY;
@end
