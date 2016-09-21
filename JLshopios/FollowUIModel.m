//
//  FollowUIModel.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/8.
//  Copyright © 2016年 feng. All rights reserved.
//
static NSString * kCellGood = @"FollowGoodTableViewCell";
static NSString * kCellShop = @"FollowGoodTableViewCell";
#import "FollowUIModel.h"
#import "FollowGoodTableViewCell.h"
@interface FollowUIModel()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
{
    VCType _type;
    NSInteger pageGood : 1;
    NSInteger pageShop : 1;
}
@end

@implementation FollowUIModel
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableView * cell;
    if(_type == VCTypeGood){
        cell = [tableView dequeueReusableCellWithIdentifier:kCellGood];
        if(self.viewModel.followGoodData.count){
            ((FollowGoodTableViewCell*)cell).model = self.viewModel.followGoodData[indexPath.row];
        }
    }//商品CELL
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _type==VCTypeGood?self.viewModel.followGoodData.count:self.viewModel.followShopData.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * ID;
    ID = _type == VCTypeGood?self.viewModel.followGoodData[indexPath.row].goodsId:self.viewModel.followShopData[indexPath.row].goodsId;
    [[self.viewModel goToDetailWithID:ID] subscribeCompleted:^{
        
    }];
    
}
- (void)setMainTableView:(UITableView *)mainTableView{
    _mainTableView = mainTableView;
    
    [_mainTableView registerNib:[UINib nibWithNibName:kCellGood bundle:nil] forCellReuseIdentifier:kCellGood];
     [_mainTableView registerNib:[UINib nibWithNibName:kCellShop bundle:nil] forCellReuseIdentifier:kCellShop];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.emptyDataSetSource = self;
    _mainTableView.emptyDataSetDelegate = self;
    
    _mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[self.viewModel getData:_type andPage:1] subscribeCompleted:^{
               [_mainTableView.mj_header endRefreshing];
            [_mainTableView reloadData];
            
        }];
    }];
    _mainTableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        NSInteger page = _type == VCTypeGood?pageGood:pageShop;
        [[self.viewModel getData:_type andPage:page+1] subscribeCompleted:^{
          
            if (self.viewModel.followGoodData.count<=20&&_type==0) {
                   [_mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            if (self.viewModel.followShopData.count<=20&&_type==1) {
                [_mainTableView.mj_footer endRefreshingWithNoMoreData];
            }
            [_mainTableView.mj_footer endRefreshing];
         
        }];
    }];
}
- (void)reloadData:(VCType)type{
    _type = type;
    [self.mainTableView reloadData];
}
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"还没有关注，快去关注吧"];
}
@end
