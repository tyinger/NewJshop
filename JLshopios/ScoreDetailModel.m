
//
//  ScoreDetailModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/10/17.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ScoreDetailModel.h"

@implementation ScoreDetailModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"Description":@"description"};
}
//- (void)setValue:(id)value forKey:(NSString *)key{
//    if ([key isEqualToString:@"description"]) {
//        self.Description = value;
//    }else{
//        if ([key isEqualToString:@"type"]) {
//             self.type = [NSString stringWithString:value];
//        }else if ([key isEqualToString:@"num"]){
//            self.num = [NSString stringWithString:value];
//        }else{
//            [super setValue:[NSString stringWithFormat:@"%@",value] forKey:key];
//  
//        }
//       
//    }
//}
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
//    
//}
@end
