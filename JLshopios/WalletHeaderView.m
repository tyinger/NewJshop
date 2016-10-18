//
//  WalletHeaderView.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//
static CGFloat tagHeight = 20;
static CGFloat numberHeight = 40;
static CGFloat lineHeight = 20;
static CGFloat titleHeight = 25;
#import "WalletHeaderView.h"
@interface WalletHeaderView()
{
    CGFloat totalHeight;
}
@property (nonatomic, strong) NSMutableArray <UILabel *>* numberLabel;
@end
@implementation WalletHeaderView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
//        [self initializtion];
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    
    if (self ) {
        totalHeight = tagHeight+lineHeight*2+numberHeight+titleHeight*2;
        self.frame = CGRectMake(0, 0, kDeviceWidth,totalHeight);
        
        [self initializtion];
    }
    return self;
}
- (NSMutableArray <UILabel *>*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [NSMutableArray array];
    }
    return _numberLabel;
}
- (void)initializtion{
    NSArray * tags = @[@"累计收益",@"可用余额"];
    for (int i = 0; i < 2; i++) {
        UILabel * tag = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2*i, 0, kDeviceWidth/2, tagHeight)];
        tag.text = tags[i];
        tag.textAlignment = NSTextAlignmentCenter;
        tag.font = SXFont(13);
        [self addSubview:tag];
        UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/2*i, 20, kDeviceWidth/2, 40)];
        number.text = @"0";
        number.textColor = [UIColor redColor];
        number.textAlignment = NSTextAlignmentCenter;
        number.font = SXFont(17);
        [self.numberLabel addObject:number];
        [self addSubview:number];
    }
    SX_WEAK
    [RACObserve(self, totalprofit) subscribeNext:^(NSString * x) {
        SX_STRONG
        self.numberLabel[0].text = x;
    }];
    [RACObserve(self, userablemoney) subscribeNext:^(NSString * x) {
        SX_STRONG
        self.numberLabel[1].text = x;
    }];
    
   
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tagHeight+numberHeight, kDeviceWidth, lineHeight)];
    lineView.backgroundColor = RGB(240, 240, 240);
    [self addSubview:lineView];
    
    UIButton *  withdraw = [UIButton buttonWithType:UIButtonTypeCustom];
    withdraw.frame = CGRectMake(0, lineView.y+lineHeight, kDeviceWidth, titleHeight);
    [withdraw setTitle:@"提现" forState:UIControlStateNormal];
    [withdraw setTitleColor:[UIColor darkGrayColor] forState:0];
 withdraw.titleLabel.font = SXFont(15);
    withdraw.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.payButton = withdraw;
    
    [self addSubview:withdraw];
    
    UIView * lineViewTwo = [[UIView alloc] initWithFrame:CGRectMake(0, withdraw.y+withdraw.height, kDeviceWidth, lineHeight)];
    lineViewTwo.backgroundColor = RGB(240, 240, 240);
    [self addSubview:lineViewTwo];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lineViewTwo.y+lineHeight, kDeviceWidth, titleHeight)];
    titleLabel.text = @"钱包明细";
    titleLabel.font = SXFont(15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    topLine.backgroundColor = RGB(220, 220, 220);
    [self addSubview:topLine];
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, totalHeight-1, kDeviceWidth, 0.5)];
    bottomLine.backgroundColor = RGB(220, 220, 220);
    [self addSubview:bottomLine];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
