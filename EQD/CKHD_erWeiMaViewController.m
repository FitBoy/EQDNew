//
//  CKHD_erWeiMaViewController.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 二维码 左右 40   标题 50  底部说明 20

#import "CKHD_erWeiMaViewController.h"
#import "SGQRCodeTool.h"
#import "FBScanViewController.h"
#import <Masonry.h>
#import "FB_ShareEQDViewController.h"
@interface CKHD_erWeiMaViewController ()
{
    UIView *V_bg;
    UIImage *image_share;
    NSInteger temp;
}
@end

@implementation CKHD_erWeiMaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *isBaoming = nil;
    switch (self.temp-1) {
        case 0:
        {
            isBaoming = @"报名";
        }
            break;
            case 1:
        {
            isBaoming = @"签到";
        }
            break;
        default:
            break;
    }
    self.navigationItem.title = [NSString stringWithFormat:@"活动%@二维码",isBaoming];
    self.view.backgroundColor = [UIColor grayColor];
    V_bg = [[UIView alloc]init];
    V_bg.backgroundColor = [UIColor whiteColor];
    V_bg.userInteractionEnabled =YES;
    V_bg.layer.masksToBounds =YES;
    V_bg.layer.cornerRadius =5;
    [self.view addSubview:V_bg];
    [V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-50, DEVICE_WIDTH-50+60));
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    UIImageView *IV_img = [[UIImageView alloc]init];
    [V_bg addSubview:IV_img];
    IV_img.userInteractionEnabled =YES;
    [IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-70, DEVICE_WIDTH-70));
        make.top.mas_equalTo(V_bg.mas_top).mas_offset(52);
        make.left.mas_equalTo(V_bg.mas_left).mas_offset(10);
    }];
    
    
    UILabel *L_title = [[UILabel alloc]init];
    L_title.textAlignment = NSTextAlignmentCenter;
    [V_bg addSubview:L_title];
    L_title.font = [UIFont systemFontOfSize:17];
    L_title.numberOfLines =2;
    L_title.text =self.model_detail.activeTitle;
    
    [L_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-70, 46));
        make.top.mas_equalTo(V_bg.mas_top).mas_offset(3);
        make.left.mas_equalTo(V_bg.mas_left).mas_offset(10);
    }];
    
    UILabel *tlabel = [[UILabel alloc]init];
    [V_bg addSubview:tlabel];
    tlabel.textColor = [UIColor grayColor];
    tlabel.textAlignment = NSTextAlignmentCenter;
    tlabel.text =[NSString stringWithFormat:@"易企点扫一扫%@",isBaoming] ;
    tlabel.font = [UIFont systemFontOfSize:13];
    [tlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(DEVICE_WIDTH-70, 20));
        make.left.mas_equalTo(V_bg.mas_left).mas_offset(10);
        make.bottom.mas_equalTo(V_bg.mas_bottom).mas_offset(-5);
    }];
    NSDictionary  * dic =nil;
    if (self.temp ==1) {
        ///报名
        dic =@{
               @"type":@"5",
               @"ugid":@" ",
               @"name":@" ",
               @"data":@{
                       @"Id":self.model_detail.Id,
                       @"title":self.model_detail.activeTitle,
                       @"place":self.model_detail.activeAddress,
                       @"time":[NSString stringWithFormat:@"%@ ~ %@",_model_detail.activeStartTime,_model_detail.activeEndTime]
                       }
               };
    }else
    {
        ///签到
        dic =@{
               @"type":@"6",
               @"ugid":@" ",
               @"name":@" ",
               @"data":@{
                       @"Id":self.model_detail.Id,
                       @"title":self.model_detail.activeTitle,
                       @"place":self.model_detail.activeAddress,
                       @"time":[NSString stringWithFormat:@"%@ ~ %@",_model_detail.activeStartTime,_model_detail.activeEndTime]
                       }
               };
    }
    /// 签到完成后弹出一个view，提示 课程名字   课程的时间 地点 受训人 讲师
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString *tstr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    IV_img.image = [SGQRCodeTool SG_generateWithDefaultQRCodeData:tstr imageViewWidth:DEVICE_WIDTH-70];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"EQD_more"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(moreClick)];
    [self.navigationItem setRightBarButtonItem:right];
    
    temp =0;
}
-(void)moreClick
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    NSArray *tarr = @[@"保存图片",@"识别图中二维码",@"发送到",@"扫描二维码"];
    for (int i=0; i<tarr.count; i++) {
        [alert addAction:[UIAlertAction actionWithTitle:tarr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (i==0) {
                //保存图片
                temp =2;
                [self snapshotScreenInView:V_bg];
                
            }else if (i==1)
            {
                //识别图中二维码
                temp =1;
                [self snapshotScreenInView:V_bg];
                if (image_share) {
                    FBScanViewController *Fvc =[[FBScanViewController alloc]init];
                    Fvc.image = image_share;
                    [self.navigationController pushViewController:Fvc animated:NO];
                }
                
                
            }else if (i==2)
            {
                //分享
                temp =1;
                [self snapshotScreenInView:V_bg];
                FB_ShareEQDViewController  *Svc =[[FB_ShareEQDViewController alloc]init];
                Svc.providesPresentationContextTransitionStyle = YES;
                Svc.definesPresentationContext = YES;
                Svc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
                Svc.EQD_ShareType = EQD_ShareTypeImage2;
                Svc.image_local =image_share;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:Svc animated:NO completion:nil];
                });
                
            }else
            {
                //扫描二维码
                FBScanViewController *Fvc =[[FBScanViewController alloc]init];
                [self.navigationController pushViewController:Fvc animated:NO];
            }
        }]];
        
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:NO completion:nil];
    });
    
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
