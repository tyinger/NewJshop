//
//  WalletHeaderView.h
//  JLshopios
//
//  Created by 孙鑫 on 16/9/6.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WalletHeaderView : UIView
{
    @public
    UIButton * _payButton;
}
@property (nonatomic, copy) NSString * userablemoney;
@property (nonatomic, copy) NSString * totalprofit;
@property (nonatomic, strong) UIButton * payButton;
@end
