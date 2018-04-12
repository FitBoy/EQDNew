//
//  DerweimaViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DerweimaViewController.h"
#import "SGQRCodeTool.h"
#import <UIImageView+AFNetworking.h>
#import "FBActivityViewController.h"
#import "ExActivity.h"
#import "FB_ShareEQDViewController.h"
@interface DerweimaViewController ()
{
    UIImage *image_share;
    NSInteger temp;
    UIView *V_bg;
}

@end

@implementation DerweimaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    UIBarButtonItem *right =[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(fenxiangClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    self.navigationController.navigationBarHidden=NO;
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@的二维码",_model.groupname];
    self.view.backgroundColor =[UIColor whiteColor];
    
    float height =230;
    
    V_bg = [[UIView alloc]initWithFrame:CGRectMake((DEVICE_WIDTH-height)/2.0, (DEVICE_HEIGHT-height)/2.0, height, height+60+20)];
    [self.view addSubview:V_bg];
    UIImageView  *imag_erWeiMa =[[UIImageView alloc]initWithFrame:CGRectMake(0, 60, height, height)];
    [V_bg addSubview:imag_erWeiMa];
    NSDictionary *dic = @{
                          @"type":@"1",
                          @"ugid":_model.groupid,
                          @"name":_model.groupname
                          };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
       imag_erWeiMa.image= [SGQRCodeTool SG_generateWithDefaultQRCodeData:str imageViewWidth:height];
    
    
    UIImageView *headImage =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    headImage.layer.masksToBounds=YES;
    headImage.layer.cornerRadius =25;
    [headImage setImageWithURL:[NSURL URLWithString:_model.groupphoto] placeholderImage:[UIImage imageNamed:@"qun"]];
    
    [V_bg addSubview:headImage];
    
    UILabel *tlab_name =[[UILabel alloc]initWithFrame:CGRectMake(55, 0, height-55, 30)];
    [V_bg addSubview:tlab_name];
    tlab_name.text = _model.groupname;
    
    UILabel *tlab_bumen =[[UILabel alloc]initWithFrame:CGRectMake(55, 30, height-55, 20)];
    [V_bg addSubview:tlab_bumen];
    tlab_bumen.font =[UIFont systemFontOfSize:17];
    tlab_bumen.textColor=[UIColor grayColor];
//    tlab_bumen.text = user.bumenname;
    
    UILabel *tlab_tishi =[[UILabel alloc]initWithFrame:CGRectMake(0, height+62, height, 15)];
    [V_bg addSubview:tlab_tishi];
    tlab_tishi.text= @"在易企点上扫一扫，加入该群";
    tlab_tishi.textAlignment =NSTextAlignmentCenter;
    tlab_tishi.font =[UIFont systemFontOfSize:12];
    tlab_tishi.textColor = [UIColor grayColor];
    
    
    
}

-(void)fenxiangClick{
    NSLog(@"分享 保存图片");
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"分享二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        temp =1;
         [self snapshotScreenInView:V_bg];
        
        FB_ShareEQDViewController  *Svc = [[FB_ShareEQDViewController alloc]init];
        Svc.image_local =image_share;
        Svc.EQD_ShareType = EQD_ShareTypeImage2;
        Svc.providesPresentationContextTransitionStyle = YES;
        Svc.definesPresentationContext = YES;
        Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:Svc animated:NO completion:nil];
        /*
        ExActivity *activity =[[ExActivity alloc]init];
        RCImageMessage *content = [RCImageMessage messageWithImage:image_share];
        activity.messageContent =content;
        
        FBActivityViewController *Avc =[[FBActivityViewController alloc]initWithActivityItems:@[image_share] applicationActivities:@[activity]];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:Avc animated:NO completion:nil];
        });*/
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存到手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        temp=2;
        [self snapshotScreenInView:V_bg];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"扫描二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FBScanViewController  *FSvc =[[FBScanViewController alloc]init];
        
        [self.navigationController pushViewController:FSvc animated:NO];
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"识别图中二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self snapshotScreenInView:V_bg];
        if (image_share) {
            FBScanViewController *Fvc =[[FBScanViewController alloc]init];
            Fvc.image = image_share;
            [self.navigationController pushViewController:Fvc animated:NO];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
    
    
    
}

- (void)snapshotScreenInView:(UIView *)contentView {
    CGSize size = contentView.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGRect rect = contentView.bounds;
    [contentView drawViewHierarchyInRect:rect afterScreenUpdates:YES];
    
    UIImage *image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    image_share =image1;
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
