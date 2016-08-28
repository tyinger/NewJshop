//
//  UIButton+CustomBadge.m
//
//  Copyright (c) 2012 Alessandro Calzavara
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "UIButton+CustomBadge.h"

#import <objc/runtime.h>

static char const * const CustomBadgeTagKey = "ObjectTag";

@implementation UIButton (CustomBadge)

@dynamic customBadge;

- (id)customBadge
{
    return objc_getAssociatedObject(self, CustomBadgeTagKey);
}

- (void)setCustomBadge:(id)newObjectTag
{
    objc_setAssociatedObject(self, CustomBadgeTagKey, newObjectTag, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



- (void)setBadge:(CustomBadge *)badge
{
    if (self.customBadge)
        [self.customBadge removeFromSuperview];
    
    self.customBadge = badge;
    
    if (self.customBadge) {
        self.customBadge.frame = CGRectMake(
                                            50,
                                            0,
                                            self.customBadge.frame.size.width,
                                            self.customBadge.frame.size.height
                                            );
        
        [self.customBadge setUserInteractionEnabled:NO];
        
        [self addSubview:self.customBadge];
        self.clipsToBounds = NO;
    }
}

- (void)setBadgeWithNumber:(NSNumber *)number
{
    CustomBadge *customBadge = nil;
    
    if ([number integerValue] != 0)
    {
        customBadge = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%@", number]
                                         withStringColor:[UIColor whiteColor]
                                          withInsetColor:[UIColor redColor]
                                          withBadgeFrame:YES
                                     withBadgeFrameColor:[UIColor whiteColor]
                                               withScale:1.0
                                             withShining:YES];
    }
    
    [self setBadge:customBadge];
}

- (void)setBadgeWithString:(NSString *)string
{
    CustomBadge * customBadge = [CustomBadge customBadgeWithString:string
                                                   withStringColor:[UIColor whiteColor]
                                                    withInsetColor:[UIColor redColor]
                                                    withBadgeFrame:YES
                                               withBadgeFrameColor:[UIColor whiteColor]
                                                         withScale:1.0
                                                       withShining:YES];
    [self setBadge:customBadge];
}

@end
