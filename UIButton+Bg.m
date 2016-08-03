//
//  UIButton+Bg.m
//  MaiQuan
//
//  Created by apple-zhmc01 on 14-2-10.
//  Copyright (c) 2014年 王圆的Mac. All rights reserved.
//

#import "UIButton+Bg.h"
#import "NSString+File.h"

@implementation UIButton (Bg)
- (CGSize)setAllStateBg:(NSString *)icon
{
    UIImage *normal = [UIImage resizedImage:icon];
    UIImage *highlighted = [UIImage resizedImage:[icon filenameAppend:@"_highlighted"]];
    
    [self setBackgroundImage:normal forState:UIControlStateNormal];
    [self setBackgroundImage:highlighted forState:UIControlStateHighlighted];
    return normal.size;
}
@end
