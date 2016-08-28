//
//  ToolClass.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ToolClass.h"
static char alertKey;
@interface ToolClass()


@end
@implementation ToolClass
+ (void)showMSG:(NSString *)msg :(void (^)(void))action{
    UIAlertView * av = [[UIAlertView alloc] initWithTitle:@"提示" message:msg delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    objc_setAssociatedObject(self, &alertKey, action, OBJC_ASSOCIATION_COPY);
    [av show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex !=0) {
        void (^action)(void) = objc_getAssociatedObject(self, &alertKey);
        action?action():nil;
    }
}
@end
