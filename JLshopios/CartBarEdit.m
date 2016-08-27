//
//  CartBarEdit.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/26.
//  Copyright © 2016年 feng. All rights reserved.
//
static NSInteger const SelectButtonTag = 220;
static NSInteger const FollowButtonTag = 221;
static NSInteger const DeleteButtonTag = 222;

#import "CartBarEdit.h"

@implementation CartBarEdit

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBarUI];
    }
    return self;
}
- (void)setBarUI{
    self.backgroundColor = [UIColor whiteColor];
    //line
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    lineView.backgroundColor  = RGBA(210, 210, 210, 1);
    [self addSubview:lineView];
    
    /* 全选 */
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setTitle:@"全选"
             forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor whiteColor]
                  forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"xn_circle_normal"]
             forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"xn_circle_select"]
             forState:UIControlStateSelected];
    [button1 setFrame:CGRectMake(0, 0, 78, self.frame.size.height)];
    [button1 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    button1.tag = SelectButtonTag;
    [self addSubview:button1];
    _selectAllButton = button1;
    
    CGFloat wd = kDeviceWidth/7*2;
    /* 删除 */
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"删除" forState:UIControlStateNormal];
    [button2 setFrame:CGRectMake(kDeviceWidth-wd-15, 5, wd, self.frame.size.height-10)];
    button2.layer.cornerRadius = 5;
    button2.layer.borderColor = [UIColor redColor].CGColor;
    button2.layer.borderWidth = 1;
    
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    button2.tag = DeleteButtonTag;
    [self addSubview:button2];
    _deleteButton = button2;
     /* 关注 */
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"移入关注" forState:UIControlStateNormal];
    [button3 setFrame:CGRectMake(kDeviceWidth-wd*2 - 45, 5, wd, self.frame.size.height-10)];
    button3.layer.cornerRadius = 5;
    button3.layer.borderColor = [UIColor darkGrayColor].CGColor;
    button3.layer.borderWidth = 1;
    
    [button3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    button3.tag = FollowButtonTag;
    [self addSubview:button3];
    _followButton = button3;
}
@end
