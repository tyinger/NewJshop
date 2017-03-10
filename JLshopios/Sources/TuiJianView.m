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
        self.name.frame = CGRectMake(0, frame.size.width, frame.size.width, 50);
        self.priceLabel.frame = CGRectMake(0, frame.size.width+50, frame.size.width, 30);
        [self addSubview:_imageView];
        [self addSubview:_name];
        [self addSubview:_priceLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textColor = QSCRedColor;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _priceLabel;
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
        _name.textAlignment = NSTextAlignmentLeft;
        _name.numberOfLines = 2;
        _name.font = [UIFont systemFontOfSize:15];
    }
    return _name;
}

@end
