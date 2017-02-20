//
//  TuiJianView.m
//  JLshopios
//
//  Created by mymac on 17/2/15.
//  Copyright © 2017年 feng. All rights reserved.
//

#import "TuiJianView.h"

@implementation TuiJianView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.width);
        self.name.frame = CGRectMake(0, frame.size.width, frame.size.width, 30);
        [self addSubview:_imageView];
        [self addSubview:_name];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

-(UILabel *)name{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textAlignment = NSTextAlignmentCenter;
    }
    return _name;
}

@end
