//
//  FBShowImg_TextViewController.m
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
#import "FBShowImg_TextViewController.h"
#import "NSString+FBString.h"
#import "FBShowimg_moreViewController.h"
#import "FBindexTapGestureRecognizer.h"
#import <UIImageView+WebCache.h>
@interface FBShowImg_TextViewController ()
{
    UIScrollView *SV_show;
}

@end

@implementation FBShowImg_TextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SV_show =[[UIScrollView alloc]initWithFrame:CGRectMake(15, DEVICE_TABBAR_Height, DEVICE_WIDTH-30, DEVICE_HEIGHT-64)];
    adjustsScrollViewInsets_NO(SV_show, self);
    [self.view addSubview:SV_show];
    self.navigationItem.title =self.contentTitle;
    NSMutableParagraphStyle *para =[[NSMutableParagraphStyle alloc]init];
    para.lineSpacing =5;
    NSMutableAttributedString *muStr =[[NSMutableAttributedString alloc]initWithString:self.contents attributes:@{NSParagraphStyleAttributeName:para,NSFontAttributeName:[UIFont systemFontOfSize:17]}];
   CGSize size1=[muStr boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-31, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    float width = (DEVICE_WIDTH-50)/3.0;
    for (int i=0; i<self.arr_imgs.count; i++) {
     
        
        UIImageView *timgV =[[UIImageView alloc]initWithFrame:CGRectMake(10+(width+10)*(i%3),size1.height+10+(width+10)*(i/3) , width,width)];
        [SV_show addSubview:timgV];
        [timgV sd_setImageWithURL:[NSURL URLWithString:self.arr_imgs[i]]];
        timgV.userInteractionEnabled=YES;
        FBindexTapGestureRecognizer *tap =[[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.index =i;
        [timgV addGestureRecognizer:tap];
        
    }
    
    SV_show.contentSize = CGSizeMake(DEVICE_WIDTH-30, size1.height+(width+10)*(self.arr_imgs.count%3==0?self.arr_imgs.count/3:self.arr_imgs.count/3+1)+100);
    UILabel *tlabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, DEVICE_WIDTH-30, size1.height)];
    tlabel.numberOfLines=0;
    [SV_show addSubview:tlabel];
    tlabel.attributedText = muStr;
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap
{
    //展示图片
    FBShowimg_moreViewController *SMvc =[[FBShowimg_moreViewController alloc]init];
    SMvc.arr_imgs =self.arr_imgs;
    SMvc.index = tap.index;
    [self.navigationController pushViewController:SMvc animated:NO];
    
}

@end
