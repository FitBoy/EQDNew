//
//  FBDaKa_TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBDaKa_TableViewCell.h"
#import <Masonry.h>
#import "DaKaJiLu.h"
@implementation FBDaKa_TableViewCell
-(void)setModel:(DaKaJiLu *)model
{
    //0:正常，1:迟到，2：早退,-1:待打卡，-2：漏打卡，-3：未开启打卡)
        if([model.status integerValue]==-1)
        {
            [self setdataWithModel:model];
            [self.L_right mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.height.mas_equalTo(0);
                make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            }];
            
            self.B_right.enabled=YES;
            [self.B_right setTitle:@"打卡" forState:UIControlStateNormal];
            [self.B_right mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(70, 35));
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            }];
        }else if([model.status integerValue] ==-2)
        {
            [self setdataWithModel:model];
           
            [self.B_right setTitle:@"漏打卡" titleColor:[UIColor whiteColor] backgroundColor: [UIColor lightGrayColor] font:[UIFont systemFontOfSize:17]];
            self.B_right.enabled =NO;
            
            [self.L_right mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.height.mas_equalTo(0);
                make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            }];
            [self.B_right mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(70, 35));
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            }];
        }else if ([model.status integerValue]==-3)
        {
            [self setdataWithModel:model];
            [self.L_right mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.height.mas_equalTo(0);
                make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            }];
            [self.B_right setTitle:@"未开始" titleColor:[UIColor whiteColor] backgroundColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:17]];
            self.B_right.enabled =NO;
            
            [self.B_right mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(70, 35));
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            }];
        }else
        {
            [self setdataWithModel:model];
            NSString *daka_status =@"正常";
            if ([model.status integerValue]==1) {
                daka_status =@"迟到";
            }else if ([model.status integerValue]==2)
            {
               daka_status =@"早退";
            }else
            {
                daka_status =@"正常";
            }
            
            [self.B_right mas_updateConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(CGSizeMake(0, 0));
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            }];
            [self.L_right mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.V_bg.mas_centerY);
                make.right.mas_equalTo(self.V_bg.mas_right);
                make.height.mas_equalTo(20);
                make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
            }];
            
            if([model.type integerValue]==0)
            {
                //上班
                 self.L_right.text =[NSString stringWithFormat:@"打卡%@-%@",model.createTime,daka_status];
            }else
            {
                NSMutableAttributedString  *attributeStr =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"打卡%@-%@",model.createTime,daka_status] attributes:@{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:15]}];
                
                NSMutableAttributedString  *daka =[[NSMutableAttributedString alloc]initWithString:@" 重打"];
                daka.yy_font=[UIFont systemFontOfSize:15];
                [daka yy_setTextHighlightRange:daka.yy_rangeOfAll color:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] backgroundColor:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                    //重新打卡
                    if ([self.delegate respondsToSelector:@selector(clocktime:indexpath:clockid:)]) {
                        [self.delegate clocktime:model.clockTime indexpath:self.indexPath clockid:model.Id];
                    }
                }];
                if ([model.status integerValue]==0) {
                    
                }else
                {
                    [attributeStr appendAttributedString:daka];
                }
                attributeStr.yy_alignment =NSTextAlignmentRight;
                self.L_right.attributedText =attributeStr;
            }
            
            
        }
}

-(void)setdataWithModel:(DaKaJiLu*)model
{
    self.L_left1.text =model.clockTime;
    if ([model.type integerValue]==0) {
        self.L_left0.text =@"上班打卡";
    }else
    {
        self.L_left0.text =@"下班打卡";
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
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
    }
    return _V_bg;
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        _L_left0.userInteractionEnabled =YES;
        _L_left0.font =[UIFont systemFontOfSize:17];
        [self.V_bg addSubview:_L_left0];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 24));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.top.mas_equalTo(self.V_bg.mas_top).mas_offset(5);
        }];
        
    }
    return _L_left0;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1=[[UILabel alloc]init];
        [self.V_bg addSubview:_L_left1];
        _L_left1.font =[UIFont systemFontOfSize:13];
        _L_left1.textColor =[UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo (CGSizeMake(50, 16));
            make.left.mas_equalTo(self.V_bg.mas_left);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _L_left1;
}
-(FBButton*)B_right
{
    if (!_B_right) {
        _B_right =[FBButton buttonWithType:UIButtonTypeSystem];
        [_B_right setTitle:@"打卡" titleColor:[UIColor whiteColor] backgroundColor:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] font:[UIFont systemFontOfSize:20]];
        [self.V_bg addSubview:_B_right];
       
    }
    return _B_right;
}
-(YYLabel*)L_right
{
    if (!_L_right) {
        _L_right =[[YYLabel alloc]init];
        _L_right.font =[UIFont systemFontOfSize:15];
        _L_right.textColor =[UIColor grayColor];
        _L_right.textAlignment =NSTextAlignmentRight;
        [self.V_bg addSubview:_L_right];
        [_L_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.V_bg.mas_centerY);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.L_left0.mas_right).mas_offset(5);
        }];
        
    }
    return _L_right;
}
@end
