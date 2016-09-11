//
//  AddressView.m
//  JLshopios
//
//  Created by 陈霖 on 16/9/11.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "AddressView.h"


@implementation AddressView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createTableView];
    }
    return self;
}

- (void)createTableView{
    self.provinceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width/3, self.height) style:UITableViewStylePlain];
    self.provinceTableView.backgroundColor = [UIColor orangeColor];
    self.provinceTableView.dataSource = self;
    self.provinceTableView.delegate = self;
    [self addSubview:self.provinceTableView];
    
    self.cityTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.provinceTableView.width, self.height) style:UITableViewStylePlain];
    self.cityTableView.backgroundColor = [UIColor cyanColor];
    self.cityTableView.dataSource = self;
    self.cityTableView.delegate = self;
    [self addSubview:self.cityTableView];
    
    self.townTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetMaxX(self.cityTableView.frame), self.height) style:UITableViewStylePlain];
    self.townTableView.backgroundColor = [UIColor magentaColor];
    self.townTableView.dataSource = self;
    self.townTableView.delegate = self;
    [self addSubview:self.townTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    return cell;
}

@end
