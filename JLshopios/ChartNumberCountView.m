//
//  ChartNumberCountView.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//
static CGFloat const Wd = 28;

#import "ChartNumberCountView.h"

@interface ChartNumberCountView()
//加
@property (nonatomic, strong) UIButton    *addButton;
//减
@property (nonatomic, strong) UIButton    *subButton;
//数字按钮
@property (nonatomic, strong) UITextField *numberTT;

@end
@implementation ChartNumberCountView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)awakeFromNib{
    
    [self setUI];
    
}

#pragma mark -  set UI

- (void)setUI{
    
    self.backgroundColor = [UIColor clearColor];
    self.currentCountNumber = 0;
    self.totalNum = 0;
    SX_WEAK
    /************************** 减号 ****************************/
    _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _subButton.frame = CGRectMake(0, 0, Wd,Wd);
    [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"]
                          forState:UIControlStateNormal];
    [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"]
                          forState:UIControlStateDisabled];
    _subButton.tag = 0;
    [[self.subButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        SX_STRONG
        self.currentCountNumber--;
        if (self.NumberChangeBlock) {
            self.NumberChangeBlock(self.currentCountNumber);
        }
        
    }];
    [self addSubview:_subButton];
    
    /************************** 内容 ****************************/
    self.numberTT = [[UITextField alloc]init];
    self.numberTT.userInteractionEnabled = NO;
    self.numberTT.frame = CGRectMake(CGRectGetMaxX(_subButton.frame), 0, Wd*1.5, _subButton.frame.size.height);
    self.numberTT.keyboardType=UIKeyboardTypeNumberPad;
    self.numberTT.text=[NSString stringWithFormat:@"%@",@(0)];
    self.numberTT.backgroundColor = [UIColor whiteColor];
    self.numberTT.textColor = [UIColor blackColor];
    self.numberTT.adjustsFontSizeToFitWidth = YES;
    self.numberTT.textAlignment=NSTextAlignmentCenter;
    self.numberTT.layer.borderColor = RGBA(201, 201, 201, 1).CGColor;
    self.numberTT.layer.borderWidth = 1.3;
    self.numberTT.font= SXFont(17);
    [self addSubview:self.numberTT];
    
    /************************** 加号 ****************************/
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(CGRectGetMaxX(_numberTT.frame), 0, Wd,Wd);
    [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"]
                          forState:UIControlStateNormal];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"]
                          forState:UIControlStateDisabled];
    _addButton.tag = 1;
    [[self.addButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        SX_STRONG
        self.currentCountNumber++;
        if (self.NumberChangeBlock) {
            self.NumberChangeBlock(self.currentCountNumber);
        }
    }];
    
    [self addSubview:_addButton];
    
    /************************** 内容改变 ****************************/
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"UITextFieldTextDidEndEditingNotification" object:self.numberTT] subscribeNext:^(NSNotification *x) {
        SX_STRONG
        UITextField *t1 = [x object];
        NSString *text = t1.text;
        NSInteger changeNum = 0;
   /*     if (text.integerValue>self.totalNum&&self.totalNum!=0) {
            
            self.currentCountNumber = self.totalNum;
            self.numberTT.text = [NSString stringWithFormat:@"%@",@(self.totalNum)];
            changeNum = self.totalNum;
            
        } else*/
            if (text.integerValue<1){
            
            self.numberTT.text = @"1";
            changeNum = 1;
            
        } else {
            
            self.currentCountNumber = text.integerValue;
            changeNum = self.currentCountNumber;
            
        }
        
        if (self.NumberChangeBlock) {
            self.NumberChangeBlock(changeNum);
        }
        
    }];
    
    
    /* 捆绑加减的enable */
    RACSignal *subSignal =  [RACObserve(self, currentCountNumber) map:^id(NSNumber *subValue) {
        return @(subValue.integerValue>1);
    }];
    RACSignal *addSignal =  [RACObserve(self, currentCountNumber) map:^id(NSNumber *addValue) {
        return @(addValue.integerValue<self.totalNum);
    }];
    RAC(self.subButton,enabled)  = subSignal;
    RAC(self.addButton,enabled)  = addSignal;
    /* 内容颜色显示 */
    RACSignal *numColorSignal = [RACObserve(self, totalNum) map:^id(NSNumber *totalValue) {
        return totalValue.integerValue==0?[UIColor redColor]:[UIColor blackColor];
    }];
    RAC(self.numberTT,textColor) = numColorSignal;
    /*  */
    RACSignal *textSigal = [RACObserve(self, currentCountNumber) map:^id(NSNumber *Value) {
        return [NSString stringWithFormat:@"%@",Value];
    }];
    RAC(self.numberTT,text) = textSigal;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
