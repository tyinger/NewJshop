//
//  MarsCustomButton.m
//  JLshopios
//
//  Created by 孙鑫 on 16/11/2.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "MarsCustomButton.h"

@implementation MarsCustomButton
- (void)drawRect:(CGRect)rect{
   
    //绘制带箭头的框框
    [self customeDrawWithRect:rect];
}
- (void)customeDrawWithRect:(CGRect)frame{
    CGContextRef ctx =UIGraphicsGetCurrentContext();
  
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
  
      CGContextBeginPath(ctx);
    CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 0.5);
    CGContextSetLineWidth(ctx, 1.0);
    CGFloat origin_x = frame.size.width;
    CGFloat origin_y = frame.size.height-2;
    //A点   左下
    CGFloat origin_A_x = 0;
    CGFloat origin_A_y =origin_y;
    //B   三角的α点
    CGFloat line_B_x = origin_x;
    CGFloat line_B_y = origin_y;
    
    //C  三角的β点，长度给个10
    CGFloat line_C_x =origin_x;
    CGFloat line_C_y = origin_y-10;
    //D  三角的γ 点
    CGFloat line_D_x = origin_x-10;
    CGFloat line_D_y = origin_y;
    
//    
//    CGContextMoveToPoint(ctx, 0, 0);
//    CGContextAddLineToPoint(ctx, line_B_x, line_B_y);
//    CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
//    CGContextFillPath(ctx);
//    CGContextClosePath(ctx);
    
    
     CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, line_B_x, line_B_y);
     CGContextAddLineToPoint(ctx, line_C_x, line_C_y);
     CGContextAddLineToPoint(ctx, line_D_x, line_D_y);
    CGContextClosePath(ctx);
     CGContextSetFillColorWithColor(ctx, [UIColor lightGrayColor].CGColor);
      CGContextFillPath(ctx);
    
    [path moveToPoint:CGPointMake(origin_A_x, origin_A_y)];
    [path addLineToPoint:CGPointMake(line_B_x, line_B_y)];
//     [path addLineToPoint:CGPointMake(line_C_x, line_C_y)];
//     [path addLineToPoint:CGPointMake(line_D_x, line_D_y)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextStrokePath(ctx);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
