//
//  FBGongZuo_img_textTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define height_img  ([UIScreen mainScreen].bounds.size.width-50)/3.0
#import "FBGongZuo_img_textTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation FBGongZuo_img_textTableViewCell

-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        _V_bg.userInteractionEnabled=YES;
        [self addSubview:_V_bg];
        [_V_bg  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _V_bg;
}
-(UIView*)V_top
{
    if (!_V_top) {
        _V_top =[[UIView alloc]init];
        _V_top.userInteractionEnabled=YES;
        [self.V_bg addSubview:_V_top];
        [_V_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.top.mas_equalTo(self.V_bg.mas_top);
            make.left.mas_equalTo(self.V_bg.mas_left);
        }];
        
    }
    return _V_top;
}
-(UIView*)V_bottom
{
    if (!_V_bottom) {
        _V_bottom =[[UIView alloc]init];
        _V_bottom.userInteractionEnabled=YES;
        [self.V_bg addSubview:_V_bottom];
        [_V_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.bottom.mas_equalTo(self.V_bg.mas_bottom);
            make.right.mas_equalTo(self.V_bg.mas_right);
            make.left.mas_equalTo(self.V_bg.mas_left);
        }];
        
    }
    return _V_bottom;
}
-(UILabel*)L_address
{
    if(!_L_address)
    {
        _L_address = [[UILabel alloc]init];
        [self.V_bg addSubview:_L_address];
        _L_address.font =[UIFont systemFontOfSize:13];
        _L_address.textColor = [UIColor grayColor];
        [_L_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self.V_bg);
            make.bottom.mas_equalTo(self.V_bottom.mas_top).mas_offset(-2);
        }];
        
    }
    return _L_address;
}
-(UIImageView*)IV_right0
{
    if (!_IV_right0) {
        _IV_right0 =[[UIImageView alloc]init];
        _IV_right0.userInteractionEnabled=YES;
        [self.V_top addSubview:_IV_right0];
        _IV_right0.image = [UIImage imageNamed:@"ic_arrow"];
        _IV_right0.transform =CGAffineTransformMakeRotation(M_PI_2);
        [_IV_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(34, 34));
            make.right.mas_equalTo(self.V_top.mas_right);
            make.top.mas_equalTo(self.IV_head.mas_top).mas_offset(-10);
        }];
        
    }
    return _IV_right0;
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head =[[UIImageView alloc]init];
        _IV_head.userInteractionEnabled=YES;
        [self.V_top addSubview:_IV_head];
        _IV_head.userInteractionEnabled =YES;
        _IV_head.layer.masksToBounds=YES;
        _IV_head.layer.cornerRadius=20;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
            make.left.mas_equalTo(self.V_top.mas_left);
        }];
    }
    return _IV_head;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1.userInteractionEnabled=YES;
        _L_left1 =[[UILabel alloc]init];
        _L_left1.textColor=[UIColor grayColor];
        _L_left1.font =[UIFont systemFontOfSize:13];
        [self.V_top addSubview:_L_left1];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
            make.right.mas_equalTo(self.L_right1.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_left1;
}
-(UILabel*)L_right1
{
    if (!_L_right1) {
        _L_right1 =[[UILabel alloc]init];
        _L_right1.userInteractionEnabled=YES;
        [self.V_top addSubview:_L_right1];
        _L_right1.font=[UIFont systemFontOfSize:13];
        _L_right1.textColor=[UIColor grayColor];
        _L_right1.textAlignment =NSTextAlignmentRight;
        [_L_right1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(self.V_top.mas_right);
            make.left.mas_equalTo(self.L_left1.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
        }];
    }
    return _L_right1;
}
-(UILabel*)L_left0
{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        _L_left0.userInteractionEnabled=YES;
        _L_left0.font =[UIFont systemFontOfSize:17];
        [self.V_top addSubview:_L_left0];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.IV_right0.mas_left).mas_offset(-5);
            make.height.mas_equalTo(24);
            make.top.mas_equalTo(self.IV_head.mas_top);
        }];
        
    }
    return _L_left0;
}
-(UIImageView*)IV_zan
{
    if (!_IV_zan) {
        _IV_zan =[[UIImageView alloc]init];
        _IV_zan.userInteractionEnabled=YES;
        _IV_zan.image=[UIImage imageNamed:@"zan_false"];
        [self.V_bottom addSubview:_IV_zan];
        [_IV_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.mas_equalTo(self.L_zan.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
        }];
        
    }
    return _IV_zan;
}
-(UIImageView*)IV_liuyan
{
    if (!_IV_liuyan) {
        _IV_liuyan =[[UIImageView alloc]init];
        [self.V_bottom addSubview:_IV_liuyan];
        _IV_liuyan.image=[UIImage imageNamed:@"pinglun"];
        _IV_liuyan.userInteractionEnabled =YES;
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.mas_equalTo(self.L_liuyan.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            
        }];
        
    }
    return _IV_liuyan;
}
-(UILabel*)L_liuyan
{
    if (!_L_liuyan) {
        _L_liuyan =[[UILabel alloc]init];
        [self addSubview:_L_liuyan];
        _L_liuyan.font=[UIFont systemFontOfSize:13];
        _L_liuyan.textAlignment=NSTextAlignmentCenter;
        _L_liuyan.textColor =[UIColor grayColor];
        [_L_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.right.mas_equalTo(self.V_bottom.mas_right);
            make.left.mas_equalTo(self.IV_liuyan.mas_right).mas_offset(5);
        }];
    }
    return _L_liuyan;
}

