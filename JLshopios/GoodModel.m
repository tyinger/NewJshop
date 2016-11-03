//
//  GoodModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/8/23.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "GoodModel.h"

@implementation GoodModel
//暂时不用
- (instancetype)initWithData:(id)data{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:data];
    }
    return self;
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"id":@"Id",@"Id":@"id"};
}

-(GoodModel *)initWithDictionary:(NSDictionary *)dic{
    if(self=[super init]){
        self.Id = [dic[@"id"] string];
        
    }
    return self;
}
//- (void)setValue:(id)value forKey:(NSString *)key{
//    if ([key isEqualToString:@"id"]) {
//        self.Id = value;
//    }else{
//        [super setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
//    }
//    
//}
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"undefine key %@",key);
}
@end
