//
//  SDetailModel.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "SDetailModel.h"

@implementation SDetailModel
-(void)setUpname:(NSString *)upname
{
    _upname=self.left0=[NSString stringWithFormat:@"昵称:%@",upname];
}
-(void)setEQDCode:(NSString *)EQDCode
{
    _EQDCode = self.left1=[NSString stringWithFormat:@"易企点号:%@",EQDCode];
}
-(void)setIphoto:(NSString *)iphoto
{
    _iphoto = self.img_header = iphoto;
}


@end
