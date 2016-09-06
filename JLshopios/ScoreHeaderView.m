//
//  ScoreHeaderView.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//
static CGFloat tagHeight = 20;
static CGFloat numberHeight = 40;
static CGFloat lineHeight = 20;
static CGFloat titleHeight = 25;
#import "ScoreHeaderView.h"
@interface ScoreHeaderView()
{
    CGFloat totalHiegh;
}

@property(nonatomic, strong) NSMutableArray <UILabel *>*numberLabel;
@end;
@implementation ScoreHeaderView
- (NSMutableArray <UILabel *>*)numberLabel{
    if (!_numberLabel) {
        _numberLabel = [NSMutableArray array];
    }
    return _numberLabel;
}
- (instancetype)init{
    self = [super init];

    if (self ) {
         totalHiegh = tagHeight+lineHeight+numberHeight+titleHeight;
        self.frame = CGRectMake(0, 0, kDeviceWidth,totalHiegh);
       
        [self initializtion];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        [self initializtion];
    }
    return self;
}

- (void)initializtion{
    NSArray * tags = @[@"累计积分",@"可用积分",@"已用积分"];
    for (int i = 0; i < 3; i++) {
        UILabel * tag = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*i, 0, kDeviceWidth/3, tagHeight)];
        tag.text = tags[i];
        tag.textAlignment = NSTextAlignmentCenter;
        tag.font = SXFont(13);
        [self addSubview:tag];
        UILabel * number = [[UILabel alloc] initWithFrame:CGRectMake(kDeviceWidth/3*i, 20, kDeviceWidth/3, 40)];
        number.text = @"0";
        number.textColor = [UIColor redColor];
        number.textAlignment = NSTextAlignmentCenter;
        number.font = SXFont(17);
        [self.numberLabel addObject:number];
        [self addSubview:number];
    }
    SX_WEAK
    [RACObserve(self, totalScore) subscribeNext:^(NSString * x) {
        SX_STRONG
        self.numberLabel[0].text = x;
    }];
    [RACObserve(self, canUseScore) subscribeNext:^(NSString * x) {
        SX_STRONG
        self.numberLabel[1].text = x;
    }];
    [RACObserve(self, userusedScore) subscribeNext:^(NSString * x) {
        SX_STRONG
        self.numberLabel[2].text = x;
    }];
    UIView * lineView = [[UIView alloc] initWithFrame:CGRectMake(0, tagHeight+numberHeight, kDeviceWidth, lineHeight)];
    lineView.backgroundColor = RGB(240, 240, 240);
    [self addSubview:lineView];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lineView.y+lineHeight, kDeviceWidth, titleHeight)];
    titleLabel.text = @"积分明细";
    titleLabel.font = SXFont(15);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:titleLabel];
    
    UIView * topLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 0.5)];
    topLine.backgroundColor = RGB(220, 220, 220);
    [self addSubview:topLine];
    
    UIView * bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, totalHiegh-1, kDeviceWidth, 0.5)];
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
