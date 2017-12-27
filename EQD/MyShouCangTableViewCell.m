//
//  MyShouCangTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/10/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "MyShouCangTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "WebRequest.h"
@implementation MyShouCangTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setModel:(MyShouCangModel *)model
{
    _model =model;
    self.IV_img3.frame =CGRectZero;
    self.IV_img2.frame =CGRectZero;
    self.IV_img1.frame =CGRectZero;
    self.L_content.frame=CGRectZero;
    
    UserModel *user = [WebRequest GetUserInfo];
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.sourceOwner.avatar] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text =model.sourceOwner.nickname==nil?user.upname:model.sourceOwner.nickname;
    self.L_time.text = model.Collection.createTime;
                    float width =(DEVICE_WIDTH-40)/3.0;
    self.L_from.frame = CGRectMake(15, 40+width, DEVICE_WIDTH-30, 20);
    self.L_from.text =model.Collection.source.length==0? @"我的收藏":model.Collection.source;
    CGSize size = [model.Collection.content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30,width-10) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    switch ([model.Collection.type integerValue]) {
        case 1:
            {
       if (model.Collection.arr_urls.count==1) {
           [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
           self.IV_img1.frame =CGRectMake(15, 40, width, width);
                }else
                {
                    
                    if (model.Collection.arr_urls.count==2) {
                        self.IV_img1.frame =CGRectMake(15, 40, width, width);
                        self.IV_img2.frame=CGRectMake(15+width+5, 40, width, width);
                        [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                     [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                    }else
                    {
                        self.IV_img1.frame =CGRectMake(15, 40, width, width);
                        self.IV_img2.frame=CGRectMake(15+width+5, 40, width, width);
                        self.IV_img3.frame=CGRectMake(15+width+5+width+5, 40, width, width);
                        [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                        [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                          [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                    }
                }
            }
            break;
        case 2:
        {
            self.L_content.frame = CGRectMake(15, 45, DEVICE_WIDTH-30, size.height+5);
            self.L_content.text = model.Collection.content;
            self.L_from.frame = CGRectMake(15, 40+size.height+10, DEVICE_WIDTH-30, 20);
        }
            break;
        case 3:
        {
            self.IV_img1.frame = CGRectMake(15, 40, width, width);
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            self.L_content.text =model.Collection.content;
            
            self.L_content.frame =CGRectMake(20+width, 45, DEVICE_WIDTH-30-width, size.height+2);
        }
            break;
        case 4:
        {
            self.IV_img1.frame = CGRectMake(15, 40, width, width);
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            
            self.L_content.text =model.Collection.content;
            self.L_content.frame =CGRectMake(20+width, 45, DEVICE_WIDTH-30-width, size.height+2);
        }
            break;
        case 5:
        {
            //语音
            self.IV_img1.frame =CGRectMake(15, 40, 40, 40);
            self.L_content.text = model.Collection.content;
            self.IV_img1.image =[UIImage imageNamed:@"record_high"];
            self.L_content.frame =CGRectMake(65, 45, DEVICE_WIDTH-30-40, 30);
        }
            break;
        case 6:
        {
         //位置
            self.IV_img1.frame = CGRectMake(15, 40, 40, 40);
            self.IV_img1.image = [UIImage imageNamed:@"eqd_locate"];
            self.L_content.text =model.Collection.content;
            self.L_content.frame =CGRectMake(65, 45, DEVICE_WIDTH-30-65, size.height+2);
        }
            break;
        case 7:
        {
            self.IV_img1.frame = CGRectMake(15, 40, width, width);
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            
            self.L_content.text =model.Collection.title;
            self.L_content.frame =CGRectMake(20+width, 40+(width-30)/2.0, DEVICE_WIDTH-30-width, 30);
            
        }
            break;
        case 8:
        {
            if (model.Collection.arr_urls.count==1) {
                [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                self.IV_img1.frame =CGRectMake(15, 40, width, width);
            }else
            {
                
                if (model.Collection.arr_urls.count==2) {
                    self.IV_img1.frame =CGRectMake(15, 40, width, width);
                    self.IV_img2.frame=CGRectMake(15+width+5, 40, width, width);
                    [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                    [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                }else
                {
                    self.IV_img1.frame =CGRectMake(15, 40, width, width);
                    self.IV_img2.frame=CGRectMake(15+width+5, 40, width, width);
                    self.IV_img3.frame=CGRectMake(15+width+5+width+5, 40, width, width);
                    [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                    [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                    [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
                }
            }
        }
            break;
        case 9:
        {
            self.IV_img1.frame = CGRectMake(15, 40, width, width);
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.Collection.arr_urls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            self.L_content.text =model.Collection.content;
            
            self.L_content.frame =CGRectMake(20+width, 45, DEVICE_WIDTH-30-width, size.height+2);
        }
            break;
            
        default:
            break;
    }
    
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head =[[UIImageView alloc]init];
        [self addSubview:_IV_head];
        _IV_head.userInteractionEnabled=YES;
        _IV_head.layer.masksToBounds=YES;
        _IV_head.layer.cornerRadius=15;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
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
        _L_name.font = [UIFont systemFontOfSize:17];
        _L_name.userInteractionEnabled=YES;
        [self addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.right.mas_equalTo(self.L_time.mas_left).mas_offset(-5);
        }];
    }
    return _L_name;
}

-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time =[[UILabel alloc]init];
        _L_time.font = [UIFont systemFontOfSize:13];
        _L_time.userInteractionEnabled=YES;
        _L_time.textColor =[UIColor grayColor];
        _L_time.textAlignment = NSTextAlignmentRight;
        [self addSubview:_L_time];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.left.mas_equalTo(self.L_name.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
        }];
        
    }
    return _L_time;
}

-(UILabel*)L_content
{
    if (!_L_content) {
        _L_content = [[UILabel alloc]init];
        [self addSubview:_L_content];
        _L_content.numberOfLines=0;
        _L_content.userInteractionEnabled=YES;
        _L_content.font = [UIFont systemFontOfSize:15];
        _L_content.frame =CGRectZero;
    }
    return _L_content;
}
-(UIImageView*)IV_img1
{
    if (!_IV_img1) {
        _IV_img1  = [[UIImageView alloc]init];
        _IV_img1.userInteractionEnabled =YES;
        _IV_img1.layer.masksToBounds=YES;
        _IV_img1.layer.cornerRadius=5;
        [self addSubview:_IV_img1];
    }
    return _IV_img1;
}
-(UIImageView*)IV_img2
{
    if (!_IV_img2) {
        _IV_img2 = [[UIImageView alloc]init];
        _IV_img2.layer.masksToBounds=YES;
        _IV_img2.layer.cornerRadius=5;
        _IV_img2.userInteractionEnabled =YES;
        [self addSubview:_IV_img2];
    }
    return _IV_img2;
}
-(UIImageView*)IV_img3
{
    if (!_IV_img3) {
        _IV_img3 = [[UIImageView alloc]init];
        _IV_img3.layer.masksToBounds=YES;
        _IV_img3.layer.cornerRadius=5;
        [self addSubview:_IV_img3];
        _IV_img3.userInteractionEnabled=YES;
    }
    return _IV_img3;
}
-(UILabel*)L_from
{
    if (!_L_from) {
        _L_from  =[[UILabel alloc]init];
        _L_from.font = [UIFont systemFontOfSize:12];
        _L_from.userInteractionEnabled = YES;
        _L_from.textColor = [UIColor grayColor];
        [self addSubview:_L_from];
        [_L_from mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _L_from;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
