//
//  FBMyErWeiMaViewController.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBMyErWeiMaViewController.h"
#import "FBScanViewController.h"
#import "WebRequest.h"
#import "SGQRCodeTool.h"
#import <UIImageView+AFNetworking.h>
#import "ExActivity.h"
#import "FBActivityViewController.h"
#import <RongIMKit/RongIMKit.h>
@interface FBMyErWeiMaViewController ()
{
    UIView *V_bg;
    NSInteger temp;
    UIImage *image_share;
}

@end

@implementation FBMyErWeiMaViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(fenxiangClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    self.navigationController.navigationBarHidden=NO;
    self.title = @"我的二维码";
    self.view.backgroundColor =[UIColor whiteColor];
     float height =230;
    V_bg = [[UIView alloc]initWithFrame:CGRectMake((DEVICE_WIDTH-height)/2.0, (DEVICE_HEIGHT-height)/2.0, height,height+60+15)];
    [self.view addSubview:V_bg];
    
    UIImageView  *imag_erWeiMa =[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, height, height)];
    [V_bg addSubview:imag_erWeiMa];
    
    UIImageView *headImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 50, 50)];
    headImage.layer.masksToBounds=YES;
    headImage.layer.cornerRadius =25;
    [V_bg addSubview:headImage];
    
    UILabel *tlab_name =[[UILabel alloc]initWithFrame:CGRectMake(55, 5, height-55, 30)];
    [V_bg addSubview:tlab_name];
    UILabel *tlab_bumen =[[UILabel alloc]initWithFrame:CGRectMake(55, 5+30, height-55, 20)];
    [V_bg addSubview:tlab_bumen];
    tlab_bumen.font =[UIFont systemFontOfSize:17];
    tlab_bumen.textColor=[UIColor grayColor];
   
    NSDictionary *dic=nil;
    if (self.isOther==YES) {
        dic=@{
              @"type":@"2",
              @"ugid":self.C_user.userGuid,
              @"name":self.C_user.upname
              };
         [headImage setImageWithURL:[NSURL URLWithString:self.C_user.photo] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        tlab_name.text = _C_user.upname;
         tlab_bumen.text = _C_user.uname;
    }
    else
    {
        UserModel *user = [WebRequest GetUserInfo];
        dic = @{
                @"type":@"2",
                @"ugid":user.Guid,
                @"name":user.upname
                };
      [headImage setImageWithURL:[NSURL URLWithString:user.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        tlab_name.text = user.upname;
         tlab_bumen.text = user.uname;
    }
  
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
   imag_erWeiMa.image= [SGQRCodeTool SG_generateWithDefaultQRCodeData:str imageViewWidth:height];
    
    
   
    
   
    
    
    
    
    UILabel *tlab_tishi =[[UILabel alloc]initWithFrame:CGRectMake(0, height+60, height, 15)];
    [V_bg addSubview:tlab_tishi];
    tlab_tishi.text= @"在易企点上扫一扫，加我好友";
    tlab_tishi.textAlignment =NSTextAlignmentCenter;
    tlab_tishi.font =[UIFont systemFontOfSize:12];
    tlab_tishi.textColor = [UIColor grayColor];
    
    temp =0;

}

-(void)fenxiangClick{
    NSLog(@"分享 保存图片");
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"分享" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        temp =1;
        [self snapshotScreenInView:V_bg];
        ExActivity *activity =[[ExActivity alloc]init];
        RCImageMessage *content = [RCImageMessage messageWithImage:image_share];
        activity.messageContent =content;
        
        FBActivityViewController *Avc =[[FBActivityViewController alloc]initWithActivityItems:@[image_share] applicationActivities:@[activity]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:Avc animated:NO completion:nil];
        });
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        temp =2;
        [self snapshotScreenInView:V_bg];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"扫描二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBScanViewController  *FSvc =[[FBScanViewController alloc]init];
        [self.navigationController pushViewController:FSvc animated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
    
}

- (void)snapshotScreenInView:(UIView *)contentView {
    CGSize size = contentView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [contentView drawViewHierarchyInRect:contentView.bounds afterScreenUpdates:YES];
    
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image_share = image1;
    if (temp==2) {
        UIImageWriteToSavedPhotosAlbum(image1, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    }
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if(!error){
        MBFadeAlertView *alert =[[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"二维码保存成功"];
    }else{
        MBFadeAlertView *alert =[[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"二维码保存失败"];
    }
}



@end
