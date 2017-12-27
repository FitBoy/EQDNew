//
//  FBImgShowViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define DEVICE_TABBAR_Height CGRectGetMaxY(self.navigationController.navigationBar.frame)
#import "FBImgShowViewController.h"
#import <UIImageView+WebCache.h>
#import "STImageVIew.h"
#import <Photos/Photos.h>
#import "FBindexpathLongPressGestureRecognizer.h"
#import "MBFadeAlertView.h"
#import "WebRequest.h"
@interface FBImgShowViewController ()<UIScrollViewDelegate,STImageViewDelegate>
{
    UIScrollView *ScrollV;
    NSMutableArray *arr_imgs;
    UserModel *user;
}

@end

@implementation FBImgShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    user =[WebRequest GetUserInfo];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title =[NSString stringWithFormat:@"%ld/%ld",_selected+1,(unsigned long)self.imgstrs.count];
    arr_imgs =[NSMutableArray arrayWithCapacity:0];
    ScrollV =[[UIScrollView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height)];
    ScrollV.delegate=self;
    [self.view addSubview:ScrollV];
    ScrollV.contentSize = CGSizeMake(DEVICE_WIDTH*self.imgstrs.count, DEVICE_HEIGHT-64);
    
    for (int i=0; i<_imgstrs.count; i++) {
        STImageVIew *imgV =[[STImageVIew alloc]init ];
        imgV.delegate =self;
        [ScrollV addSubview:imgV];
        __block NSInteger temp =i;
        imgV.userInteractionEnabled=YES;
        [imgV sd_setImageWithURL:[NSURL URLWithString:self.imgstrs[i]] placeholderImage:[UIImage imageNamed:@"imageerro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [arr_imgs addObject:image];
            if (DEVICE_WIDTH*image.size.height/image.size.width>DEVICE_HEIGHT-70) {
                ScrollV.contentSize = CGSizeMake(DEVICE_WIDTH*self.imgstrs.count,DEVICE_WIDTH*image.size.height/image.size.width+10);
                 imgV.frame =CGRectMake(DEVICE_WIDTH*temp, 5, DEVICE_WIDTH, DEVICE_WIDTH*image.size.height/image.size.width);
            }
            else
            {
              ScrollV.contentSize = CGSizeMake(DEVICE_WIDTH*self.imgstrs.count, DEVICE_HEIGHT-DEVICE_TABBAR_Height);
                 imgV.frame =CGRectMake(DEVICE_WIDTH*temp, 5, DEVICE_WIDTH, DEVICE_WIDTH*image.size.height/image.size.width);
            }
           
            
        }];
        
        
        FBindexpathLongPressGestureRecognizer *longPress =[[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
        longPress.index =i;
        [imgV addGestureRecognizer:longPress];
        
        
    }
    [ScrollV setContentOffset:CGPointMake(DEVICE_WIDTH*_selected, 0)];
    
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longpress
{
    UIAlertController  *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
                [PHAssetChangeRequest creationRequestForAssetFromImage:arr_imgs[longpress.index]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    MBFadeAlertView *alertV = [[MBFadeAlertView alloc]init];
                    [alertV showAlertWith:@"保存成功"];
                });
                
            }
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [WebRequest Collection_Add_collectionWithowner:user.Guid imgArr:@[arr_imgs[longpress.index]] tel:user.uname sourceOwner:user.Guid source:[NSString stringWithFormat:@"工作圈-%@",user.upname] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MBFadeAlertView *alertV = [[MBFadeAlertView alloc]init];
                [alertV showAlertWith:@"收藏成功"];
            }
        }];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:NO completion:nil];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationItem.title=[NSString stringWithFormat:@"%ld/%ld",(NSInteger)(scrollView.contentOffset.x/DEVICE_WIDTH)+1,(unsigned long)self.imgstrs.count];
}

-(void)stImageVIewSingleClick:(STImageVIew *)imageView
{
    [self.navigationController popViewControllerAnimated:NO];
}

@end
