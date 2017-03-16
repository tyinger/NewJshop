//
//  AppDelegate+FYTXEntrance.m
//  FYTXMain
//
//  Created by tiger on 15/6/12.
//  Copyright (c) 2015年 tiger. All rights reserved.
//

#import "AppDelegate+FYTXEntrance.h"
//#import "FYTXMainNavigationController.h"
#import "JLTabMainController.h"
#import "JLHomeViewController.h"

#import "JLGuideViewController.h"
#import "FYTXGuide.h"

#import "JKCountDownButton.h"

#import "JLShopModel.h"
#import "DetailsViewController.h"
#import "ShopDetailController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate(FYTXEntrance)


-(void) loadAppGuide
{
    [self loadNotice];
    //开屏页
//    self.window.rootViewController = (UIViewController *)[FYTXFlashFactory flashView];
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[JLTabMainController alloc]init];
    
    if ([FYTXGuide isHiddenFYTXGuide]) {
        
        self.window.rootViewController = [[JLTabMainController alloc]init];
    }else{
        
        self.window.rootViewController = [[JLGuideViewController alloc]init];
    }
    [self.window makeKeyAndVisible];
    [self loadADView];
}

-(void)loadNotice{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(jumpToMain) name:@"JLShopGuideFinishGoToMain" object:nil];
}

-(void)jumpToMain{
    self.window.rootViewController = [[JLTabMainController alloc]init];

}

- (void)loadADView{
    
    NSDictionary *dic = @{@"adType":@"3"};
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/ad/getAdResource?" parameters:dic isShowHUD:NO httpToolSuccess:^(id json) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self loadADViewUIwithJson:json];
        });
    } failure:^(NSError *error) {
        
        
    }];
}

- (void)loadADViewUIwithJson:(NSArray *) json{
    
//    {
//        adId = 1;
//        id = 85;
//        image = "http://123.56.192.182/http_resource/image/ad/20170312134541848380.png";
//        info = "iu\U4e0d";
//        resourceType = 0;
//        url = 2557;
//    }
//    JKCountDownButton *btn;
    if ([json isKindOfClass:[NSArray class]]) {
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[json objectAtIndex:0]];
        JLShopModel *model = [JLShopModel initWithDictionary:dic];
        self.model = model;
        self.backView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        self.backView.backgroundColor = [UIColor whiteColor];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.borderColor = [UIColor whiteColor];
        imageView.userInteractionEnabled = YES;
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.model.image]]];
        [[UIApplication sharedApplication].keyWindow addSubview:self.backView];
        [self.backView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.edges.offset(0);
        }];
        
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
        [imageView addGestureRecognizer:ges];
        
        @weakify(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            @strongify(self);
            [self.backView removeFromSuperview];
        });
    }
}

- (void)gesAction:(UIGestureRecognizer *)ges{
    
    [self.backView removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"jumptoother" object:self.model];
}















































@end
