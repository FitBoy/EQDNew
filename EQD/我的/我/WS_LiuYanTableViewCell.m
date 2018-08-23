//
//  WS_LiuYanTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "WS_LiuYanTableViewCell.h"
#import <Masonry.h>
@implementation WS_LiuYanTableViewCell

-(void)setModel_liuyan:(WS_liuYanModel *)model_liuyan
{
    _model_liuyan = model_liuyan;
    [self.V_top setHead:model_liuyan.iphoto name:model_liuyan.staffName bumen:[NSString stringWithFormat:@"%@-%@",model_liuyan.departName,model_liuyan.postName] time:model_liuyan.createTime];
    model_liuyan.cell_height = 50+5;
    self.V_top.IV_fenxiang.hidden =YES;
    CGSize size = [model_liuyan.Message boundingRectWithSize:CGSizeMake(self.frame.size.width-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
    self.L_contets.text = model_liuyan.Message;
    [self.L_contets mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.V_top.mas_bottom).mas_offset(5);
    }];
    model_liuyan.cell_height = model_liuyan.cell_height +5+5+size.height+5;
    if (model_liuyan.childList.count==0) {
        self.YL_contents.hidden =YES;
    }else
    {
         self.YL_contents.hidden =NO;
        NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:@""];
        for (int i=0; i<model_liuyan.childList.count; i++) {
            WS_liuYanModel  *tmodel = model_liuyan.childList[i];
            NSMutableAttributedString *tcontent =[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"企业回复：%@",tmodel.Message] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [contents appendAttributedString:tcontent];
        }
        contents.yy_lineSpacing =6;
        self.YL_contents.attributedText = contents;
        CGSize size = [contents boundingRectWithSize:CGSizeMake(self.frame.size.width -75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model_liuyan.cell_height =10+size.height+model_liuyan.cell_height;
        
        [self.YL_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(self.mas_left).mas_offset(60);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.L_contets.mas_bottom).mas_offset(5);
        }];
        
    }
    
}
-(FB_topView*)V_top
{
    if (!_V_top) {
        _V_top = [[FB_topView alloc]init];
        [self addSubview:_V_top];
        [_V_top  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
    }
    return _V_top;
}

-(UILabel*)L_contets
{
    if (!_L_contets) {
        _L_contets = [[UILabel alloc]init];
        [self addSubview:_L_contets];
        _L_contets.font = [UIFont systemFontOfSize:17];
        _L_contets.userInteractionEnabled =YES;
        _L_contets.numberOfLines=0;
    }
    return _L_contets;
}

-(YYLabel*)YL_contents
{
    if (!_YL_contents) {
        _YL_contents = [[YYLabel alloc]init];
        [self addSubview:_YL_contents];
        _YL_contents.numberOfLines =0;
        _YL_contents.textColor = [UIColor grayColor];
    }
    return _YL_contents;
}
@end
