//
//  ShouHuoModel.h
//  JLshopios
//
//  Created by 陈霖 on 16/9/19.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouHuoModel : NSObject

@property (copy, nonatomic) NSString *name;//收货人
@property (copy, nonatomic) NSString *phone;//电话
@property (copy, nonatomic) NSString *detailedAdd;//详细地址
@property (assign, nonatomic) NSInteger userId;//用户id
@property (copy, nonatomic) NSString *isDefault;//是否默认地址
@property (copy, nonatomic) NSString *areaAdds;//区域
@property (assign, nonatomic) NSInteger areaId;//id  列表id

-(ShouHuoModel *)initWithDictionary:(NSDictionary *)dic;
+(ShouHuoModel *)shouhuoWithDictionary:(NSDictionary *)dic;
@end
