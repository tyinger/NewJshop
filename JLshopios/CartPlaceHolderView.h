//
//  CartPlaceHolderView.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/25.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CartPlaceHolderView : UIView
{
    @public
    RACSignal * _loginSignal;
    RACSignal * _quickSignal;
}
//登录信号
@property (nonatomic, strong, readonly) RACSignal * loginSignal;
//秒杀信号
@property (nonatomic, strong, readonly) RACSignal * quickSignal;
@end
