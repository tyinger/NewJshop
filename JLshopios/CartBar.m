//
//  CartBar.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//
static NSInteger const BalanceButtonTag = 120;


static NSInteger const SelectButtonTag = 122;

#import "CartBar.h"

@implementation CartBar
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBarUI];
    }
    return self;
}

- (void)setBarUI{
    
    self.backgroundColor = RGB(55, 55, 55);
    /* 背景 */
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    
    effectView.userInteractionEnabled = NO;
    effectView.frame = self.bounds;
    [self addSubview:effectView];
    
    CGFloat wd = kDeviceWidth *2/7;
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    lineView.backgroundColor  = RGBA(210, 210, 210, 1);
    [self addSubview:lineView];
    /* 结算 */
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateDisabled];
    [button setTitle:@"结算" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(kDeviceWidth-wd, 0, wd, self.frame.size.height)];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    button.enabled = NO;
    button.tag = BalanceButtonTag;
    [self addSubview:button];
    _balanceButton = button;
    /* 全选 */
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"全选"
             forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor whiteColor]
                  forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"xn_circle_normal"]
             forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"xn_circle_select"]
             forState:UIControlStateSelected];
    [button3 setFrame:CGRectMake(0, 0, 78, self.frame.size.height)];
    [button3 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    button3.tag = SelectButtonTag;
    [self addSubview:button3];
    _selectAllButton = button3;
    /* 价格 */
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, kDeviceWidth-wd*2-5,self.frame.size.height/2)];
    label1.text = [NSString stringWithFormat:@"合计￥:%@",@(00.00)];
    label1.textColor = [UIColor whiteColor];
    label1.font = SXFont(13);
    label1.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label1];
    _totalLabel = label1;
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(85, self.frame.size.height/2, kDeviceWidth-wd*2-5,self.frame.size.height/2)];
    label2.text = [NSString stringWithFormat:@"总额￥:%@",@(00.00)];
    label2.textColor = [UIColor whiteColor];
    label2.font = SXFont(13);
    label2.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label2];
    _allMoneyLabel = label2;
    /* assign value */
    SX_WEAK
    [RACObserve(self, money) subscribeNext:^(NSNumber *x) {
        SX_STRONG
        self.allMoneyLabel.text = [NSString stringWithFormat:@"总额￥:%.2f",x.floatValue];
         self.totalLabel.text = [NSString stringWithFormat:@"合计￥:%.2f",x.floatValue];
    }];
    [RACObserve(self, seletedCount) subscribeNext:^(NSNumber *x) {
        SX_STRONG
       
        [self.balanceButton setTitle:[NSString stringWithFormat:@"结算（%d）",[x intValue]] forState:0];
    }];
    /*  RAC BLIND  */
    RAC(self.balanceButton,enabled) = [RACSignal combineLatest:@[RACObserve(self.selectAllButton, selected),
                                                                 RACObserve(self, money)]
                                                        reduce:^id(NSNumber *isSelect,NSNumber *moeny){
                                                            return @(isSelect.boolValue||moeny.floatValue>0);
                                                        }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
