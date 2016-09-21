//
//  FollowGoodModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "FollowGoodModel.h"

@implementation FollowGoodModel
- (instancetype)initWithData:(id)data{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:data];
    }
    return self;
}
- (void)setValue:(id)value forKey:(NSString *)key{
    if ([key isEqualToString:@"description"]) {
        self.Description = value;
    }else{
        [super setValue:value forKey:key];
    }
}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"%@",key);
}
@end
