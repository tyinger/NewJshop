//
//  ButtonWithBadgeValue.m
//  ButtonWithBadgeValue
//
//  Created by QSQ on 14/11/26.
//  Copyright (c) 2014年 QSQ. All rights reserved.
//

#import "ButtonWithBadgeValue.h"

@implementation ButtonWithBadgeValue


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat conterX = ((int)self.centerX)?self.centerX:rect.size.width - 30;
    CGFloat conterY = ((int)self.centerY)?self.centerY:15;
    CGFloat radius = ((int)self.radius)?self.radius:10;
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddArc(currentContext, conterX, conterY, radius, 0, M_PI*2, 1);
    CGContextSetFillColorWithColor(currentContext, [UIColor redColor].CGColor);
    CGContextFillPath(currentContext);
    
    NSString *badgeValue = self.badgeValue;
    UIFont *font = [UIFont boldSystemFontOfSize:12];
    CGSize stringSize = [badgeValue boundingRectWithSize:CGSizeMake(radius*2, radius*2) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjects:@[font] forKeys:@[NSFontAttributeName]] context:nil].size;
    
    [badgeValue drawInRect:CGRectMake(conterX - stringSize.width/2,conterY - stringSize.height/2,stringSize.width,stringSize.height) withAttributes:[NSDictionary dictionaryWithObjects:@[font,[UIColor whiteColor]] forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]]];
}


@end
