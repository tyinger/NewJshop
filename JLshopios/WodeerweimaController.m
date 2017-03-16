//
//  WodeerweimaController.m
//  JLshopios
//
//  Created by 洪彬 on 16/9/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "WodeerweimaController.h"

#import "WXApi.h"

@implementation WodeerweimaController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请扫描我的二维码，轻松注册";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.offset(30);
    }];
    
    UIImageView *image = [[UIImageView alloc] init];
    image.userInteractionEnabled = YES;
    image.contentMode = UIViewContentModeScaleAspectFit;
    [image sd_setImageWithURL:[NSURL URLWithString:[LoginStatus sharedManager].recommendCodePic]];
    [self.view addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_equalTo(@300);
        make.centerY.centerX.offset(0);
    }];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gesAction:)];
    [image addGestureRecognizer:ges];
    
    UILabel *tip = [[UILabel alloc] init];
    tip.text = @"点击分享";
    tip.font = [UIFont systemFontOfSize:16];
    tip.textColor = [UIColor blackColor];
    [tip sizeToFit];
    [self.view addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.offset(0);
        make.top.equalTo(image.mas_bottom).offset(30);
    }];
}

- (void)gesAction:(UIGestureRecognizer *) ges{
    
    if (![WXApi isWXAppInstalled]) {
        return;
    }
    
    //创建发送对象实例
    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
    sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
    
    //创建分享内容对象
    WXMediaMessage *urlMessage = [WXMediaMessage message];
    urlMessage.title = @"邀请加入";//分享标题
    urlMessage.description = @"您收到了一份好友的邀请";//分享描述
    
    //创建多媒体对象
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = [NSString stringWithFormat:@"http://365yongsha.com/app/user/registerPage?recommendCode=%@",[LoginStatus sharedManager].recommendCode];//分享链接
    
    //完成发送对象实例
    urlMessage.mediaObject = webObj;
    sendReq.message = urlMessage;
    
    //发送分享信息
    [WXApi sendReq:sendReq];
}

@end
