//
//  ToolClass.h
//  JLshopios
//
//  Created by 孙鑫 on 16/8/27.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToolClass : NSObject<UIAlertViewDelegate>

+ (void)showMSG:(NSString *)msg :(void(^)(void))action;

@end
