//
//  ShangjiaViewController.m
//  JLshopios
//
//  Created by 洪彬 mu' y on 16/8/13.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "ShangjiaViewController.h"
#import "AddressController.h"

//按钮TAG范围：100-200；
//textView的tag范围在：200-300
//label 的tag范围在：300-400

static const CGFloat kBottomHeight = 60;
@interface ShangjiaViewController ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

/** 列表 */
@property (nonatomic , strong) UITableView *addressTableView;
/** 底部添加按钮 */
@property (nonatomic , strong) UIButton *addressBtn;
/** 底部白色背景 */
@property (nonatomic , strong) UIView *whiteBackGroundView;
/** footVIew */
@property (nonatomic , strong) UIView *myFootView;

@end

@implementation ShangjiaViewController
{
    NSTimer *_timer;
}
- (void)viewDidAppear:(BOOL)animated{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(timer:) userInfo:nil repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_timer invalidate];
    _timer = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self whiteBackGroundView];
    _imagePickerController = [[UIImagePickerController alloc] init];
    _imagePickerController.delegate = self;
    _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera | UIImagePickerControllerSourceTypePhotoLibrary;

    [self addressTableView];
    
}

- (UIView *)whiteBackGroundView
{
    if (!_whiteBackGroundView) {

        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height - kBottomHeight - 64, kDeviceWidth, kBottomHeight)];
        view.backgroundColor = [UIColor grayColor];
        [self.view addSubview:view];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"+ 新增地址" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        button.titleLabel.textAlignment = kCTTextAlignmentCenter;
        button.backgroundColor = [UIColor redColor];
        [button addTarget:self action:@selector(addAddressAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(view).offset(-10);
            make.left.equalTo(view).offset(20);
            make.right.equalTo(view).offset(-20);
            make.top.equalTo(view).offset(10);
        }];
        self.addressBtn = button;
        self.whiteBackGroundView = view;
        
    }
    return _whiteBackGroundView;
}

- (UITableView *)addressTableView
{
    if (!_addressTableView) {
        
        _addressTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, self.view.height - 64) style:UITableViewStylePlain];
        
        _addressTableView.dataSource = self;
        _addressTableView.delegate = self;
        _addressTableView.bounces = NO;
        _addressTableView.tableFooterView = self.myFootView;
        [self.view addSubview:_addressTableView];
//        [_addressTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view).offset(0);
//            make.bottom.equalTo(self.whiteBackGroundView.mas_top).offset(0);
//            make.left.equalTo(self.view.mas_left).offset(0);
//            make.right.equalTo(self.view.mas_right).offset(0);
//        }];
    }
    return _addressTableView;
}

-(UIView *)myFootView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 80)];
//    view.backgroundColor = [UIColor yellowColor];
    
    UIButton *agreeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    agreeBtn.frame = CGRectMake(0, 0, 40, 40);
    [agreeBtn setImage:[UIImage imageNamed:@"xn_circle_normal"] forState:UIControlStateNormal];
    [agreeBtn setImage:[UIImage imageNamed:@"xn_circle_select"] forState:UIControlStateSelected];
    agreeBtn.tag = 102;
    [agreeBtn addTarget:self action:@selector(agreeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, kDeviceWidth, 40)];
    label.text = @"同意用啥商家注册协议";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 2)];
    [label setAttributedText:str];
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PushToAgreeDelegate:)];
    [label addGestureRecognizer:tapGes];
    
    //底部分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 40, kDeviceWidth, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    commitButton.frame = CGRectMake(10, 45, kDeviceWidth - 20, 30);
    commitButton.tag = 101;
    [commitButton setTitle:@"提交" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    commitButton.enabled = NO;
    commitButton.layer.masksToBounds = YES;
    commitButton.layer.cornerRadius = 5;
    commitButton.backgroundColor = [UIColor lightGrayColor];
    
    //添加到footView
    [view addSubview:label];
    [view addSubview:agreeBtn];
    [view addSubview:lineView];
    [view addSubview:commitButton];
    return view;
}

