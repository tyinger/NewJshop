//
//  FYTXGEView.h
//  FYTXGuide
//
//  Created by tiger on 15/6/10.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FYTXGEViewProtocol.h"



@interface FYTXGEView : UIView<FYTXGEViewProtocol>


-(void) loadImageWithArray:(NSArray *)images;

@end
