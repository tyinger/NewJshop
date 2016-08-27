//
//  CartBarEdit.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/26.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  点击编辑以后的bar view
 */
@interface CartBarEdit : UIView
{
    @public
     UIButton *_selectAllButton;
     UIButton *_followButton;
     UIButton * _deleteButton;
}
/*
 *  主要控件有三个 ： 全选， 移入关注 ， 删除
 *
全选*/
@property (nonatomic, strong) UIButton *selectAllButton;
//移入关注
@property (nonatomic, strong) UIButton *followButton;
//删除
@property (nonatomic, strong) UIButton * deleteButton;
@end