#pragma mark -----tableView Delegate And Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
    switch (indexPath.row) {
        case 0:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  为必填项";
            label.textColor = [UIColor redColor];
            [cell addSubview:label];
        }
            break;
        case 1:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  商户名称";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.tag = 201;
            
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 2:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  经营范围";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            [cell addSubview:label];
        }
            break;
        case 3:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  所在城市";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            [cell addSubview:label];
        }
            break;
        case 4:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  详细地址";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.tag = 202;
            
            [cell addSubview:filed];
            
            [cell addSubview:label];
        }
            break;
        case 5:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  联系人";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.tag = 203;
            
            [cell addSubview:filed];
            
            [cell addSubview:label];
        }
            break;
        case 6:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  联系电话";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.tag = 204;
            
            [cell addSubview:filed];
            
            [cell addSubview:label];
        }
            break;
        case 7:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 40)];
            label.text = @"*  营业执照";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.editable = NO;
            filed.tag = 205;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
            [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 8:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
            label.text = @"*  身份证正面照片";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.editable = NO;
            filed.tag = 206;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
            [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 9:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
            label.text = @"*  身份证反面照片";
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 3)];
            [label setAttributedText:str];
            
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame) - 40, 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.editable = NO;
            filed.tag = 207;
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(CGRectGetMaxX(filed.frame), 0, 40, 40);
            [btn setImage:[UIImage imageNamed:@"woshishangjia"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(photoAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell addSubview:btn];
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        case 10:
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 150, 40)];
            label.text = @"   我在其他平台商铺";
//
            UITextView *filed = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label.frame), 1.5, kDeviceWidth - CGRectGetMaxX(label.frame), 40)];
            filed.font = [UIFont systemFontOfSize:17];
            filed.delegate = self;
            filed.tag = 208;
            
            UILabel *placeLabel = [[UILabel alloc] initWithFrame:filed.frame];
            placeLabel.x = 0;
            placeLabel.y = -1;
            placeLabel.text = @" 填写店铺连接";
            placeLabel.textColor = [UIColor lightGrayColor];
            placeLabel.tag = 301;
            [filed addSubview:placeLabel];
            
            [cell addSubview:filed];
            [cell addSubview:label];
        }
            break;
        
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark -- button Action
- (void)addAddressAction:(UIButton *)btn
{
    Class class = NSClassFromString(@"AddressController");
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = @"新建收货地址";
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}

- (void)agreeAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)PushToAgreeDelegate:(UITapGestureRecognizer *)tap{
    MYLog(@"我就是不跳这么滴");
}

- (void)photoAction:(UIButton *)btn{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"上传照片" message:@"" preferredStyle:0];
    
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.cameraOverlayView.userInteractionEnabled = YES;
        _imagePickerController.showsCameraControls = YES;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
        
    }];
    
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:_imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        
        [alert addAction:action2];
        [alert addAction:action3];
        
        [self presentViewController:alert animated:YES completion:nil];
    }

}

- (void)timer:(NSTimer *)timer{
    UIButton *btn1 = [self.view viewWithTag:101];//提交按钮
    UIButton *btn2 = [self.view viewWithTag:101];//协议同意按钮
    
    UITextView *textView1 = [self.view viewWithTag:201];//商户名称
    UITextView *textView2 = [self.view viewWithTag:202];//详细地址
    UITextView *textView3 = [self.view viewWithTag:203];//联系人
    UITextView *textView4 = [self.view viewWithTag:204];//联系电话
    UITextView *textView5 = [self.view viewWithTag:205];//营业执照
    UITextView *textView6 = [self.view viewWithTag:206];//身份证正面
    UITextView *textView7 = [self.view viewWithTag:207];//身份证反面
//    UITextView *textView8 = [self.view viewWithTag:208];
    
    if (![textView1.text isEqualToString:@""] && ![textView2.text isEqualToString:@""] && ![textView3.text isEqualToString:@""] && ![textView4.text isEqualToString:@""] && ![textView5.text isEqualToString:@""] && ![textView6.text isEqualToString:@""] && ![textView7.text isEqualToString:@""] && btn2.selected) {
        btn1.enabled = YES;
        [btn1 setTitle:@"提交" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor redColor];
    }else{
        btn1.enabled = NO;
        [btn1 setTitle:@"提交" forState:UIControlStateNormal];
        [btn1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        btn1.backgroundColor = [UIColor lightGrayColor];
    }
}


#pragma mark - TextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView{
    MYLog(@"开始了");
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    MYLog(@"结束了");
}

- (void)textViewDidChange:(UITextView *)textView{
    if(textView.tag == 208 && ![textView.text isEqualToString:@""]){
        UILabel *label = [self.view viewWithTag:301];
        label.text = @"";
    }else{
        UILabel *label = [self.view viewWithTag:301];
        label.text = @" 填写店铺连接";
    }
}


/**
 *  选择完照片后调用的方法
 *
 *
 *  @param info   所有相片的信息都在这个字典
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //从字典key获取image的地址
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
//    self.imageView.image = image;
    MYLog(@"选完照片了");
    
    
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
