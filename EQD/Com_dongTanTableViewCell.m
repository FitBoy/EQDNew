//
//  Com_dongTanTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/5/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]
#import "Com_dongTanTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation Com_dongTanTableViewCell
-(void)setModel_dongtai:(Com_dongTanModel *)model_dongtai
{
    _model_dongtai = model_dongtai;
    [self setHiddenSomeView];
    [self.V_top setHead:model_dongtai.iphoto name:model_dongtai.staffName bumen:[NSString stringWithFormat:@"%@-%@",model_dongtai.departName,model_dongtai.postName] time:model_dongtai.createTime];
    model_dongtai.height_cell = 55;
    /**这一部分以后都是分开写的*/
    if ([model_dongtai.type integerValue]==0) {
        //日志
        self.YL_contents.hidden = NO;
        self.L_title.text = model_dongtai.message;
        model_dongtai.height_cell = model_dongtai.height_cell +35;
        NSMutableAttributedString *ganwu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"当天感悟：%@",model_dongtai.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        if(model_dongtai.location.length >0)
        {
            NSMutableAttributedString *location = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_dongtai.location] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [ganwu appendAttributedString:location];
        }
        ganwu.yy_lineSpacing = 6;
        CGSize size = [ganwu boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model_dongtai.height_cell = size.height+20+model_dongtai.height_cell;
        self.YL_contents.attributedText = ganwu;
        [self.YL_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+15);
            make.left.mas_equalTo(self.V_content.mas_left).mas_offset(60);
            make.right.mas_equalTo(self.V_content.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.L_title.mas_bottom).mas_offset(5);
        }];
        [self.V_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+20+30);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.V_top.mas_bottom).mas_offset(5);
        }];
        
        [self setPinglunWithModel:model_dongtai AndTemp:0];
      
    }else if ([model_dongtai.type integerValue]==1)
    {
        [self setContentsWithDongtaiModel:model_dongtai];
        [self setPinglunWithModel:model_dongtai AndTemp:1];
      
    }else
    {
        
    }
    
    ///点赞评论的部分
    NSMutableArray *tarr_zan = [NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<model_dongtai.UserZan.count; i++) {
        ZanModel  *model = model_dongtai.UserZan[i];
        [tarr_zan addObject:model.headImage];
    }
    [self.V_bottom setZan_arr:tarr_zan isZan:model_dongtai.isZan zanNum:model_dongtai.zanCount liuYanNum:model_dongtai.commentCount];
    model_dongtai.height_cell = model_dongtai.height_cell + 45;
    
    ///最下面的评论点赞部分
    
    
}
/// 任务
-(void)setContentsWithDongtaiModel:(Com_dongTanModel *)model_dongtai{
    if ([model_dongtai.type integerValue]==1) {
        //任务 1 发任务  2接收任务 3 完成任务
        NSArray *tarr = @[@"发日志",@"发布了任务",@"接收了任务",@"完成了任务"];
        self.L_title.text = [NSString stringWithFormat:@"%@[%@]",tarr[[model_dongtai.options integerValue]],model_dongtai.title];
        model_dongtai.height_cell = model_dongtai.height_cell +35;
        //content + 图片
        NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:model_dongtai.content attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
        if (model_dongtai.location.length >0) {
            NSMutableAttributedString  *location = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model_dongtai.location] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
            [content appendAttributedString:location];
        }
        content.yy_lineSpacing =6;
        CGSize size = [content boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-75, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        model_dongtai.height_cell = model_dongtai.height_cell +size.height+10;
        self.YL_contents.hidden = NO;
       
      
      __block  CGFloat img_height = 0;
        if (model_dongtai.imageUrls.count ==1) {
            self.IV_img1.hidden = NO;
            [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model_dongtai.imageUrls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if(image!=nil)
                {
                    float width,height;
                    if (image.size.width > image.size.height) {
                        width= (DEVICE_WIDTH -75)*3/4;
                        height = width *image.size.height/image.size.width;
                    }else
                    {
                      height =(DEVICE_WIDTH -75)*3/4;
                        width = height*image.size.width/image.size.height;
                    }
                    [self.IV_img1 mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.size.mas_equalTo(CGSizeMake(width, height));
                        make.left.mas_equalTo(self.V_content.mas_left).mas_offset(56);
                        make.top.mas_equalTo(self.YL_contents.mas_bottom).mas_offset(5);
                    }];
                    
                    img_height =height;
                   
                }
            }];
           
    }else if (model_dongtai.imageUrls.count==2)
    {
        float width = (DEVICE_WIDTH -75-20)/3.0;
        self.IV_img1.hidden = NO;
        self.IV_img2.hidden = NO;
        [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model_dongtai.imageUrls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
        [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model_dongtai.imageUrls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
        [self.IV_img1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(self.V_content.mas_left).mas_offset(60);
            make.top.mas_equalTo(self.YL_contents.mas_bottom).mas_offset(5);
        }];
        [self.IV_img2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(self.IV_img1.mas_right).mas_offset(5);
             make.top.mas_equalTo(self.YL_contents.mas_bottom).mas_offset(5);
        }];
        img_height = width+5;
        
    }else if (model_dongtai.imageUrls.count>2)
    {
        self.IV_img1.hidden = NO;
        self.IV_img2.hidden =NO;
        self.IV_img3.hidden = NO;
         float width = (DEVICE_WIDTH -75-20)/3.0;
        [self.IV_img1 sd_setImageWithURL:[NSURL URLWithString:model_dongtai.imageUrls[0]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
        [self.IV_img2 sd_setImageWithURL:[NSURL URLWithString:model_dongtai.imageUrls[1]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
        [self.IV_img3 sd_setImageWithURL:[NSURL URLWithString:model_dongtai.imageUrls[2]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
        [self.IV_img1 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(self.V_content.mas_left).mas_offset(60);
            make.top.mas_equalTo(self.YL_contents.mas_bottom).mas_offset(5);
        }];
        [self.IV_img2 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(self.IV_img1.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.YL_contents.mas_bottom).mas_offset(5);
        }];
        [self.IV_img3 mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.left.mas_equalTo(self.IV_img2.mas_right).mas_offset(5);
            make.top.mas_equalTo(self.YL_contents.mas_bottom).mas_offset(5);
        }];
        img_height = width+5;
    }
    else
    {
        
    }
        
        model_dongtai.height_cell = model_dongtai.height_cell+img_height;
          self.YL_contents.attributedText = content;
        [self.YL_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height);
            make.top.mas_equalTo(self.L_title.mas_bottom).mas_offset(5);
            make.left.mas_equalTo(self.V_content.mas_left).mas_offset(60);
            make.right.mas_equalTo(self.V_content.mas_right).mas_offset(-15);
        }];
        
        [self.V_content mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30+5+size.height+5+img_height+5);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.V_top.mas_bottom).mas_offset(5);
        }];
      
   
     
}
}

