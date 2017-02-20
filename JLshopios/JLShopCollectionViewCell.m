//
//  JLShopCollectionViewCell.m
//  JLshopios
//
//  Created by daxiongdi on 16/6/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "JLShopCollectionViewCell.h"
#import "JLGoodModel.h"

@interface JLShopCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *hotGoodsLeftText;
@property (weak, nonatomic) IBOutlet UIImageView *hotGoodsLeftImage;

@property (weak, nonatomic) IBOutlet UILabel *hotGoodsRightText;
@property (weak, nonatomic) IBOutlet UIImageView *hotGoodsRightImage;

@property (nonatomic,strong) NSArray *hotGoodsArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *haohuoHeigh;
@property (weak, nonatomic) IBOutlet UILabel *tuijianLabel;

@property (assign, nonatomic) CGFloat hight;

@end


@implementation JLShopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *yuShouGoodsGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction:)];
    [self.yuShouGoods addGestureRecognizer:yuShouGoodsGes];
    UITapGestureRecognizer *zhidemaiGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction1:)];
    [self.zhidemai addGestureRecognizer:zhidemaiGes];
//    UITapGestureRecognizer *jingxuantuijianGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction1:)];
//    [self.jingxuantuijian addGestureRecognizer:jingxuantuijianGes];
    

    
    [self loadHotGoodsInfo];
}

-(void)loadHotGoodsInfo{
    NSDictionary *dic1 = @{@"begin":@"0"};
    //https://123.56.192.182:8443/app/product/recommendGoods?
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/recommendGoods?" parameters:dic1 isShowHUD:YES httpToolSuccess:^(id json) {
        NSArray *jsonArray = json;
        NSMutableArray *marray = [[NSMutableArray alloc]init];
        for (NSDictionary *dics in jsonArray) {
            JLGoodModel *model = [JLGoodModel initWithDictionary:dics];
            [marray addObject:model];
        }
        self.hotGoodsArray = [marray copy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self setHotGoodsValue];
            
        });
        
    } failure:^(NSError *error) {
    }];
}

-(void)setHotGoodsValue{
    self.tuijianLabel.hidden = YES;
    for (int i = 0; i < self.hotGoodsArray.count; i++) {
        {
            TuiJianView *tView = [[TuiJianView alloc] initWithFrame:CGRectMake((i%2)*self.frame.size.width*0.5, (self.frame.size.width*0.5 + 30)*(i/2)+47, self.frame.size.width*0.5, self.frame.size.width*0.5 + 30)];
            UITapGestureRecognizer *jingxuantuijianGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction1:)];
            tView.tag = i+100;
            [tView addGestureRecognizer:jingxuantuijianGes];
            [self.hotView addSubview:tView];
            JLGoodModel *model = self.hotGoodsArray[i];
            tView.name.text = model.name;
            NSArray *previewImage = model.previewImgs;
            NSDictionary *dic = [previewImage firstObject];
            NSString *imageURL_left = dic[@"path"];
            self.tuijianLabel.hidden = NO;
            if (imageURL_left) {
                
                [tView.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL_left]];
            }
            
        }
    }
    //        {
//            JLGoodModel *model = self.hotGoodsArray[1];
//            self.hotGoodsRightText.text = model.name;
//            NSArray *previewImage = model.previewImgs;
//            NSDictionary *dic = [previewImage firstObject];
//
//            NSString *imageURL_right = dic[@"path"];
//            if (imageURL_right) {
//                [self.hotGoodsRightImage sd_setImageWithURL:[NSURL URLWithString:imageURL_right]];
//            }
//        }
//    }else{
//       self.hotGoodsRightText.hidden = self.hotGoodsRightImage.hidden = self.hotGoodsLeftImage.hidden = self.hotGoodsLeftText.hidden = YES;
//        
//    }

}



- (IBAction)testAction:(id)sender {
    MYLog(@"xxxx");
    [FYTXHub toast:@"敬请期待"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [FYTXHub dismiss];
    });
}

- (void)testAction1:(UIGestureRecognizer *)ges{
//    if (self.hotGoodsArray.count == 0) {
//        [FYTXHub toast:@"敬请期待"];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [FYTXHub dismiss];
//        });
//        return;
//    }
    
        self.tuiJianBlock(self.hotGoodsArray[ges.view.tag-100]);

}

@end
