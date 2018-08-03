//
//  GZQ_top_headView.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "GZQ_top_headView.h"
#import <UIImageView+WebCache.h>
@implementation GZQ_top_headView
-(UIImageView*)IV_bg
{
    if (!_IV_bg) {
        _IV_bg =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_WIDTH, DEVICE_WIDTH*0.5)];
        _IV_bg.userInteractionEnabled=YES;
        [self addSubview:_IV_bg];
        [_IV_bg sendSubviewToBack:self.IV_head];
    }
    return _IV_bg;
}
-(UILabel*)L_name{
    if (!_L_name) {
        _L_name =[[UILabel alloc]initWithFrame:CGRectMake(0, DEVICE_WIDTH*0.5-35, DEVICE_WIDTH-110, 30)];
        
        _L_name.textAlignment=NSTextAlignmentRight;
        _L_name.textColor =[UIColor whiteColor];
        [self.IV_bg addSubview:_L_name];
    }
    return _L_name;
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head =[[UIImageView alloc]initWithFrame:CGRectMake(DEVICE_WIDTH-95, DEVICE_WIDTH*0.5-40, 80, 80)];
        _IV_head.userInteractionEnabled=YES;
        
        [self addSubview:_IV_head];
        [_IV_head bringSubviewToFront:self.IV_bg];
    }
    return _IV_head;
}
-(UILabel*)L_sign
{
    if (!_L_sign) {
        _L_sign =[[UILabel alloc]init];
        _L_sign.font =[UIFont systemFontOfSize:13];
        _L_sign.numberOfLines =2;
        [self addSubview:_L_sign];
        _L_sign.frame =CGRectMake(0, DEVICE_WIDTH*0.5, DEVICE_WIDTH-100, 40);
    }
    return _L_sign;
}
-(void)setArr_contents:(NSArray *)arr_contents
{
    self.userInteractionEnabled =YES;
    self.backgroundColor =[UIColor whiteColor];
    _arr_contents =arr_contents;
    [self.IV_bg sd_setImageWithURL:[NSURL URLWithString:arr_contents[0]] placeholderImage:[UIImage imageNamed:@"GZQ_header"]];
    self.L_name.text =arr_contents[2];
    self.L_sign.text =arr_contents[3];
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:arr_contents[1]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    [self addSubview:self.IV_head];
   
}

@end
