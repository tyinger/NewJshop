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
@property (nonatomic,strong) NSArray *typeArray;//未网络请求时候



@end

@implementation JLTypeListView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        //        [self loadAllButtons];
//        self.typeArray = @[@"便利店",
//                               @"美食",
//                               @"购物",
//                               @"休闲娱乐",
//                               @"美容美发",
//                               @"网吧",
//                               @"KTV",
//                               @"FLAG"];
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
        MYLog(@"wuwangluo");
    }];
    [self loadAllButtons1];
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
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            
            [self addSubview:button];
            
        }else if(4<=i && 7>i) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            [self addSubview:button];
        }else if(7 == i){
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            button.enabled = model ? YES:NO;
            [button setBackgroundImage:[UIImage imageNamed:@"home_center_menu_gd"] forState:UIControlStateNormal];
            
            [self addSubview:button];
        }
        
        UILabel *typeText = [[UILabel alloc]init];
        typeText.text = model.name;
        if (7 == i) {
            typeText.text = @"更多";
            
        }
        
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [typeText setTextColor:[UIColor darkGrayColor]];
        [typeText setTextAlignment:NSTextAlignmentCenter];
        [typeText setFrame:CGRectMake(-10, TypeListButtonWidth, TypeListButtonWidth+10*2, 15)];
        [typeText setFont:[UIFont systemFontOfSize:12]];
        [button addSubview:typeText];
        
    }
}

-(void)loadAllButtons1{
    CGFloat swidth = [UIScreen mainScreen].bounds.size.width/4.0;
    CGFloat offsetX = (swidth - TypeListButtonWidth)/2.0;
    
    for (int i = 0; i<self.typeArray.count; i++) {
        
        UIButton *button;
        if (i<4) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*i+offsetX, 10, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            
            [self addSubview:button];
            
        }else if(4<=i && 7>i) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            [button sd_setBackgroundImageWithURL:nil forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            [self addSubview:button];
        }else if(7 == i){
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-4)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i];
            button.enabled = NO;
            [button setBackgroundImage:[UIImage imageNamed:@"home_center_menu_gd"] forState:UIControlStateNormal];
            
            [self addSubview:button];
        }
        
        UILabel *typeText = [[UILabel alloc]init];
        typeText.text = self.typeArray[i];
        if (7 == i) {
            typeText.text = @"更多";
            
        }
        
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [typeText setTextColor:[UIColor darkGrayColor]];
        [typeText setTextAlignment:NSTextAlignmentCenter];
        [typeText setFrame:CGRectMake(-10, TypeListButtonWidth, TypeListButtonWidth+10*2, 15)];
        [typeText setFont:[UIFont systemFontOfSize:12]];
        [button addSubview:typeText];
        
    }
}


-(void) btnAction:(UIButton *)btn{
        
    self.listBtnBlock(btn.tag);
}

@end
