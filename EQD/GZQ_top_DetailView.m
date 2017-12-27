//
//  GZQ_top_DetailView.m
//  EQD
//
//  Created by 梁新帅 on 2017/8/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define height_img  ([UIScreen mainScreen].bounds.size.width-50)/3.0

#import "GZQ_top_DetailView.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation GZQ_top_DetailView

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
-(NSMutableArray*)arr_imgs
{
    if (!_arr_imgs) {
        _arr_imgs =[NSMutableArray arrayWithArray:@[self.IV_img1,self.IV_img2,self.IV_img3,self.IV_img4,self.IV_img5,self.IV_img6,self.IV_img7,self.IV_img8,self.IV_img9]];
    }
    return _arr_imgs;
}
-(void)setModel:(GongZuoQunModel *)model
{
    _model =model;
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model.head_imgurl] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text =model.left0;
    self.L_bumen.text=model.left1;
    self.L_time.text=model.right1;
    self.L_zan.text =model.bottom_right1;
    self.L_liuyan.text=model.bottom_right0;
    self.L_address.text = model.address;
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
    self.height_view =95+25;
    CGSize size =[model.contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    NSInteger number =model.imgurls.count/3+(model.imgurls.count%3==0?0:1);
    if (model.contents.length>0&&model.imgurls.count>0) {
        self.height_view =100+size.height+(height_img+5)*number+25;
        self.L_contents.frame=CGRectMake(0, 55, DEVICE_WIDTH-30, size.height);
        self.L_contents.text=model.contents;
        if (model.imgurls.count==1) {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image.size.width > image.size.height) {
                    self.IV_img1.frame=CGRectMake(0,60+size.height,(DEVICE_WIDTH-30)*3/4.0, image.size.height*(DEVICE_WIDTH-30)*3/4/image.size.width);
                    self.height_view=100+image.size.height*(DEVICE_WIDTH-30)*3/4/image.size.width+size.height+25;
                }
                else
                {
                    self.IV_img1.frame=CGRectMake(0,60+size.height,image.size.width*(DEVICE_WIDTH-30)*3/4/image.size.height, (DEVICE_WIDTH-30)*3/4.0);
                    self.height_view=120+(DEVICE_WIDTH-30)*3/4.0+25;
                }
               
                
            }];
            
            for (int i=1; i<self.arr_imgs.count; i++) {
                UIImageView *IV_img =self.arr_imgs[i];
                IV_img.frame=CGRectZero;
            }
            
            
        }
        else
        {
            self.height_view= 100+number*(height_img+5)+size.height+25;
            for (int i=0; i<self.arr_imgs.count; i++) {
                UIImageView *IV_img =self.arr_imgs[i];
                IV_img.frame=CGRectZero;
                IV_img.image=nil;
            }
            for (int i=0; i<model.imgurls.count; i++) {
                UIImageView *IV_img =self.arr_imgs[i];
                IV_img.frame =CGRectMake((height_img+10)*(i%3), 60+size.height+(height_img+5)*(i/3), height_img, height_img);
                [IV_img sd_setImageWithURL:[NSURL URLWithString:model.imgurls[i]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            }
            
        }
    }
    else if (model.contents.length>0&&model.imgurls.count==0)
    {
        self.L_contents.frame=CGRectMake(0, 55, DEVICE_WIDTH-30, size.height);
        self.height_view =100+size.height+25;
        self.L_contents.text =model.contents;
    }
    else if (model.contents.length==0&&model.imgurls.count>0)
    {
        
        
        if (model.imgurls.count==1) {
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model.imgurls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
                if (image.size.width > image.size.height) {
                    self.IV_img1.frame=CGRectMake(0,60,(DEVICE_WIDTH-30)*3/4.0, image.size.height*(DEVICE_WIDTH-30)*3/4/image.size.width);
                    self.height_view=105+image.size.height*(DEVICE_WIDTH-30)*3/4/image.size.width+size.height+25;
                }
                else
                {
                    self.IV_img1.frame=CGRectMake(0,60,image.size.width*(DEVICE_WIDTH-30)*3/4/image.size.height, (DEVICE_WIDTH-30)*3/4.0);
                    self.height_view=100+(DEVICE_WIDTH-30)*3/4.0+25;
                }
               
                
            }];
            
            for (int i=1; i<self.arr_imgs.count; i++) {
                UIImageView *IV_img =self.arr_imgs[i];
                IV_img.frame=CGRectZero;
            }
            
            
        }
        else
        {
            self.height_view= 100+number*(height_img+5)+25;
            
            for (int i=0; i<self.arr_imgs.count; i++) {
                UIImageView *IV_img =self.arr_imgs[i];
                IV_img.frame=CGRectZero;
                IV_img.image=nil;
            }
            for (int i=0; i<model.imgurls.count; i++) {
                UIImageView *IV_img =self.arr_imgs[i];
                IV_img.frame =CGRectMake((height_img+10)*(i%3), 55+(height_img+5)*(i/3), height_img, height_img);
                [IV_img sd_setImageWithURL:[NSURL URLWithString:model.imgurls[i]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            }
            
        }
        
    }
    else
    {
        self.L_contents.frame=CGRectZero;
        self.IV_img1.frame=CGRectZero;
        self.IV_img2.frame=CGRectZero;
        self.IV_img3.frame=CGRectZero;
        self.IV_img4.frame=CGRectZero;
        self.IV_img5.frame=CGRectZero;
        self.IV_img6.frame=CGRectZero;
        self.IV_img7.frame=CGRectZero;
        self.IV_img8.frame=CGRectZero;
        self.IV_img9.frame=CGRectZero;
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

    
    
    
}
-(void)updateliuyan
{
    self.L_liuyan.text =[NSString stringWithFormat:@"%ld",[self.L_liuyan.text integerValue]+1];
    
}
-(void)updateliuyan2
{
   self.L_liuyan.text =[NSString stringWithFormat:@"%ld",[self.L_liuyan.text integerValue]-1];
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


-(UIView*)V_bg
{
    if (!_V_bg) {
        _V_bg =[[UIView alloc]init];
        _V_bg.userInteractionEnabled =YES;
        [self addSubview:_V_bg];
        [_V_bg mas_makeConstraints:^(MASConstraintMaker *make) {
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
            make.left.top.right.mas_equalTo(self.V_bg);
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
            make.left.right.bottom.mas_equalTo(self.V_bg);
        }];
        
    }
    return _V_bottom;
}
-(UILabel*)L_contents
{
    if (!_L_contents) {
        _L_contents=[[UILabel alloc]init];
        _L_contents.numberOfLines=0;
        [self.V_bg addSubview:_L_contents];
        _L_contents.font =[UIFont systemFontOfSize:15];
        
    }
    return _L_contents;
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head =[[UIImageView alloc]init];
        _IV_head.layer.masksToBounds=YES;
        _IV_head.userInteractionEnabled=YES;
        _IV_head.layer.cornerRadius=20;
        [self.V_top addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
            make.left.mas_equalTo(self.V_top.mas_left);
        }];
        
    }
    return _IV_head;
}
-(UIImageView*)IV_zhuanfa
{
    if (!_IV_zhuanfa) {
        _IV_zhuanfa =[[UIImageView alloc]init];
        _IV_zhuanfa.userInteractionEnabled=YES;
        _IV_zhuanfa.image=[UIImage imageNamed:@"delete_eqd"];
        [self.V_top addSubview:_IV_zhuanfa];
        
        [_IV_zhuanfa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(24, 24));
            make.right.top.mas_equalTo(self.V_top);
        }];
        
    }
    return _IV_zhuanfa;
}
-(UILabel*)L_name
{
    if(!_L_name)
    {
        _L_name =[[UILabel alloc]init];
        _L_name.font =[UIFont systemFontOfSize:17];
        _L_name.userInteractionEnabled=YES;
        [self.V_top addSubview:_L_name];
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(24);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.IV_head.mas_top);
            make.right.mas_equalTo(self.IV_zhuanfa.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_name;
}
-(UILabel*)L_bumen
{
    if (!_L_bumen) {
        _L_bumen =[[UILabel alloc]init];
        _L_bumen.font =[UIFont systemFontOfSize:13];
        _L_bumen.textColor=[UIColor grayColor];
        [self.V_top addSubview:_L_bumen];
        [_L_bumen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
            make.right.mas_equalTo(self.L_time.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_bumen;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time =[[UILabel alloc]init];
        _L_time.font =[UIFont systemFontOfSize:13];
        _L_time.textColor=[UIColor grayColor];
        _L_time.textAlignment =NSTextAlignmentRight;
        [self.V_top addSubview:_L_time];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(16);
            make.left.mas_equalTo(self.L_bumen.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_top.mas_right);
            make.bottom.mas_equalTo(self.IV_head.mas_bottom);
        }];
    }
    return _L_time;
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
        [self.V_bottom addSubview:_L_liuyan];
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
        [self.V_bottom addSubview:_L_zan];
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

-(UIImageView*)IV_zan1
{
    if (!_IV_zan1) {
        _IV_zan1 =[[UIImageView alloc]init];
        _IV_zan1.layer.masksToBounds=YES;
        _IV_zan1.layer.cornerRadius=12;
        _IV_zan1.userInteractionEnabled=YES;
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
        [self.V_bottom addSubview:_IV_zan4];
        
        
    }
    return _IV_zan4;
}

-(UIImageView*)IV_img1
{
    if (!_IV_img1) {
        _IV_img1 =[[UIImageView alloc]init];
        _IV_img1.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img1];
    }
    return _IV_img1;
    
}
-(UIImageView*)IV_img2
{
    if (!_IV_img2) {
        _IV_img2 =[[UIImageView alloc]init];
        _IV_img2.userInteractionEnabled=YES;
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
        [self.V_bg addSubview:_IV_img3];
    }
    return _IV_img3;
}
-(UIImageView*)IV_img4
{
    if (!_IV_img4) {
        _IV_img4 =[[UIImageView alloc]init];
        _IV_img4.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img4];
    }
    return _IV_img4;
    
}
-(UIImageView*)IV_img5
{
    if (!_IV_img5) {
        _IV_img5 =[[UIImageView alloc]init];
        _IV_img5.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img5];
    }
    return _IV_img5;
}
-(UIImageView*)IV_img6
{
    if(!_IV_img6)
    {
        _IV_img6 =[[UIImageView alloc]init];
        _IV_img6.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img6];
    }
    return _IV_img6;
}
-(UIImageView*)IV_img7
{
    if (!_IV_img7) {
        _IV_img7 =[[UIImageView alloc]init];
        _IV_img7.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img7];
    }
    return _IV_img7;
    
}
-(UIImageView*)IV_img8
{
    if (!_IV_img8) {
        _IV_img8 =[[UIImageView alloc]init];
        _IV_img8.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img8];
    }
    return _IV_img8;
}
-(UIImageView*)IV_img9
{
    if(!_IV_img9)
    {
        _IV_img9 =[[UIImageView alloc]init];
        _IV_img9.userInteractionEnabled=YES;
        [self.V_bg addSubview:_IV_img9];
    }
    return _IV_img9;
}
@end
