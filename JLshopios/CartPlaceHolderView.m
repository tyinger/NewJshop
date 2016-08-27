//
//  CartPlaceHolderView.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "CartPlaceHolderView.h"
#import "LoginStatus.h"
@interface CartPlaceHolderView()
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *quickBuyButton;



@end
@implementation CartPlaceHolderView

- (void)awakeFromNib{
    SX_WEAK
    [RACObserve([LoginStatus sharedManager], login) subscribeNext:^(id x) {
        SX_STRONG
        self.loginView.hidden = [x boolValue];
    }];
    _loginSignal = [self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    _quickSignal = [self.quickBuyButton rac_signalForControlEvents:UIControlEventTouchUpInside];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
