//
//  OtherListViewController.m
//  JLshopios
//
//  Created by 陈霖 on 16/8/28.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "OtherListViewController.h"
#import "JLShopTypeModel.h"
#import "JLShopsViewController.h"

static CGFloat TypeListButtonWidth = 40;

@interface OtherListViewController ()
@property (nonatomic,strong) NSArray *typeListArray;
@end

@implementation OtherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"更多";
    [self loadTypeListInfo];
}

-(void)loadTypeListInfo{
    
    NSDictionary *dics = @{@"arg0":@"{\"name\":\"\",\"type\":\"1\",\"id\":\"\",\"level\":\"\",\"firstSeplling\":\"\"}"};
    
    [QSCHttpTool get:@"https://123.56.192.182:8443/app/product/listClass?" parameters:dics isShowHUD:YES httpToolSuccess:^(id json) {
        NSArray *jsonArray = json;
        NSMutableArray *marray = [[NSMutableArray alloc]init];
        for (NSDictionary *dics in jsonArray) {
            JLShopTypeModel *model = [JLShopTypeModel initWithDictionary:dics];
            if (model.level == 1) {
                [marray addObject:model];
            }
            
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
    
    for (int i = 7; i<self.typeListArray.count; i++) {
        
        JLShopTypeModel *model = self.typeListArray[i];
        UIButton *button;
        if (i<11) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth * (i - 7) + offsetX, 10, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i+1000];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            
            [self.view addSubview:button];
            
        }else if(11<=i && 15>i) {
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-11)+offsetX, TypeListButtonWidth+10*3, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i+1000];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            [self.view addSubview:button];
        }else{
            button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setFrame:CGRectMake(swidth*(i-15)+offsetX, TypeListButtonWidth+10*9, TypeListButtonWidth, TypeListButtonWidth)];
            [button setTag:i+1000];
            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:model.icon] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icon_loading5"]];
            [self.view addSubview:button];
        }
        
        UILabel *typeText = [[UILabel alloc]init];
        typeText.text = model.name;
        
        [button addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [typeText setTextColor:[UIColor darkGrayColor]];
        [typeText setTextAlignment:NSTextAlignmentCenter];
        [typeText setFrame:CGRectMake(-10, TypeListButtonWidth, TypeListButtonWidth+10*2, 15)];
        [typeText setFont:[UIFont systemFontOfSize:12]];
        [button addSubview:typeText];
    }
}

-(void) btnAction:(UIButton *)btn
{
    
//    [FYTXHub toast:@"敬请期待"];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [FYTXHub dismiss];
//    });
    
#warning 麻烦的做法，有待改进
    HomeListBtnClickYes;
    AppDelegate *app = [UIApplication sharedApplication].delegate;
    app.window.rootViewController = [JLTabMainController shareJLTabVC];
    [JLTabMainController shareJLTabVC].selectedIndex = 2;
    [self.navigationController popToRootViewControllerAnimated:NO];
    QSCNavigationController *s = [[JLTabMainController shareJLTabVC].viewControllers objectAtIndex:2];
    JLShopsViewController *q = s.viewControllers.lastObject;
    q.numRow = btn.tag-1000;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
