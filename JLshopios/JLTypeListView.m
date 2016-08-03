//
//  JLTypeListView.m
//  JLshopios
//
//  Created by imao on 16/6/12.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLTypeListView.h"


static CGFloat TypeListButtonWidth = 50;

@interface JLTypeListView ()

@property (nonatomic,strong) NSArray *imageArray;




@end

@implementation JLTypeListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageArray = @[@"guide_page_1",@"guide_page_1",@"guide_page_1",@"guide_page_1",@"guide_page_1",@"guide_page_1",@"guide_page_1",@"guide_page_1",@"guide_page_1"];
        
        [self loadAllButtons];
        
    }
    return self;
}



-(void)loadAllButtons{
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width/4.0;
    CGFloat offsetX = (swidth - TypeListButtonWidth)/2.0;
    
    for (int i = 0; i<self.imageArray.count; i++) {
        if (i<4) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*i+offsetX, 10, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button setBackgroundImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
            [self addSubview:button];
        }else if(4<=i && 8>i) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*2, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button setBackgroundImage:[UIImage imageNamed:self.imageArray[i]] forState:UIControlStateNormal];
            [self addSubview:button];
        }
       
        
        
    }
}

@end
