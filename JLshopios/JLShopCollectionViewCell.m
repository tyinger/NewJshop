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



@end


@implementation JLShopCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
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
    if (self.hotGoodsArray.count >= 2) {
        
        {
            JLGoodModel *model = self.hotGoodsArray[0];
            self.hotGoodsLeftText.text = model.description_Goods;
            NSArray *previewImage = model.previewImgs;
            NSDictionary *dic = [previewImage firstObject];
            NSString *imageURL_left = dic[@"path"];
            
            if (imageURL_left) {
                [self.hotGoodsLeftImage sd_setImageWithURL:[NSURL URLWithString:imageURL_left]];
            }
        }

        
        {
            JLGoodModel *model = self.hotGoodsArray[1];
            self.hotGoodsRightText.text = model.description_Goods;
            NSArray *previewImage = model.previewImgs;
            NSDictionary *dic = [previewImage firstObject];

            NSString *imageURL_right = dic[@"path"];;
            if (imageURL_right) {
                [self.hotGoodsRightImage sd_setImageWithURL:[NSURL URLWithString:imageURL_right]];
            }
        }
    }
    
    
}


@end
