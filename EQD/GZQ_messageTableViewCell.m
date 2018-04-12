//
//  GZQ_messageTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/3.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "GZQ_messageTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation GZQ_messageTableViewCell

-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        _IV_head.userInteractionEnabled = YES;
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius =20;
        [self addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
        
    }
    return _IV_head;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.font = [UIFont systemFontOfSize:15];
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_head.mas_top);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
        }];
        
    }
    return _L_name;
}

-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        _L_time.font = [UIFont systemFontOfSize:13];
        _L_time.textColor = [UIColor grayColor];
        [self addSubview:_L_time];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-30);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
        }];
        
    }
    return _L_time;
}
-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents = [[UILabel alloc]init];
        _L_contents.userInteractionEnabled = YES;
        _L_contents.font = [UIFont systemFontOfSize:18];
        _L_contents.numberOfLines =0;
        [self addSubview:_L_contents];
    }
    return _L_contents;
}
-(void)setModel:(GZQ_MessageModel *)model
{
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model.staffName;
    self.L_time.text = model.createTime;
    if ([model.type integerValue]==0) {
        // 点赞
        self.L_contents.text = @"赞了我";
        [self.L_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.height.mas_equalTo(25);
            make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
        }];
        model.cellHeight = 75;
        
    }else if ([model.type integerValue]==1)
    {
        //评论
        NSMutableParagraphStyle  *para = [[NSMutableParagraphStyle alloc]init];
        para.lineSpacing =5;
        CGSize size = [model.commentContent boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSParagraphStyleAttributeName:para} context:nil].size;
        self.L_contents.text = model.commentContent;
        [self.L_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.height.mas_equalTo(size.height+10);
            make.top.mas_equalTo(self.IV_head.mas_bottom).mas_offset(5);
        }];
        model.cellHeight = 50+size.height+10;
    }else
    {
        model.cellHeight = 0;
    }
}

@end
