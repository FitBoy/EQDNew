//
//  FBImgViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBImgViewController.h"
#import "FBButton.h"
@interface FBImgViewController ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    FBButton *tbtn;
    UIImage *image1;
    
}

@end

@implementation FBImgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =self.contentTitle;
    float height = DEVICE_WIDTH*3/4.0;
    tbtn =[FBButton buttonWithType:UIButtonTypeSystem];
    tbtn.frame =CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, height);
    [self.view addSubview:tbtn];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(quedingClcik)];
    [self.navigationItem setRightBarButtonItem:right];
    [tbtn setTitle:@"点我上传图片" titleColor:[UIColor whiteColor] backgroundColor:[UIColor grayColor] font:nil];
    if (self.image!=nil) {
        [tbtn setBackgroundImage:self.image forState:UIControlStateNormal];
    }
    [tbtn addTarget:self action:@selector(shangchaunClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *tlabel =[[UILabel alloc]init];
    tlabel.font =[UIFont systemFontOfSize:15];
    tlabel.textColor =[UIColor redColor];
    if (self.content==nil) {
        [tlabel removeFromSuperview];
    }
    else
    {
        CGSize  size =[self.content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.1]} context:nil].size;
        tlabel.frame =CGRectMake(15, height+10+DEVICE_TABBAR_Height, DEVICE_WIDTH-30, size.height);
        tlabel.text =self.content;
        [self.view addSubview:tlabel];
    }
    tlabel.numberOfLines=0;
    
    
}
-(void)quedingClcik
{
    if (image1!=nil) {
        if ([self.delegate respondsToSelector:@selector(img:flag:indexPath:)]) {
            [self.delegate img:image1 flag:self.flag indexPath:self.indexPath];
            [self.navigationController popViewControllerAnimated:NO];
        }
    }
    else
    {
        MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text =@"您未选取图片";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        });
    }
}


-(void)shangchaunClick
{
    UIAlertController *alert =[[UIAlertController alloc]init];
    UIImagePickerController *picker =[[UIImagePickerController alloc]init];
    picker.delegate=self;
    picker.allowsEditing=YES;
    [alert addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:picker animated:NO completion:nil];
            });
        }
        else
        {
            MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
            hud.mode = MBProgressHUDModeText;
            hud.label.text =@"无法获得相机";
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            });
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:picker animated:NO completion:nil];
            });
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image =[info objectForKey:UIImagePickerControllerEditedImage];
    image1 = image;
    [tbtn setBackgroundImage:image forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:NO completion:nil];
    
}


@end
