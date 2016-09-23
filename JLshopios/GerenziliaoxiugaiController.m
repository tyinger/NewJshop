//
//  GerenziliaoxiugaiController.m
//  JLshopios
//
//  Created by 洪彬 on 16/9/10.
//  Copyright © 2016年 feng. All rights reserved.
//

#import "GerenziliaoxiugaiController.h"
#import "ASBirthSelectSheet.h"

@interface GerenziliaoxiugaiController()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic,strong) UITableView *mainTableview;
@property (nonatomic,copy) NSArray *arr;


@property (nonatomic,strong) UIImageView *Nimage;
@property (nonatomic,strong) UITextField *textF;
@property (nonatomic,strong) UISegmentedControl *seg;
@property (nonatomic,strong) UILabel *briLabel;

@end

@implementation GerenziliaoxiugaiController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.arr = @[@"头像",@"昵称",@"性别",@"生日"];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.mainTableview];
    [self.mainTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.offset(0);
    }];
    
    UIView *b = [[UIView alloc] init];
    b.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:b];
    [b mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.right.left.offset(0);
        make.height.mas_equalTo(@70);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.layer.cornerRadius = 8;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [b addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.insets(UIEdgeInsetsMake(15, 15, 15, 15));
    }];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc] init];
    ges.numberOfTapsRequired = 1;
    ges.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:ges];
    @weakify(self);
    [[ges rac_gestureSignal] subscribeNext:^(id x) {
        
        @strongify(self);
        [self.view endEditing:YES];
    }];
}

- (UITableView *)mainTableview{
    
    if (!_mainTableview) {
        
        _mainTableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mainTableview.delegate = self;
        _mainTableview.dataSource = self;
        _mainTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _mainTableview;
}

- (void)btnAction:(UIButton*)b{
    
    [FYTXHub progress:@"正在上传"];
    [[RACSignal combineLatest:@[[self uploadInfo],[self uploadImageView]]] subscribeNext:^(id x) {
        
        
    } error:^(NSError *error) {
        
        [FYTXHub dismiss];
        [FYTXHub toast:@"上传失败"];
    }];
}
- (RACSignal *)uploadImageView{
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        NSData *imageData = UIImageJPEGRepresentation([self imageCompressForWidth:self.Nimage.image targetWidth:400], 0.01);
        NSString *imageBase64 = [imageData base64Encoding];
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:imageBase64 forKey:@"imgFile"];
        [dic setObject:[LoginStatus sharedManager].idStr forKey:@"userId"];
//        [QSCHttpTool uploadImagePath:@"https://123.56.192.182:8443/app/user/updateHeadImg" params:dic kHeadimgName:nil image:nil success:^(id JSON) {
//            
//            
//        } failure:^(NSError *error) {
//            
//            
//        }];
        [QSCHttpTool post:@"https://123.56.192.182:8443/app/user/updateHeadImg" parameters:dic isShowHUD:NO httpToolSuccess:^(id json) {
            
            
        } failure:^(NSError *error) {
            
            
        }];
        
        return nil;
    }] replayLazily];
}
- (RACSignal *)uploadInfo{
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        
        
        return nil;
    }] replayLazily];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        return 80;
    }
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = self.arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        
        self.Nimage = [[UIImageView alloc] init];
        self.Nimage.contentMode = UIViewContentModeScaleAspectFit;
        self.Nimage.layer.masksToBounds = YES;
        [self.Nimage sd_setImageWithURL:[NSURL URLWithString:[LoginStatus sharedManager].headPic]];
        [cell addSubview:self.Nimage];
        [self.Nimage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.offset(-35);
            make.width.height.mas_equalTo(@70);
            make.centerY.offset(0);
        }];
    }
    if (indexPath.row == 1) {
        
        self.textF = [[UITextField alloc] init];
        self.textF.borderStyle = UITextBorderStyleNone;
        self.textF.text = [LoginStatus sharedManager].name;
        self.textF.placeholder = @"请输入喜欢的用户名";
        [cell addSubview:self.textF];
        [self.textF mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.offset(0);
            make.left.offset(60);
            make.right.offset(-30);
        }];
    }
    if (indexPath.row == 2) {
        
        self.seg = [[UISegmentedControl alloc] initWithItems:@[@"男",@"女"]];
        self.seg.selectedSegmentIndex = 0;
        self.seg.tintColor = [UIColor redColor];
        [cell addSubview:self.seg];
        [self.seg mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.offset(0);
            make.left.offset(60);
            make.height.mas_equalTo(@25);
            make.width.mas_equalTo(@60);
        }];
    }
    if (indexPath.row == 3) {
        
        self.briLabel = [UILabel new];
        self.briLabel.textColor = [UIColor blackColor];
        if ([LoginStatus sharedManager].birthday == nil || [[LoginStatus sharedManager].birthday isEqualToString:@""]) {
            
            self.briLabel.text = @"0000-00-00";
        }else{
            
            self.briLabel.text = [LoginStatus sharedManager].birthday;
        }
        self.briLabel.font = [UIFont systemFontOfSize:15];
        [cell addSubview:self.briLabel];
        [self.briLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.offset(0);
            make.left.offset(60);
        }];
    }
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        UIActionSheet* actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择文件来源" delegate:self cancelButtonTitle:@"取消"  destructiveButtonTitle:nil otherButtonTitles:@"照相机",@"本地相簿",nil];
        [actionSheet showInView:self.view];
    }
    if (indexPath.row == 3) {
        
        ASBirthSelectSheet *datesheet = [[ASBirthSelectSheet alloc] initWithFrame:self.view.bounds];
        datesheet.selectDate = @"2000-01-01";
        datesheet.GetSelectDate = ^(NSString *dateStr) {
            
            self.briLabel.text = dateStr;
        };
        [self.view addSubview:datesheet];
    }
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0://照相机
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.editing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.videoQuality = UIImagePickerControllerQualityTypeLow;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        case 1://本地相簿
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.allowsEditing = YES;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
            break;
            
        default:
            break;
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.Nimage.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth
{
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0,0,targetWidth, targetHeight)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
