//
//  ChartNumberCountView.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SXNumberChangeBlock)(NSInteger count);

@interface ChartNumberCountView : UIView
@property (nonatomic, assign) NSInteger           totalNum;
@property (nonatomic, assign) NSInteger           currentCountNumber;

@property (nonatomic, copy  ) SXNumberChangeBlock NumberChangeBlock;
@end
