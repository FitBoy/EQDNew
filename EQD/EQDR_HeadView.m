//
//  EQDR_HeadView.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_HeadView.h"

@implementation EQDR_HeadView
-(void)setBtn:(FBButton*)tbtn
{
    if (PreBtn ==tbtn) {
        return;
    }else
    {
            [PreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [tbtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            PreBtn =tbtn;
   
    }
}
-(UIView*)V_red
{
    if (!_V_red) {
        _V_red = [[UIView alloc]init];
        _V_red.backgroundColor =[UIColor redColor];
        _V_red.frame =CGRectMake(5, 38, 70, 2);
        [self addSubview:_V_red];
    }
    return _V_red;
}
-(void)setTitleArr:(NSArray *)arr_title
{
    self.userInteractionEnabled=YES;
    [self.B_title0 setTitle:arr_title[0] titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
      [self.B_title1 setTitle:arr_title[1] titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
      [self.B_title2 setTitle:arr_title[2] titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
      [self.B_title3 setTitle:arr_title[3] titleColor:[UIColor grayColor] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16]];
    [self setBtn:self.B_title0];
    PreBtn = self.B_title0;
    
}
-(FBButton*)B_title0
{
    if (!_B_title0) {
        _B_title0 = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_title0];
        _B_title0.tag =9000;
        _B_title0.frame =CGRectMake(0, 0, 80, 40);
    }
    return _B_title0;
}
-(FBButton*)B_title1
{
    if (!_B_title1) {
        _B_title1 = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_title1];
        _B_title1.tag =9001;
        _B_title1.frame =CGRectMake(80, 0, 80, 40);
    }
    return _B_title1;
}
-(FBButton*)B_title2
{
    if (!_B_title2) {
        _B_title2 =[FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_title2];
        _B_title2.tag = 9002;
        _B_title2.frame = CGRectMake(160, 0, 80, 40);
    }
    return _B_title2;
}
-(FBButton*)B_title3
{
    if (!_B_title3) {
        _B_title3 =[FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_B_title3];
        _B_title3.tag = 9003;
        _B_title3.frame =CGRectMake(240, 0, 80, 40);
    }
    return _B_title3;
}


@end
