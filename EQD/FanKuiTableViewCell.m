//
//  FanKuiTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FanKuiTableViewCell.h"
#import <Masonry.h>
@implementation FanKuiTableViewCell
-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg = [[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UILabel*)L_title
{
    if(!_L_title)
    {
        _L_title =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_title];
        _L_title.font =[UIFont systemFontOfSize:17];
        [_L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(self.V_bg);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.L_status.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_title;
}
-(UILabel*)L_type
{
    if(!_L_type)
    {
        _L_type =[[UILabel alloc]init];
        _L_type.font =[UIFont systemFontOfSize:13];
        _L_type.textColor =[UIColor grayColor];
        [self.V_bg addSubview:_L_type];
        [_L_type mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(self.V_bg);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.L_status.mas_left).mas_offset(-5);
        }];
    }
    return _L_type;
}
-(UILabel*)L_status
{
    if(!_L_status)
    {
        _L_status =[[UILabel alloc]init];
        [self.V_bg addSubview:_L_status];
        _L_status.font =[UIFont systemFontOfSize:17];
        _L_status.layer.borderWidth=1;
        _L_status.textAlignment =NSTextAlignmentCenter;
        _L_status.transform = CGAffineTransformMakeRotation(-M_PI_2/4);
        _L_status.layer.borderColor = [UIColor redColor].CGColor;
        [_L_status mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 25));
            make.right.mas_equalTo(self.V_bg);
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            
        }];
    }
    return _L_status;
}

-(void)setModel:(FanKuiModel *)model
{
    NSArray *tarr =@[@"应用崩溃闪退",@"意见",@"账号申诉"];
    self.L_title.text = model.fbackTitle;
    self.L_type.text =[NSString stringWithFormat:@"%@-%@",tarr[[model.fbackType integerValue]],model.createTime];
    self.L_status.text =[model.status integerValue]==0?@"未处理":@"已处理";
    
}
@end
