//
//  JLTypeListView.h
//  JLshopios
//
//  Created by imao on 16/6/12.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ListBtnBlock)(NSInteger btnTag);

@interface JLTypeListView : UIView

/** 按钮传值 */
@property (nonatomic, copy) ListBtnBlock listBtnBlock;
@property (nonatomic,strong) NSArray *imageArray;
-(void)loadAllButtons;

@end