-(UILabel*)L_zan
{
    if (!_L_zan) {
        _L_zan =[[UILabel alloc]init];
        [self addSubview:_L_zan];
        _L_zan.font =[UIFont systemFontOfSize:13];
        _L_zan.textColor =[UIColor grayColor];
        _L_zan.textAlignment =NSTextAlignmentCenter;
        [_L_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.right.mas_equalTo(self.IV_liuyan.mas_left).mas_offset(-20);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.left.mas_equalTo(self.IV_zan.mas_right).mas_offset(5);
        }];
        
    }
    return _L_zan;
}
-(void)setModel:(MoreBaseModel *)model
{
    _model=model;
    self.L_address.text =model.address;
    if (model.contents.length!=0 &&model.imgurls.count==0) {
        CGSize size =[model.contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 75) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        self.L_contents.frame =CGRectMake(0, 55, DEVICE_WIDTH-30, size.height);
         self.L_contents.text =model.contents;
        self.IV_img1.frame=CGRectZero;
        self.IV_img2.frame=CGRectZero;
        self.IV_img3.frame=CGRectZero;
        self.L_imgnum.frame=CGRectZero;
    }
    
    else if(model.contents.length!=0 && model.imgurls.count!=0)
    {
        
        CGSize size =[model.contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 75) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size;
        self.L_contents.text =model.contents;
        self.L_contents.frame =CGRectMake(0, 55, DEVICE_WIDTH-30, size.height);
       if (model.imgurls.count==1) {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if(image.size.width >image.size.height)
                {
                self.IV_img1.frame=CGRectMake(0, 60+size.height+2, (DEVICE_WIDTH-30)*3/4, ((DEVICE_WIDTH-30)*3/4)*image.size.height/image.size.width);
                    self.cell_height =105+size.height+((DEVICE_WIDTH-30)*3/4)*image.size.height/image.size.width+24;
                }
                else
                {
                    self.IV_img1.frame =CGRectMake(0, 60+size.height+2, ((DEVICE_WIDTH-30)*3/4)*image.size.width/image.size.height, (DEVICE_WIDTH-30)*3/4);
                    self.cell_height =105+size.height+(DEVICE_WIDTH-30)*3/4+24;
                }
            }];
            
            self.IV_img2.frame=CGRectZero;
            self.IV_img3.frame=CGRectZero;
            self.L_imgnum.frame=CGRectZero;
        }
        else if (model.imgurls.count==2)
        {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            self.IV_img3.frame =CGRectZero;
            self.IV_img1.frame=CGRectMake(0, 60+size.height, height_img, height_img);
            self.IV_img2.frame=CGRectMake(height_img+10, 60+size.height, height_img, height_img);
            self.cell_height =105+size.height+height_img+24;
            self.L_imgnum.frame=CGRectZero;
        }
        else if (model.imgurls.count==3)
        {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            
            self.IV_img3.frame =CGRectMake(20+height_img*2, 60+size.height, height_img, height_img);
            self.IV_img1.frame=CGRectMake(0, 60+size.height, height_img, height_img);
            self.IV_img2.frame=CGRectMake(height_img+10, 60+size.height, height_img, height_img);
            self.L_imgnum.frame=CGRectZero;
            self.cell_height =105+size.height+height_img+24;
        }
        else
        {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            
            self.IV_img3.frame =CGRectMake(20+height_img*2, 60+size.height, height_img, height_img);
            self.IV_img1.frame=CGRectMake(0, 60+size.height, height_img, height_img);
            self.IV_img2.frame=CGRectMake(height_img+10, 60+size.height, height_img, height_img);
            self.cell_height =105+size.height+height_img+24;
            self.L_imgnum.frame=CGRectMake(0, 0, height_img, height_img);
            self.L_imgnum.text =[NSString stringWithFormat:@"+%lu",model.imgurls.count-3];
            
        }
    }
    /*
  else if (model.contents.length!=0 && model.imgurls.count==0) {
        self.IV_img3.frame=CGRectZero;
        self.IV_img2.frame=CGRectZero;
        self.IV_img1.frame=CGRectZero;
      self.L_imgnum.frame=CGRectZero;
        CGSize size =[model.contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, 75) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
        self.L_contents.text =model.contents;
        self.L_contents.frame =CGRectMake(0, 55, DEVICE_WIDTH-30, size.height);
        self.cell_height =100+size.height+24;
    
    }*/
    else if (model.contents.length==0 && model.imgurls.count!=0)
    {
        self.L_contents.frame=CGRectZero;
        if (model.imgurls.count==1) {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image.size.width >image.size.height)
                {
                    self.IV_img1.frame=CGRectMake(0, 55, (DEVICE_WIDTH-30)*3/4, ((DEVICE_WIDTH-30)*3/4)*image.size.height/image.size.width);
                }
                else
                {
                    self.IV_img1.frame =CGRectMake(0, 55, ((DEVICE_WIDTH-30)*3/4)*image.size.width/image.size.height, (DEVICE_WIDTH-30)*3/4);
                    
                }
            }];
            self.IV_img2.frame=CGRectZero;
            self.IV_img3.frame=CGRectZero;
            self.L_imgnum.frame=CGRectZero;
        }
        else if (model.imgurls.count==2)
        {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            self.IV_img3.frame =CGRectZero;
            self.IV_img1.frame=CGRectMake(0, 55, height_img, height_img);
            self.IV_img2.frame=CGRectMake(height_img+10, 55, height_img, height_img);
            self.cell_height =100+height_img+24;
            self.L_imgnum.frame=CGRectZero;
        }
        else if (model.imgurls.count==3)
        {
           
            
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            
            self.IV_img3.frame =CGRectMake(20+height_img*2, 55, height_img, height_img);
            self.IV_img1.frame=CGRectMake(0, 55, height_img, height_img);
            self.IV_img2.frame=CGRectMake(height_img+10, 55, height_img, height_img);
            self.L_imgnum.frame=CGRectZero;
            self.cell_height =100+height_img+24;
        }
        else
        {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            
            self.IV_img3.frame =CGRectMake(20+height_img*2, 55, height_img, height_img);
            self.IV_img1.frame=CGRectMake(0, 55, height_img, height_img);
            self.IV_img2.frame=CGRectMake(height_img+10, 55, height_img, height_img);
            self.cell_height =100+height_img+24;
            self.L_imgnum.frame=CGRectMake(0, 0, height_img, height_img);
            self.L_imgnum.text =[NSString stringWithFormat:@"+%ld",model.imgurls.count-3];
    }
    }
    else
    {
        self.L_contents.frame=CGRectZero;
        self.IV_img2.frame=CGRectZero;
        self.IV_img3.frame=CGRectZero;
        self.L_imgnum.frame=CGRectZero;
        self.IV_img1.frame=CGRectZero;
        self.cell_height = 95+24;
    }
    
    
    
    ///对点赞人的动态处理
    if (model.zan_imgurls.count==0) {
        self.IV_zan1.frame =CGRectMake(0, 3, 24, 24);
        self.IV_zan1.image =[UIImage imageNamed:@"ic_arrow"];
        self.IV_zan2.frame=CGRectZero;
        self.IV_zan3.frame=CGRectZero;
        self.IV_zan4.frame=CGRectZero;
        
    }
    else if(model.zan_imgurls.count==1)
    {
        self.IV_zan1.frame=CGRectMake(0, 3, 24, 24);
        self.IV_zan2.frame=CGRectMake(30, 3, 24, 24);
        self.IV_zan3.frame=CGRectZero;
        self.IV_zan4.frame =CGRectZero;
        
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:model.zan_imgurls[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan2.image =[UIImage imageNamed:@"ic_arrow"];
        }
    else if(model.zan_imgurls.count==2)
    {
        self.IV_zan1.frame=CGRectMake(0, 3, 24, 24);
        self.IV_zan2.frame=CGRectMake(30, 3, 24, 24);
        self.IV_zan3.frame=CGRectMake(60, 3, 24, 24);
        self.IV_zan4.frame =CGRectZero;
        self.IV_zan3.image =[UIImage imageNamed:@"ic_arrow"];
         [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:[model.zan_imgurls[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
         [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:[model.zan_imgurls[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    }
    else
    {
        self.IV_zan1.frame=CGRectMake(0, 3, 24, 24);
        self.IV_zan2.frame=CGRectMake(30, 3, 24, 24);
        self.IV_zan3.frame=CGRectMake(60, 3, 24, 24);
        self.IV_zan4.frame =CGRectMake(90, 3, 24, 24);
        self.IV_zan4.image=[UIImage imageNamed:@"ic_arrow"];
         [self.IV_zan3 sd_setImageWithURL:[NSURL URLWithString:[model.zan_imgurls[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:[model.zan_imgurls[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:[model.zan_imgurls[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    }
    
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.head_imgurl] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_left0.text =model.left0;
    self.L_left1.text =model.left1;
    self.L_right1.text =model.right1;
    self.L_zan.text =model.bottom_right1;
    self.L_liuyan.text=model.bottom_right0;
    if([model.isZan_FB integerValue]==0)
    {
        self.IV_zan.userInteractionEnabled=YES;
        self.IV_zan.image =[UIImage imageNamed:@"zan_false"];
    }
    else
    {
        self.IV_zan.userInteractionEnabled=NO;
         self.IV_zan.image =[UIImage imageNamed:@"zan_true"];
    }
    
    
}

-(void)updateliuyan
{
    self.L_liuyan.text =[NSString stringWithFormat:@"%ld",[self.L_liuyan.text integerValue]+1];
    
}
-(void)updateZan_numWithuserphoto:(NSString*)userPhoto Andmodel:(MoreBaseModel*)model
{
    self.IV_zan.userInteractionEnabled=NO;
    self.IV_zan.image =[UIImage imageNamed:@"zan_true"];
    self.L_zan.text = [NSString stringWithFormat:@"%ld",[model.bottom_right1 integerValue]+1];
    NSMutableArray *tarr =[NSMutableArray arrayWithArray:model.zan_imgurls];
    [tarr insertObject:userPhoto atIndex:0];
    if(tarr.count==1)
    {
        self.IV_zan1.frame=CGRectMake(0, 3, 24, 24);
        self.IV_zan2.frame=CGRectMake(30, 3, 24, 24);
        self.IV_zan3.frame=CGRectZero;
        self.IV_zan4.frame =CGRectZero;
        
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:tarr[0]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan2.image =[UIImage imageNamed:@"ic_arrow"];
    }
    else if(tarr.count==2)
    {
        self.IV_zan1.frame=CGRectMake(0, 3, 24, 24);
        self.IV_zan2.frame=CGRectMake(30, 3, 24, 24);
        self.IV_zan3.frame=CGRectMake(60, 3, 24, 24);
        self.IV_zan4.frame =CGRectZero;
        self.IV_zan3.image =[UIImage imageNamed:@"ic_arrow"];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:[tarr[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:[tarr[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    }
    else
    {
        self.IV_zan1.frame=CGRectMake(0, 3, 24, 24);
        self.IV_zan2.frame=CGRectMake(30, 3, 24, 24);
        self.IV_zan3.frame=CGRectMake(60, 3, 24, 24);
        self.IV_zan4.frame =CGRectMake(90, 3, 24, 24);
        self.IV_zan4.image=[UIImage imageNamed:@"ic_arrow"];
        [self.IV_zan3 sd_setImageWithURL:[NSURL URLWithString:[tarr[2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:[tarr[1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:[tarr[0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    }
    
}

-(UILabel *)L_imgnum
{
    if (!_L_imgnum) {
        _L_imgnum =[[UILabel alloc]init];
        _L_imgnum.userInteractionEnabled=YES;
        _L_imgnum.backgroundColor =[[UIColor lightGrayColor]colorWithAlphaComponent:0.4];
        _L_imgnum.font =[UIFont systemFontOfSize:40];
        _L_imgnum.textAlignment =NSTextAlignmentCenter;
        [self.IV_img3 addSubview:_L_imgnum];
    }
    return _L_imgnum;
}

-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents =[[UILabel alloc]init];
        _L_contents.userInteractionEnabled=YES;
        _L_contents.font=[UIFont systemFontOfSize:17];
        _L_contents.numberOfLines=4;
        [self.V_bg addSubview:_L_contents];
    }
    return _L_contents;
}

-(UIImageView*)IV_zan1
{
    if (!_IV_zan1) {
        _IV_zan1 =[[UIImageView alloc]init];
        _IV_zan1.layer.masksToBounds=YES;
        _IV_zan1.layer.cornerRadius=12;
        _IV_zan1.userInteractionEnabled=YES;
        _IV_zan1.tag=1090;
        [self.V_bottom addSubview:_IV_zan1];
       
    }
    return _IV_zan1;
}
-(UIImageView*)IV_zan2
{
    if (!_IV_zan2) {
        _IV_zan2 =[[UIImageView alloc]init];
        _IV_zan2.layer.masksToBounds=YES;
        _IV_zan2.layer.cornerRadius=12;
        _IV_zan2.userInteractionEnabled=YES;
        _IV_zan2.tag=1091;
        [self.V_bottom addSubview:_IV_zan2];
       
    }
    return _IV_zan2;
}
-(UIImageView*)IV_zan3
{
    if (!_IV_zan3) {
        _IV_zan3 =[[UIImageView alloc]init];
        _IV_zan3.layer.masksToBounds=YES;
        _IV_zan3.layer.cornerRadius=12;
        _IV_zan3.userInteractionEnabled=YES;
        _IV_zan3.tag=1092;
        [self.V_bottom addSubview:_IV_zan3];
       
        
    }
    return _IV_zan3;
}
-(UIImageView*)IV_zan4
{
    if (!_IV_zan4) {
        _IV_zan4=[[UIImageView alloc]init];
        _IV_zan4.layer.masksToBounds=YES;
        _IV_zan4.layer.cornerRadius=12;
        _IV_zan4.userInteractionEnabled=YES;
        _IV_zan4.tag=1093;
        [self.V_bottom addSubview:_IV_zan4];

        
    }
    return _IV_zan4;
}

-(UIImageView*)IV_img1
{
    if (!_IV_img1) {
        _IV_img1 =[[UIImageView alloc]init];
        _IV_img1.userInteractionEnabled=YES;
         _IV_img1.tag=1800;
        _IV_img1.layer.masksToBounds=YES;
        _IV_img1.layer.cornerRadius=5;
        [self.V_bg addSubview:_IV_img1];
    }
    return _IV_img1;
    
}
-(UIImageView*)IV_img2
{
    if (!_IV_img2) {
        _IV_img2 =[[UIImageView alloc]init];
        _IV_img2.userInteractionEnabled=YES;
         _IV_img2.tag=1801;
        _IV_img2.layer.masksToBounds=YES;
        _IV_img2.layer.cornerRadius=5;
        [self.V_bg addSubview:_IV_img2];
    }
    return _IV_img2;
}
-(UIImageView*)IV_img3
{
    if(!_IV_img3)
    {
        _IV_img3 =[[UIImageView alloc]init];
        _IV_img3.userInteractionEnabled=YES;
        _IV_img3.tag=1802;
        _IV_img3.layer.masksToBounds=YES;
        _IV_img3.layer.cornerRadius=5;
        [self.V_bg addSubview:_IV_img3];
           }
    return _IV_img3;
}
@end