-(UIView*)V_content
{
    if (!_V_content) {
        _V_content  =[[UIView alloc]init];
        [self addSubview:_V_content];
        _V_content.userInteractionEnabled = YES;
    }
    return _V_content;
}
-(UIView*)V_pinglun
{
    if (!_V_pinglun) {
        _V_pinglun = [[UIView alloc]init];
        [self addSubview:_V_pinglun];
        _V_pinglun.userInteractionEnabled = YES;
        _V_pinglun.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.3];
        _V_pinglun.layer.masksToBounds = YES;
        _V_pinglun.layer.cornerRadius =6;
    }
    return _V_pinglun;
}

-(void)setPinglunWithModel:(Com_dongTanModel *)model AndTemp:(NSInteger)temp{
    
    NSDictionary *tdic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@""];
    NSArray *tarr = nil;
    if (temp ==0) {
        tarr = model.Comment;
    }else if (temp ==1)
    {
        tarr = model.taskComment;
    }else
    {
        
    }
    for (int i=0; i<tarr.count; i++) {
        GZQ_PingLunModel *model2 =tarr[i];
        model2.indexpath_cell = model.indexPath_cell;
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:model2.createStaffName attributes:tdic];
        
        [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)]) {
                [self.delegate_dongtai getDongTaiModel:model2 AndisHuifu:0];
            }
        }];
        
        NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@\n",model2.content] attributes:tdic];
        [contents yy_setTextHighlightRange:contents.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)]) {
                [self.delegate_dongtai getDongTaiModel:model2 AndisHuifu:2];
            }
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)]) {
                [self.delegate_dongtai getDongTaiModel:model2 AndisHuifu:3];
            }
        }];
        
        [name appendAttributedString:contents];
        [title appendAttributedString:name];
        
        for (int j=0; j<model2.childList.count; j++) {
            GZQ_PingLunModel *model3 = model2.childList[j];
            model3.indexpath_cell = model2.indexpath_cell;
            NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:model3.createStaffName attributes:tdic];
            [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)])
                {
                    [self.delegate_dongtai getDongTaiModel:model3 AndisHuifu:0];
                }
            }];
            NSMutableAttributedString *huifu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" 回复 "] attributes:tdic];
            [name appendAttributedString:huifu];
            NSMutableAttributedString  *parentsName = [[NSMutableAttributedString alloc]initWithString:model3.parentStaffName attributes:tdic];
            [parentsName yy_setTextHighlightRange:parentsName.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)])
                {
                    [self.delegate_dongtai getDongTaiModel:model3 AndisHuifu:1];
                }
            }];
            [name appendAttributedString:parentsName];
            
            NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@\n",model3.content] attributes:tdic];
            
            [contents yy_setTextHighlightRange:contents.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if ([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)]) {
                    [self.delegate_dongtai getDongTaiModel:model3 AndisHuifu:2];
                }
            } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if ([self.delegate_dongtai respondsToSelector:@selector(getDongTaiModel:AndisHuifu:)]) {
                    [self.delegate_dongtai getDongTaiModel:model3 AndisHuifu:3];
                }
            }];
            
            
            [name appendAttributedString:contents];
            [title appendAttributedString:name];
        }
        
        
    }
    if ([model.commentCount integerValue] >3) {
        NSMutableAttributedString *more = [[NSMutableAttributedString alloc]initWithString:@"查看更多 \n" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        more.yy_alignment  =NSTextAlignmentRight;
        [more yy_setTextHighlightRange:more.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_dongtai respondsToSelector:@selector(getMoreWithDongTaiModel:)]) {
                [self.delegate_dongtai getMoreWithDongTaiModel:model];
            }
        }];
        [title appendAttributedString:more];
    }
    title.yy_lineSpacing =6;
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30-40-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_pinglun.attributedText = title;
    
    
    if (tarr.count ==0) {
        [self.V_pinglun mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
        [self.YL_pinglun mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }else
    {
        [self.V_pinglun mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.left.mas_equalTo(self.mas_left).mas_offset(55);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.V_bottom.mas_bottom).mas_offset(5);
        }];
        [self.YL_pinglun mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(size.height+5);
            make.centerY.mas_equalTo(self.V_pinglun.mas_centerY);
            make.left.mas_equalTo(self.V_pinglun.mas_left).mas_offset(5);
            make.right.mas_equalTo(self.V_pinglun.mas_right).mas_offset(-5);
        }];
        model.height_cell = model.height_cell+size.height +5+10;
    }
    
    
    
}

