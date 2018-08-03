//
//  SC_teamMiaoshuTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/6/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "SC_teamMiaoshuTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation SC_teamMiaoshuTableViewCell
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        _IV_head.userInteractionEnabled =YES;
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =6;
        [self addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((DEVICE_WIDTH-30)/2.0, (DEVICE_WIDTH-30)/2.0));
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
        }];
    }
    return _IV_head;
}

-(YYLabel*)YL_name
{
    if (!_YL_name) {
        _YL_name = [[YYLabel alloc]init];
        _YL_name.numberOfLines =0;
        [self addSubview:_YL_name];
        [_YL_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake((DEVICE_WIDTH-30)/2.0-5, (DEVICE_WIDTH-30)/2.0));
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
      
    }
    return _YL_name;
}
-(YYLabel*)YL_contents
{
    if (!_YL_contents) {
        _YL_contents = [[YYLabel alloc]init];
        _YL_contents.numberOfLines =0;
        [self addSubview:_YL_contents];
    }
    return _YL_contents;
}
-(void)setModel_equipment:(WS_equipmentModel *)model_equipment
{
    _model_equipment =model_equipment;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model_equipment.image] placeholderImage:[UIImage imageNamed:@"imageerro"] options:SDWebImageProgressiveDownload];
    model_equipment.cell_height = (DEVICE_WIDTH-30)/2.0+5;
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"设备名称：%@\n设备厂商：%@\n购买日期：%@",model_equipment.EquipmentName,model_equipment.Manufactor,model_equipment.DateOfPurchase] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    name.yy_lineSpacing =6;
    self.YL_name.attributedText = name;
    self.YL_contents.attributedText =nil;
    
    
}
-(void)setModel_team:(SC_TeamModel *)model_team
{
    _model_team =model_team;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model_team.HeadImage] placeholderImage:[UIImage imageNamed:@"imageerro"] options:(SDWebImageProgressiveDownload)];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_team.userName] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18 weight:3]}];
    name.yy_alignment = NSTextAlignmentCenter;
    NSMutableAttributedString  *post = [[NSMutableAttributedString alloc]initWithString:model_team.Post attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:post];
    name.yy_lineSpacing = 6;
    self.YL_name.attributedText = name;
    
    NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:model_team.Msg attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_contents.attributedText = contents;
    model_team.cell_height =size.height+15+(DEVICE_WIDTH-30)/2.0;
    [self.YL_contents mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}

@end
