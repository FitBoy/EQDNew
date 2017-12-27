//
//  DaKa_JiLuTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "DaKa_JiLuTableViewCell.h"
#import <Masonry.h>
@implementation DaKa_JiLuTableViewCell
-(void)setModel:(DaKaJiLuModel *)model
{
    _model =model;
    self.L_time.text =model.date;
    if (model.list.count==0) {
        self.L_status.text =@"";
    }else
    {
        self.L_status.textColor =[UIColor blackColor];
        NSString *status =@"正常";
        for (int i=0; i<model.list.count; i++) {
            DaKaJiLu *model2 =model.list[i];
            if ([model2.status integerValue]!=0) {
                status =@"异常";
                self.L_status.textColor =[UIColor redColor];
                break;
            }
        }
        self.L_status.text =status;
    }
}
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}

-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_time];
        _L_time.font =[UIFont systemFontOfSize:17];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 30));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.left.mas_equalTo(self.V_bg.mas_left);
        }];
        
    }
    return _L_time;
}
-(UILabel*)L_shuoming
{
    if (!_L_shuoming) {
        _L_shuoming =[[UILabel alloc]init];
        _L_shuoming.font =[UIFont systemFontOfSize:17];
        _L_shuoming.textAlignment =NSTextAlignmentCenter;
        [self.V_bg addSubview:_L_shuoming];
        [_L_shuoming  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.L_time.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.L_status.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_shuoming;
}

-(UILabel*)L_status
{
    if (!_L_status) {
        _L_status =[[UILabel alloc]init];
        _L_status.font =[UIFont systemFontOfSize:17];
        _L_status.textAlignment = NSTextAlignmentCenter;
        [self.V_bg addSubview:_L_status];
        [_L_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 30));
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
        }];
        
    }
    return _L_status;
}

@end
