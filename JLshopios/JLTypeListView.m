//
//  JLTypeListView.m
//  JLshopios
//
//  Created by imao on 16/6/12.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLTypeListView.h"
#import "JLShopTypeModel.h"


static CGFloat TypeListButtonWidth = 40;

@interface JLTypeListView ()


@property (nonatomic,strong) NSArray *typeListArray;



@end

@implementation JLTypeListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        //        [self loadAllButtons];
        [self loadTypeListInfo];
        
    }
    return self;
}

-(void)loadTypeListInfo{
    
    NSDictionary *dics = @{@"arg0":@"{\"name\":\"\",\"type\":\"1\",\"id\":\"\",\"level\":\"\",\"firstSeplling\":\"\"}"};
    
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/listClass?" parameters:dics isShowHUD:YES httpToolSuccess:^(id json) {
        NSArray *jsonArray = json;
        NSMutableArray *marray = [[NSMutableArray alloc]init];
        for (NSDictionary *dics in jsonArray) {
            JLShopTypeModel *model = [JLShopTypeModel initWithDictionary:dics];
            [marray addObject:model];
        }
        self.typeListArray = [marray copy];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self loadAllButtons];
        });
        
        
    } failure:^(NSError *error) {
    }];
    
}

-(void)loadAllButtons{
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width/4.0;
    CGFloat offsetX = (swidth - TypeListButtonWidth)/2.0;
    
    for (int i = 0; i<self.typeListArray.count; i++) {
        
        JLShopTypeModel *model = self.typeListArray[i];
        UIButton *button;
        if (i<4) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*i+offsetX, 10, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"guide_page_1"]];
            
            [self addSubview:button];
            
        }else if(4<=i && 7>i) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"guide_page_1"]];
            [self addSubview:button];
        }else if(7 == i){
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            
            [button setBackgroundImage:[UIImage imageNamed:@"home_center_menu_gd"] forState:UIControlStateNormal];
            
            [self addSubview:button];
        }
        
        UILabel *typeText = [[UILabel alloc]init];
        typeText.text = model.name;
        if (7 == i) {
            typeText.text = @"更多";
            
        }
        
        
        [typeText setTextColor:[UIColor darkGrayColor]];
        [typeText setTextAlignment:NSTextAlignmentCenter];
        [typeText setFrame:CGRectMake(-10, TypeListButtonWidth, TypeListButtonWidth+10*2, 15)];
        [typeText setFont:[UIFont systemFontOfSize:12]];
        [button addSubview:typeText];
        
    }
}

@end
