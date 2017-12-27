//
//  Com_imgAdd_DetailViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Com_imgAdd_DetailViewController.h"
#import "FBTextField.h"
#import "UITextField+Tool.h"
#import "LDImagePicker.h"
#import "FBButton.h"
#import "FBWebUrlViewController.h"
#import <UIImageView+WebCache.h>
@interface Com_imgAdd_DetailViewController ()<LDImagePickerDelegate>
{
    UIImageView *iV_img;

    FBTextField *TF_title;
    FBTextField *TF_url;
    UserModel *user;
    FBButton *B_web;
    
}

@end

@implementation Com_imgAdd_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.navigationItem.title =@"滚动图图片";
    self.automaticallyAdjustsScrollViewInsets=NO;
    iV_img = [[UIImageView alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30,(DEVICE_WIDTH-30)/2.0)];
    [self.view addSubview:iV_img];
    iV_img.userInteractionEnabled = YES;
    UITapGestureRecognizer  *tap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    iV_img.layer.borderWidth=1;
    iV_img.layer.borderColor =[UIColor redColor].CGColor;
    [iV_img addGestureRecognizer:tap];
    
    
    TF_title =[[FBTextField alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height+(DEVICE_WIDTH-30)/2.0+10, DEVICE_WIDTH-30, 40)];
    [self.view addSubview:TF_title];
    TF_title.placeholder =@"图片的标题";
    [TF_title setTextFieldInputAccessoryView];
    
    TF_url =[[FBTextField alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(TF_title.frame)+10, DEVICE_WIDTH-30, 40)];
    [self.view addSubview:TF_url];
    TF_url.placeholder =@"图片指向的网址";
    [TF_url setTextFieldInputAccessoryView];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(tijiaoClick)];
    [self.navigationItem setRightBarButtonItem:right];
    if (_model==nil) {
        iV_img.image = [[UIImage imageNamed:@"add_eqd2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else
    {
        [iV_img sd_setImageWithURL:[NSURL URLWithString:_model.imageUrl] placeholderImage:[UIImage imageNamed:@"add_eqd2"]];
        TF_title.text =_model.title;
        TF_url.text =_model.Url;
        right.title =@"修改";
    }

    
    B_web =[FBButton buttonWithType:UIButtonTypeSystem];
    B_web.frame= CGRectMake(15, CGRectGetMaxY(TF_url.frame)+10, DEVICE_WIDTH-30, 40);
    [self.view addSubview:B_web];
    [B_web setTitle:@"预览网址" titleColor:[UIColor whiteColor] backgroundColor:EQDCOLOR font:[UIFont systemFontOfSize:30]];
    [B_web addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *tstr =@"1.如果图片，标题，或者网址有任何修改，点提交后即可修改成功。\n2.图片将会在 “发现”模块上面的滚动图上按顺序显示";
    CGSize size =[tstr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    UILabel *tlabel =[[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(B_web.frame)+10, DEVICE_WIDTH-30, size.height)];
    tlabel.font =[UIFont systemFontOfSize:13];
    tlabel.textColor = [UIColor grayColor];
    tlabel.numberOfLines=0;
    tlabel.text =tstr;
    [self.view addSubview:tlabel];
    
   
}
-(void)btnClick
{
   //预览网址
    FBWebUrlViewController *Wvc =[[FBWebUrlViewController alloc]init];
    Wvc.url =TF_url.text;
    Wvc.contentTitle = @"网址预览";
    [self.navigationController pushViewController:Wvc animated:NO];
}
-(void)tijiaoClick
{
    if (TF_title.text.length==0|| TF_url.text.length==0 || iV_img.image==nil) {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"参数不完整";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view  animated:YES];
        });
    }else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeAnnularDeterminate;
        hud.label.text = @"正在提交";
        
        if(_model==nil)
        {
            [WebRequest ComImage_Add_ComImageWithuserGuid:user.Guid companyId:user.companyId url:TF_url.text title:TF_title.text sort:[NSString stringWithFormat:@"%ld",[self.number_big integerValue]+1] img:iV_img.image And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
            
        }else
        {
            
            [WebRequest ComImage_Update_ComImageWithuserGuid:user.Guid companyId:user.companyId url:TF_url.text title:TF_title.text sort:_model.sort imageId:_model.Id img:nil And:^(NSDictionary *dic) {
                hud.label.text =dic[Y_MSG];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [hud hideAnimated:NO];
                    [self.navigationController popViewControllerAnimated:NO];
                });
            }];
            
        }
        
    
    }
    
}
-(void)tapClick
{
    //点击图片
    LDImagePicker *picker =[LDImagePicker sharedInstance];
    picker.delegate =self;
    [picker showImagePickerWithType:ImagePickerPhoto InViewController:self Scale:0.5];
    
}
- (void)imagePicker:(LDImagePicker *)imagePicker didFinished:(UIImage *)editedImage
{
    iV_img.image =editedImage;
    if(self.model==nil)
    {
        
    }else
    {
    [WebRequest ComImage_Update_ComImageWithuserGuid:user.Guid companyId:user.companyId url:TF_url.text title:TF_title.text sort:_model.sort imageId:_model.Id img:editedImage And:^(NSDictionary *dic) {
       
    }];
    }
}
- (void)imagePickerDidCancel:(LDImagePicker *)imagePicker
{
    
}


@end
