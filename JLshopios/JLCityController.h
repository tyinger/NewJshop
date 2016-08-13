//
//  JLCityController.h
//  JLshopios
//
//  Created by daxiongdi on 16/8/5.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol JLCityControllerDelegate <NSObject>

-(void)chooseCity:(NSString *)city;


@end



@interface JLCityController : UIViewController


@property (nonatomic,weak) id<JLCityControllerDelegate> delegate;





@end
