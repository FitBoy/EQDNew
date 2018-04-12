//
//  FBShowimg_moreViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)
#import "FBShowimg_moreViewController.h"
#import "STImageVIew.h"
#import "NSString+FBString.h"
#import <UIImageView+WebCache.h>
#import "FBindexpathLongPressGestureRecognizer.h"
#import <Photos/Photos.h>
#import "MBFadeAlertView.h"
@interface FBShowimg_moreViewController ()<STImageViewDelegate,UIScrollViewDelegate>
{
    UIScrollView *SV_imgs;
    NSMutableArray *arr_imgess;
    UserModel *user;
}

@end

@implementation FBShowimg_moreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arr_imgess = [NSMutableArray arrayWithCapacity:0];
    self.navigationItem.title = [NSString stringWithFormat:@"%ld / %ld",self.index+1,_arr_imgs.count];
    SV_imgs.pagingEnabled=YES;
    SV_imgs =[[UIScrollView alloc]initWithFrame:CGRectMake(15, 64, DEVICE_WIDTH-30, DEVICE_HEIGHT-64)];
    adjustsScrollViewInsets_NO(SV_imgs, self);
    [self.view addSubview:SV_imgs];
    SV_imgs.contentSize = CGSizeMake(DEVICE_WIDTH*_arr_imgs.count, DEVICE_HEIGHT-64);
    for (int i=0; i<_arr_imgs.count; i++) {
        STImageVIew *imgV =[[STImageVIew alloc]init];
        FBindexpathLongPressGestureRecognizer *longPress = [[FBindexpathLongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressClick:)];
        longPress.index =i;
        [imgV addGestureRecognizer:longPress];
        
        __block NSInteger temp =i;
        [imgV sd_setImageWithURL:[NSURL URLWithString:_arr_imgs[temp]] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            [arr_imgess addObject:image];
            float height =DEVICE_WIDTH*image.size.height/image.size.width;
            if (height <DEVICE_HEIGHT-64) {
                imgV.frame =CGRectMake(DEVICE_WIDTH*temp, (DEVICE_HEIGHT-64-height)/2.0, DEVICE_WIDTH, height);
                SV_imgs.contentSize = CGSizeMake(DEVICE_WIDTH*_arr_imgs.count, DEVICE_HEIGHT-64);
            }
            else
            {
               imgV.frame =CGRectMake(DEVICE_WIDTH*temp, 0, DEVICE_WIDTH, height);
                SV_imgs.contentSize =CGSizeMake(DEVICE_WIDTH*_arr_imgs.count, height);
            }
            
        }];
        
        
        imgV.delegate =self;
        [SV_imgs addSubview:imgV];
    }
    
    [SV_imgs setContentOffset:CGPointMake(DEVICE_WIDTH*self.index, 0)];
    
    SV_imgs.delegate=self;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationItem.title = [NSString stringWithFormat:@"%ld / %ld",(NSInteger)(scrollView.contentOffset.x/DEVICE_WIDTH)+1,_arr_imgs.count];
    
}
-(void)longPressClick:(FBindexpathLongPressGestureRecognizer*)longPress
{
    user = [WebRequest GetUserInfo];
    UIAlertController *alert = [[UIAlertController alloc]init];
    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:arr_imgess[longPress.index]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    MBFadeAlertView *alertVb=[[MBFadeAlertView alloc]init];
                    [alertVb showAlertWith:@"保存成功"];
                });
                
            }
        }];
        
        
    }]];
    
    
    [alert addAction:[UIAlertAction actionWithTitle:@"收藏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [WebRequest Collection_Add_collectionWithowner:user.Guid imgArr:@[arr_imgess[longPress.index]] tel:user.uname sourceOwner:user.Guid source:[NSString stringWithFormat:@"工作圈-%@",user.upname] And:^(NSDictionary *dic) {
            if ([dic[Y_STATUS] integerValue]==200) {
                MBFadeAlertView *alertV = [[MBFadeAlertView alloc]init];
                [alertV showAlertWith:@"收藏成功"];
            }
        }];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"识别图中二维码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (arr_imgess[longPress.index]) {
            FBScanViewController *Fvc =[[FBScanViewController alloc]init];
            Fvc.image = arr_imgess[longPress.index];
            [self.navigationController pushViewController:Fvc animated:NO];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    
    [self presentViewController:alert animated:NO completion:nil];
}
#pragma mark - stimg的协议代理
-(void)stImageVIewSingleClick:(STImageVIew *)imageView
{
    [self.navigationController popViewControllerAnimated:NO];
    
}


@end