-(FB_topView*)V_top
{
    if (!_V_top) {
        _V_top = [[FB_topView alloc]init];
        [self addSubview:_V_top];
        _V_top.userInteractionEnabled = YES;
        [_V_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.mas_top);
        }];
    }
    return _V_top;
}
-(FB_bottomView*)V_bottom
{
    if (!_V_bottom) {
        _V_bottom = [[FB_bottomView alloc]init];
        [self addSubview:_V_bottom];
        _V_bottom.userInteractionEnabled  =YES;
        [_V_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.mas_left);
            make.right.mas_equalTo(self.mas_right);
            make.top.mas_equalTo(self.V_content.mas_bottom).mas_offset(5);
        }];
    }
    return _V_bottom;
}
-(void)setHiddenSomeView{
    self.IV_img3.hidden = YES;
    self.IV_img2.hidden =YES;
    self.IV_img1.hidden = YES;
    self.YL_contents.hidden = YES;
}
-(UIImageView*)IV_img1
{
    if (!_IV_img1) {
        _IV_img1 = [[UIImageView alloc]init];
        [self.V_content addSubview:_IV_img1];
        _IV_img1.userInteractionEnabled = YES;
        _IV_img1.layer.masksToBounds = YES;
        _IV_img1.layer.cornerRadius =6;
    }
    return _IV_img1;
}
-(UIImageView*)IV_img2
{
    if (!_IV_img2) {
        _IV_img2 = [[UIImageView alloc]init];
        [self.V_content addSubview:_IV_img2];
        _IV_img2.userInteractionEnabled =YES;
        _IV_img2.layer.masksToBounds = YES;
        _IV_img2.layer.cornerRadius =6;
    }
    return _IV_img2;
}
-(UIImageView*)IV_img3
{
    if (!_IV_img3) {
        _IV_img3 = [[UIImageView alloc]init];
        [self.V_content addSubview:_IV_img3];
        _IV_img3.userInteractionEnabled =YES;
        _IV_img3.layer.masksToBounds = YES;
        _IV_img3.layer.cornerRadius =6;
        
    }
    return _IV_img3;
}
-(UILabel*)L_title
{
    if (!_L_title) {
        _L_title = [[UILabel alloc]init];
        [self.V_content addSubview:_L_title];
        _L_title.font = [UIFont systemFontOfSize:17];
        _L_title.userInteractionEnabled = YES;
        [_L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.V_content.mas_left).mas_offset(60);
            make.right.mas_equalTo(self.V_content.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.V_content.mas_top);
        }];
        
        
    }
    return _L_title;
}

-(YYLabel*)YL_contents
{
    if (!_YL_contents) {
        _YL_contents = [[YYLabel alloc]init];
        [self.V_content addSubview:_YL_contents];
        _YL_contents.numberOfLines =0;
        _YL_contents.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
        _YL_contents.font = [UIFont systemFontOfSize:15];
        _YL_contents.layer.masksToBounds = YES;
        _YL_contents.layer.cornerRadius =5;
        _YL_contents.userInteractionEnabled = YES;
        
    }
    return _YL_contents;
}

-(YYLabel*)YL_pinglun
{
    if (!_YL_pinglun) {
        _YL_pinglun = [[YYLabel alloc]init];
        [self.V_pinglun addSubview:_YL_pinglun];
        _YL_pinglun.numberOfLines = 0;
    }
    return _YL_pinglun;
}

@end
