//
//  FYTXGuideFactory.m
//  FYTXGuide
//
//  Created by tiger on 16/5/12.
//  Copyright © 2016年 tiger. All rights reserved.
//

#import "FYTXGuideFactory.h"
#import "FYTXGEView.h"
#import "FYTXGuideImageName.h"

@implementation FYTXGuideFactory

+ (id<FYTXGEViewProtocol>)guideView{
    
    FYTXGEView *result = [[FYTXGEView alloc] init];
    result.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    NSArray *images = @[[UIImage imageNamed:FYTXGuide_GuideImage_1],
                        [UIImage imageNamed:FYTXGuide_GuideImage_2],
                        [UIImage imageNamed:FYTXGuide_GuideImage_3]
                        ];
    [result loadImageWithArray:images];    
    return result;
}

@end


