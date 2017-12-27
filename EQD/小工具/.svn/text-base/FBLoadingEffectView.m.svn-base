//
//  FBLoadingEffectView.m
//  TianHuaWenZhong
//
//  Created by 梁新帅 on 2017/1/11.
//  Copyright © 2017年 Rowling-Zhang. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBLoadingEffectView.h"

@implementation FBLoadingEffectView
-(instancetype)initWithFrame:(CGRect)frame AndTitle:(NSString*)title{
    if (self =[ super initWithFrame:frame])
    {
      
        
        self.layer.masksToBounds=YES;
        self.layer.cornerRadius=7;
        
        self.backgroundColor =[UIColor darkGrayColor];
        if (!self.AIVS_style) {
            self.AIVS_style =UIActivityIndicatorViewStyleWhiteLarge;
        }
        if (!self.AIV_loading) {
            self.AIV_loading=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:self.AIVS_style];
            self.AIV_loading.frame=CGRectMake((frame.size.width-60)/2.0, (frame.size.height-90)/2.0, 60, 60);
            [self.contentView addSubview:self.AIV_loading];
        }
            if(!self.L_title){
            self.L_title=[[UILabel alloc]initWithFrame:CGRectMake(0, self.AIV_loading.frame.origin.y+60, frame.size.width, 30)];
            self.L_title.textAlignment=NSTextAlignmentCenter;
                self.L_title.font = [UIFont systemFontOfSize:17];
            [self.contentView addSubview:self.L_title];
                self.L_title.textColor=[UIColor whiteColor];
            }
            [self.AIV_loading startAnimating];
            self.L_title.text=title;
        
    }
        
    return self;
}

-(void)cancelView{
    if (self) {
        [self.AIV_loading stopAnimating];
        [self removeFromSuperview];
    }
    
}

-(instancetype)init{
    if (self =[super init]) {
        
    }
    return [self initWithFrame:CGRectMake((DEVICE_WIDTH-200)/2.0,(DEVICE_HEIGHT-120)/2.0 , 200, 120) AndTitle:@"加载中"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
