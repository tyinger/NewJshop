//
//  FYTXGuideFactory.h
//  FYTXGuide
//
//  Created by tiger on 16/5/12.
//  Copyright © 2016年 tiger. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FYTXGEViewProtocol.h"

@interface FYTXGuideFactory : NSObject

+ (id<FYTXGEViewProtocol>)guideView;

@end

