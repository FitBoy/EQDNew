//
//  Fnakui_DetailViewController.m
//  EQDManager
//
//  Created by 梁新帅 on 2017/10/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "Fnakui_DetailViewController.h"
#import <YYText.h>
#import <UIImageView+WebCache.h>
#import "FBindexTapGestureRecognizer.h"
#import "FBImgShowViewController.h"
@interface Fnakui_DetailViewController ()
{
    UIScrollView *scrollV;
}

@end

@implementation Fnakui_DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"反馈详情";
    scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, DEVICE_TABBAR_Height, DEVICE_WIDTH, DEVICE_HEIGHT-DEVICE_TABBAR_Height)];
    adjustsScrollViewInsets_NO(scrollV, self);
    [self.view addSubview:scrollV];
    NSMutableAttributedString  *fankui=nil;
    if ([_model.status integerValue]==0) {
       fankui = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",_model.fbackTitle] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        fankui.yy_alignment = NSTextAlignmentCenter;
        fankui.yy_lineSpacing=5;
    }else
    {
        fankui = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"客服回复:\n        %@\n\n",_model.dealMessage] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        fankui.yy_lineSpacing =5;
        [fankui yy_setBackgroundColor:[UIColor redColor] range:fankui.yy_rangeOfAll];
        
        NSMutableAttributedString  *title =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",_model.fbackTitle] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        title.yy_alignment = NSTextAlignmentCenter;
        title.yy_lineSpacing=5;
        [fankui appendAttributedString:title];
    }
    
    
    NSArray *tarr =@[@"应用崩溃闪退",@"意见",@"账号申诉"];
    NSInteger temp = [_model.fbackType integerValue];
    NSMutableAttributedString *type = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@ ",tarr[temp]] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    
    [type yy_setTextBackgroundBorder:[YYTextBorder borderWithFillColor:[UIColor lightGrayColor] cornerRadius:5] range:type.yy_rangeOfAll];
    type.yy_alignment =NSTextAlignmentCenter;
    type.yy_lineSpacing=5;
    [fankui appendAttributedString:type];
    
    NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",_model.fbcontent] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    content.yy_lineSpacing=5;
    [fankui appendAttributedString:content];
    
    CGSize size = [fankui boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) context:nil].size;
    float  width= (DEVICE_WIDTH-45)/3.0;
    scrollV.contentSize = CGSizeMake(DEVICE_WIDTH, size.height+220+ (_model.picAddress.count/3)*(width+10));
    YYLabel *Ylabel = [[YYLabel alloc]initWithFrame:CGRectMake(15, 5, DEVICE_WIDTH-30, size.height+10)];
    Ylabel.userInteractionEnabled =YES;
    Ylabel.numberOfLines=0;
    Ylabel.attributedText =fankui;
    [scrollV addSubview:Ylabel];
    
    for (int i=0; i<_model.picAddress.count; i++) {
        UIImageView  *timgV= [[UIImageView alloc]initWithFrame:CGRectMake(15+(width+5)*(i%3), size.height+20+(width+5)*(i/3), width, width)];
        [scrollV addSubview:timgV];
        timgV.userInteractionEnabled=YES;
        timgV.userInteractionEnabled =YES;
        [timgV sd_setImageWithURL:[NSURL URLWithString:_model.picAddress[i]] placeholderImage:nil];
        FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.index = i;
        [timgV addGestureRecognizer:tap];
        
    }
    
    
    
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap{
    FBImgShowViewController  *ISvc =[[FBImgShowViewController alloc]init];
    ISvc.selected = tap.index;
    ISvc.imgstrs =_model.picAddress;
    [self.navigationController pushViewController:ISvc animated:NO];
}


@end
