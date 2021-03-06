//
//  AddressController.h
//  JLshopios
//
//  Created by 陈霖 on 16/9/9.
//  Copyright © 2016年 feng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressController : UIViewController
@property (nonatomic, copy) NSString *firstLabelText;
@property (nonatomic, copy) NSString *secondLabelText;
@property (nonatomic, copy) NSString *thirdLabelText;
@property (nonatomic, copy) NSString *fourthLabelText;
@property (nonatomic, assign) NSInteger addrId;//列表地址id
@property (nonatomic, copy) NSString *isDefualtFlag;
@property (nonatomic, copy) NSString *areaId;//行政区号
@property (nonatomic, assign) BOOL isModefy;//是否是编辑修改进来的
@end
