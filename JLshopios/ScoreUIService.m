//
//  ScoreUIService.m
//  JLshopios
//
//  Created by 孙鑫 on 16/9/21.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ScoreUIService.h"
@interface ScoreUIService()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@end

@implementation ScoreUIService
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView{
    return [[NSAttributedString alloc] initWithString:@"对不起，目前无更多信息"];
}
- (void)setMainTableView:(UITableView *)mainTableView{
    _mainTableView = mainTableView;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.emptyDataSetSource = self;
    _mainTableView.emptyDataSetDelegate = self;
   
    
}
#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.scoreDetailData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.detailTextLabel.textColor = QSCRedColor;
    }
    if (self.viewModel.scoreDetailData.count) {
        cell.textLabel.text = self.viewModel.scoreDetailData[indexPath.row].Description;
        cell.detailTextLabel.text = [self.viewModel.scoreDetailData[indexPath.row].type isEqualToNumber:@1]?[NSString stringWithFormat:@"+%@",self.viewModel.scoreDetailData[indexPath.row].num]:[NSString stringWithFormat:@"-%@",self.viewModel.scoreDetailData[indexPath.row].num];
     
    }
    
    return cell;
}
@end
