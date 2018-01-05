//
//  EQDR_ArticleTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define height_img  ([UIScreen mainScreen].bounds.size.width-40)/3.0
#import "EQDR_ArticleTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation EQDR_ArticleTableViewCell

-(void)setModel:(EQDR_articleListModel *)model
{
    _model = model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_time.text =model.createTime;
    self.IV_fenXiang.image = [UIImage imageNamed:@"ic_arrow"];
    self.YL_name.text =model.upname;
     self.L_RPL.text = [NSString stringWithFormat:@"%@ 阅读 * %@ 评论 * %@ 喜欢",model.browseCount,model.commentCount,model.zanCount];
}
-(YYLabel*)YL_titleContent
{
    if (!_YL_titleContent) {
        _YL_titleContent = [[YYLabel alloc]init];
        _YL_titleContent.numberOfLines = 4;
        _YL_titleContent.textAlignment = NSTextAlignmentLeft;
        [self addSubview:_YL_titleContent];
    }
    return _YL_titleContent;
}
-(YYLabel*)YL_hangye
{
    if (!_YL_hangye) {
        _YL_hangye = [[YYLabel alloc]init];
        _YL_hangye.numberOfLines = 0;
        [self addSubview:_YL_hangye];
        _YL_hangye.font = [UIFont systemFontOfSize:12];
      
    }
    return _YL_hangye;
}
-(YYLabel*)L_source
{
    if (!_L_source) {
        _L_source = [[YYLabel alloc]init];
        [self.V_bottom addSubview:_L_source];
        [_L_source mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.V_bottom.mas_left);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.right.mas_equalTo(self.L_RPL.mas_left).mas_offset(-5);
        }];
    }
    return _L_source;
}


-(UILabel*)L_RPL
{
    if (!_L_RPL) {
        _L_RPL = [[UILabel alloc]init];
        _L_RPL.font = [UIFont systemFontOfSize:13];
        [self.V_bottom addSubview:_L_RPL];
        _L_RPL.textAlignment =NSTextAlignmentRight;
        _L_RPL.textColor = [UIColor grayColor];
        _L_RPL.userInteractionEnabled=YES;
        [_L_RPL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.right.mas_equalTo(self.V_bottom.mas_right);
            make.left.mas_equalTo(self.L_source.mas_right).mas_offset(5);
        }];
    }
    return _L_RPL;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img =[[UIImageView alloc]init];
        _IV_img.userInteractionEnabled =YES;
        _IV_img.layer.masksToBounds=YES;
        _IV_img.layer.cornerRadius =6;
        [self addSubview:_IV_img];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(height_img, height_img));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.V_top.mas_bottom).mas_offset(5);
        }];
        
    }
    return _IV_img;
}
-(UIView*)V_top
{
    if (!_V_top) {
        _V_top =[[UIView alloc]init];
        _V_top.userInteractionEnabled =YES;
        [self addSubview:_V_top];
        [_V_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _V_top;
}
-(UIView*)V_bottom
{
    if (!_V_bottom) {
        _V_bottom =[[UIView alloc]init];
        _V_bottom.userInteractionEnabled =YES;
        [self addSubview:_V_bottom];
        [_V_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _V_bottom;
}

-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        _IV_head.userInteractionEnabled =YES;
        _IV_head.layer.masksToBounds=YES;
        _IV_head.layer.cornerRadius =4;
        [self.V_top addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_top.mas_left);
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
        }];
    }
    return _IV_head;
}
-(YYLabel*)YL_name
{
    if (!_YL_name) {
        _YL_name = [[YYLabel alloc]init];
        [self.V_top addSubview:_YL_name];
        _YL_name.font = [UIFont systemFontOfSize:17];
        [_YL_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(22);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_head.mas_top);
            make.right.mas_equalTo(self.V_top.mas_right).mas_offset(-40);
        }];
        
    }
    return _YL_name;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        [self.V_top addSubview:_L_time];
        _L_time.textColor = [UIColor grayColor];
        _L_time.font =[UIFont systemFontOfSize:13];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(18);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_top.mas_right).mas_offset(-40);
        }];
    }
    return _L_time;
}
-(UIImageView*)IV_fenXiang
{
    if (!_IV_fenXiang) {
        _IV_fenXiang = [[UIImageView alloc]init];
        _IV_fenXiang.userInteractionEnabled=YES;
//        [self.V_top addSubview:_IV_fenXiang];
        _IV_fenXiang.hidden =YES;
        _IV_fenXiang.transform=CGAffineTransformMakeRotation(M_PI_2);
        [_IV_fenXiang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 34));
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
            make.right.mas_equalTo(self.V_top.mas_right);
        }];
        
    }
    return _IV_fenXiang;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
