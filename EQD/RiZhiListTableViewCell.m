//
//  RiZhiListTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/4/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]

#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "RiZhiListTableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation RiZhiListTableViewCell

-(void)setModel_rizhiList:(RIZhiListModel *)model_rizhiList
{
    _model_rizhiList = model_rizhiList;
    ///头部
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model_rizhiList.iphoto] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    self.L_name.text = model_rizhiList.staffName;
    self.L_bumen.text = [NSString stringWithFormat:@"%@-%@",model_rizhiList.departName,model_rizhiList.postName];
    self.L_time.text = model_rizhiList.createTime;
    model_rizhiList.cellHeight = 50+5;
    
    ///中间的内容
    [self setContentsWithModel:model_rizhiList];
    ///底1层
    [self setZanPersonWithmodel:model_rizhiList];
    if ([model_rizhiList.isZan integerValue]==0) {
        self.IV_zan.image = [UIImage imageNamed:@"zan_false"];
    }else
    {
       self.IV_zan.image = [UIImage imageNamed:@"zan_true"];
    }
    self.L_zan.text = model_rizhiList.zanCount;
    self.L_liuyan.text = model_rizhiList.commentCount;
  
    
    ///评论区域
    [self setPinglunWithModel:model_rizhiList];
}
-(void)setPinglunWithModel:(RIZhiListModel *)model{
    
    NSDictionary *tdic = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:@""];
    for (int i=0; i<model.comment.count; i++) {
        GZQ_PingLunModel *model2 =model.comment[i];
        model2.indexpath_cell = model.indexPath_model;
        NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:model2.createStaffName attributes:tdic];
       
        [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)]) {
                [self.delegate_rizhi getPinglunModel:model2 AndisHuifu:0];
            }
        }];
        
        NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@\n",model2.content] attributes:tdic];
        [contents yy_setTextHighlightRange:contents.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)]) {
                [self.delegate_rizhi getPinglunModel:model2 AndisHuifu:2];
            }
        } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if ([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)]) {
                [self.delegate_rizhi getPinglunModel:model2 AndisHuifu:3];
            }
        }];
      
        [name appendAttributedString:contents];
        [title appendAttributedString:name];
        
        for (int j=0; j<model2.childList.count; j++) {
            GZQ_PingLunModel *model3 = model2.childList[j];
            model3.indexpath_cell = model2.indexpath_cell;
            NSMutableAttributedString *name = [[NSMutableAttributedString alloc]initWithString:model3.createStaffName attributes:tdic];
            [name yy_setTextHighlightRange:name.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)])
                {
                    [self.delegate_rizhi getPinglunModel:model3 AndisHuifu:0];
                }
            }];
            NSMutableAttributedString *huifu = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" 回复 "] attributes:tdic];
            [name appendAttributedString:huifu];
            NSMutableAttributedString  *parentsName = [[NSMutableAttributedString alloc]initWithString:model3.parentStaffName attributes:tdic];
            [parentsName yy_setTextHighlightRange:parentsName.yy_rangeOfAll color:EQDCOLOR backgroundColor:[UIColor whiteColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)])
                {
                    [self.delegate_rizhi getPinglunModel:model3 AndisHuifu:1];
                }
            }];
            [name appendAttributedString:parentsName];
            
            NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@":%@\n",model3.content] attributes:tdic];
            
            [contents yy_setTextHighlightRange:contents.yy_rangeOfAll color:[UIColor blackColor] backgroundColor:[UIColor whiteColor] userInfo:nil tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if ([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)]) {
                    [self.delegate_rizhi getPinglunModel:model3 AndisHuifu:2];
                }
            } longPressAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                if ([self.delegate_rizhi respondsToSelector:@selector(getPinglunModel:AndisHuifu:)]) {
                    [self.delegate_rizhi getPinglunModel:model3 AndisHuifu:3];
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
            if ([self.delegate_rizhi respondsToSelector:@selector(getMoreWithrizhiModel:)]) {
                [self.delegate_rizhi getMoreWithrizhiModel:model];
            }
        }];
        [title appendAttributedString:more];
    }
    title.yy_lineSpacing =6;
    
    CGSize size = [title boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30-40-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.YL_pinglun.attributedText = title;
   
    
    if (model.comment.count ==0) {
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
    model.cellHeight = model.cellHeight+size.height +5+10;
    }
    
    
    
}

-(void)setContentsWithModel:(RIZhiListModel*)model{
    
    NSMutableAttributedString  *contents = [[NSMutableAttributedString alloc]initWithString:@""];
    if (self.S_fourItems.selectedSegmentIndex ==0) {
        //感悟
        NSMutableAttributedString *tAttrString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model.Feeling] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        [contents appendAttributedString:tAttrString];
        
    }else if(self.S_fourItems.selectedSegmentIndex == 1)
    {
        //今日计划
        for (int i=0; i<model.plan.count; i++) {
            RiZhiModel *model2 = model.plan[i];
            NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d：%@\n",i+1,model2.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            NSMutableAttributedString *status = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model2.result] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            status.yy_alignment = NSTextAlignmentLeft;
            [status yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:status.yy_rangeOfAll];
            [time appendAttributedString:status];
            
            NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model2.TimeSlot] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            content.yy_alignment = NSTextAlignmentRight;
            [time appendAttributedString:content];
            [contents appendAttributedString:time];
        }
        
        
    }else if (self.S_fourItems.selectedSegmentIndex == 2)
    {
        //临时事项
        
        for (int i=0; i<model.matter.count; i++) {
            RiZhiModel *model2 = model.matter[i];
            NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d：%@\n",i+1,model2.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            NSMutableAttributedString *status = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",model2.result] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            status.yy_alignment = NSTextAlignmentLeft;
            [status yy_setTextBackgroundBorder:[YYTextBorder borderWithLineStyle:YYTextLineStyleSingle lineWidth:1 strokeColor:[UIColor orangeColor]] range:status.yy_rangeOfAll];
            [time appendAttributedString:status];
            
            NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"      %@\n",model2.TimeSlot] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            content.yy_alignment = NSTextAlignmentRight;
            [time appendAttributedString:content];
            [contents appendAttributedString:time];
        }
        
        
    }else if (self.S_fourItems.selectedSegmentIndex == 3)
    {
        //明日事项
        for (int i=0; i<model.tomorrowMatter.count; i++) {
            RiZhiModel *model2 = model.tomorrowMatter[i];
          
            NSMutableAttributedString  *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d：%@\n",i+1,model2.content] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            
              NSMutableAttributedString *time = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"      %@\n",model2.TimeSlot] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
            time.yy_alignment = NSTextAlignmentRight;
            [content appendAttributedString:time];
            [contents appendAttributedString:content];
        }
    }else
    {
        
    }
    if (model.location.length >0) {
    NSMutableAttributedString *location = [[NSMutableAttributedString alloc]initWithString:model.location attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [contents appendAttributedString:location];
    }
    contents.yy_lineSpacing = 6;
    CGSize size = [contents boundingRectWithSize:CGSizeMake(DEVICE_WIDTH-30, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    
    [self.V_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10+40);
        make.left.mas_equalTo(self.mas_left).mas_offset(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.top.mas_equalTo(self.V_top.mas_bottom).mas_offset(5);
    }];
    [self.YL_lcontents mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+10);
        make.left.mas_equalTo(self.V_contents.mas_left);
        make.right.mas_equalTo(self.V_contents.mas_right);
        make.top.mas_equalTo(self.S_fourItems.mas_bottom).mas_offset(5);
    }];
    self.YL_lcontents.attributedText = contents;
    model.cellHeight = model.cellHeight+size.height+10+40;
}
-(void)hiddenAnotherView{
    self.IV_zan2.hidden =YES;
    self.IV_zan3.hidden = YES;
    self.IV_zan4.hidden = YES;
    self.IV_zan4.transform = CGAffineTransformIdentity;
    self.IV_zan3.transform = CGAffineTransformIdentity;
    self.IV_zan2.transform = CGAffineTransformIdentity;
    self.IV_zan1.transform = CGAffineTransformIdentity;
}

-(void)updateZanWithmodel:(RIZhiListModel*)model AndImg:(NSString*)userImg
{
    ZanModel  *model2 = [[ZanModel alloc]init];
    model2.headImage =userImg;
    NSMutableArray *tarr_zan = [NSMutableArray arrayWithArray:model.UserZan];
    [tarr_zan insertObject:model2 atIndex:0];
    model.UserZan = tarr_zan;
    
    [self setZanPersonWithmodel:model];
    self.IV_zan.image = [UIImage imageNamed:@"zan_true"];
    self.L_zan.text = [NSString stringWithFormat:@"%ld",[self.L_zan.text integerValue] +1];
}
-(void)setZanPersonWithmodel:(RIZhiListModel*)model
{
    [self hiddenAnotherView];
    model.cellHeight = model.cellHeight+40+5;
    if (model.UserZan.count == 0) {
        self.IV_zan1.image = [UIImage imageNamed:@"ic_arrow"];
    }else if (model.UserZan.count == 1)
    {
        self.IV_zan2.hidden =NO;
        ZanModel *model1 =model.UserZan[0];
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:model1.headImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan2.image = [UIImage imageNamed:@"ic_arrow"];
    }else if (model.UserZan.count==2)
    {
        self.IV_zan3.hidden =NO;
        self.IV_zan2.hidden =NO;
        ZanModel *model1 =model.UserZan[0];
        ZanModel *model2 = model.UserZan[1];
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:model1.headImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:model2.headImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan3.image = [UIImage imageNamed:@"ic_arrow"];
    }else if (model.UserZan.count==3)
    {
        self.IV_zan4.hidden = NO;
        self.IV_zan3.hidden = NO;
        self.IV_zan2.hidden = NO;
        ZanModel *model1 =model.UserZan[0];
        ZanModel *model2 =model.UserZan[1];
        ZanModel *model3 =model.UserZan[2];
        [self.IV_zan1 sd_setImageWithURL:[NSURL URLWithString:model1.headImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan2 sd_setImageWithURL:[NSURL URLWithString:model2.headImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        [self.IV_zan3 sd_setImageWithURL:[NSURL URLWithString:model3.headImage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
        self.IV_zan4.image = [UIImage imageNamed:@"ic_arrow"];
    }else
    {
        
    }
}
-(FBSegmentedControl*)S_fourItems
{
    if (!_S_fourItems) {
        _S_fourItems = [[FBSegmentedControl alloc]initWithItems:@[@"当天感悟",@"当天计划",@"临时事项",@"明日事项"]];
        [self.V_contents  addSubview:_S_fourItems];
        _S_fourItems.selectedSegmentIndex =0;
        [_S_fourItems mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.V_contents.mas_left);
            make.right.mas_equalTo(self.V_contents.mas_right);
            make.top.mas_equalTo(self.V_contents.mas_top);
            make.height.mas_equalTo(40);
        }];
        
    }
    return _S_fourItems;
}
-(YYLabel*)YL_lcontents
{
    if (!_YL_lcontents) {
        _YL_lcontents = [[YYLabel alloc]init];
        _YL_lcontents.numberOfLines=0;
        [self.V_contents addSubview:_YL_lcontents];
        
    }
    return _YL_lcontents;
}
-(UILabel*)L_zan
{
    if (!_L_zan) {
        _L_zan = [[UILabel alloc]init];
        _L_zan.font = [UIFont systemFontOfSize:12];
        _L_zan.textColor = [UIColor grayColor];
        [self.V_bottom addSubview:_L_zan];
        [_L_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 20));
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.right.mas_equalTo(self.IV_liuyan.mas_left).mas_offset(-10);
        }];
    }
    return _L_zan;
}
-(UIImageView*)IV_zan
{
    if (!_IV_zan) {
        _IV_zan = [[UIImageView alloc]init];
        [self.V_bottom addSubview:_IV_zan];
        _IV_zan.userInteractionEnabled =YES;
        _IV_zan.image = [UIImage imageNamed:@"zan_false"];
        [_IV_zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.right.mas_equalTo(self.L_zan.mas_left).mas_offset(-5);
        }];
    }
    return _IV_zan;
}
-(UIImageView*)IV_liuyan
{
    if (!_IV_liuyan) {
        _IV_liuyan = [[UIImageView alloc]init];
        _IV_liuyan.userInteractionEnabled =YES;
        _IV_liuyan.image = [UIImage imageNamed:@"pinglun"];
        [self.V_bottom addSubview:_IV_liuyan];
        [_IV_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.right.mas_equalTo(self.L_liuyan.mas_left).mas_offset(-5);
        }];
    }
    return _IV_liuyan;
}
-(UILabel*)L_liuyan
{
    if (!_L_liuyan) {
        _L_liuyan = [[UILabel alloc]init];
        _L_liuyan.font = [UIFont systemFontOfSize:12];
        _L_liuyan.textColor = [UIColor grayColor];
        [self.V_bottom addSubview:_L_liuyan];
        [_L_liuyan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 20));
            make.right.mas_equalTo(self.V_bottom.mas_right).mas_offset(-5);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
        }];
        
    }
    return _L_liuyan;
}

-(UIImageView*)IV_zan1
{
    if (!_IV_zan1) {
        _IV_zan1  =[[UIImageView alloc]init];
        _IV_zan1.userInteractionEnabled = YES;
        _IV_zan1.layer.masksToBounds = YES;
        _IV_zan1.layer.cornerRadius = 15;
        [self.V_bottom addSubview:_IV_zan1];
        [_IV_zan1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.V_bottom.mas_left).mas_offset(5);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
        }];
        
    }
    return _IV_zan1;
}

-(UIImageView*)IV_zan2
{
    if (!_IV_zan2) {
        _IV_zan2 = [[UIImageView alloc]init];
        [self.V_bottom addSubview:_IV_zan2];
        _IV_zan2.userInteractionEnabled =YES;
        _IV_zan2.layer.masksToBounds =YES;
        _IV_zan2.layer.cornerRadius =15;
        [_IV_zan2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.left.mas_equalTo(self.IV_zan1.mas_right).mas_offset(5);
        }];
    }
    return _IV_zan2;
}
-(UIImageView*)IV_zan3
{
    if (!_IV_zan3) {
        _IV_zan3 = [[UIImageView alloc]init];
        [self.V_bottom addSubview:_IV_zan3];
        _IV_zan3.userInteractionEnabled = YES;
        _IV_zan3.layer.masksToBounds = YES;
        _IV_zan3.layer.cornerRadius =15;
        [_IV_zan3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.left.mas_equalTo(self.IV_zan2.mas_right).mas_offset(5);
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
        }];
        
    }
    return _IV_zan3;
}
-(UIImageView*)IV_zan4
{
    if (!_IV_zan4) {
        _IV_zan4 = [[UIImageView alloc]init];
        [self.V_bottom addSubview:_IV_zan4];
        _IV_zan4.userInteractionEnabled =YES;
        _IV_zan4.layer.masksToBounds =YES;
        _IV_zan4.layer.cornerRadius =15;
        [_IV_zan4 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.mas_equalTo(self.V_bottom.mas_centerY);
            make.left.mas_equalTo(self.IV_zan3.mas_right).mas_offset(5);
        }];
    }
    return _IV_zan4;
}
-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head  =[[UIImageView alloc]init];
        _IV_head.userInteractionEnabled = YES;
        [self.V_top addSubview:_IV_head];
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(40, 40));
            make.left.mas_equalTo(self.V_top.mas_left).mas_offset(5);
            make.centerY.mas_equalTo(self.V_top.mas_centerY);
        }];
    }
    return _IV_head;
}
-(UIImageView*)IV_fenxiang
{
    if (!_IV_fenxiang) {
        _IV_fenxiang = [[UIImageView alloc]init];
        _IV_fenxiang.userInteractionEnabled =YES;
        _IV_fenxiang.image = [UIImage imageNamed:@"ic_arrow"];
        _IV_fenxiang.transform = CGAffineTransformMakeRotation(M_PI_2);
        [self.V_top addSubview:_IV_fenxiang];
        [_IV_fenxiang mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.right.mas_equalTo(self.V_top.mas_right).mas_offset(-5);
            make.top.mas_equalTo(self.V_top.mas_top);
        }];
    }
    return _IV_fenxiang;
}


-(UIView*)V_top
{
    if (!_V_top) {
        _V_top = [[UIView alloc]init];
        _V_top.userInteractionEnabled = YES;
        [self addSubview:_V_top];
        [_V_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top);
        }];
        
    }
    return _V_top;
}
-(YYLabel*)YL_pinglun
{
    if (!_YL_pinglun) {
        _YL_pinglun = [[YYLabel alloc]init];
        _YL_pinglun.numberOfLines =0;
        [self.V_pinglun addSubview:_YL_pinglun];
    }
    return _YL_pinglun;
}
-(UIView*)V_bottom
{
    if (!_V_bottom) {
        _V_bottom = [[UIView alloc]init];
        _V_bottom.userInteractionEnabled = YES;
        [self addSubview:_V_bottom];
        [_V_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.V_contents.mas_bottom).mas_offset(5);
        }];
    }
    return _V_bottom;
}
-(UIView*)V_pinglun
{
    if (!_V_pinglun) {
        _V_pinglun = [[UIView alloc]init];
        _V_pinglun.userInteractionEnabled = YES;
        _V_pinglun.backgroundColor = [UIColor lightTextColor];
        [self addSubview:_V_pinglun];
        
    }
    return _V_pinglun;
}
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.font = [UIFont systemFontOfSize:17];
        [self.V_top addSubview:_L_name];
        _L_name.userInteractionEnabled = YES;
        [_L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.IV_fenxiang.mas_left).mas_offset(-5);
            make.top.mas_equalTo(self.V_top.mas_top);
        }];
    }
    return _L_name;
}

-(UILabel*)L_bumen
{
    if (!_L_bumen) {
        _L_bumen = [[UILabel alloc]init];
        [self.V_top addSubview:_L_bumen];
        _L_bumen.font = [UIFont systemFontOfSize:13];
        _L_bumen.textColor = [UIColor grayColor];
        [_L_bumen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.bottom.mas_equalTo(self.V_top.mas_bottom);
            make.right.mas_equalTo(self.L_time.mas_left).mas_offset(-5);
        }];
        
    }
    return _L_bumen;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        _L_time.font = [UIFont systemFontOfSize:12];
        _L_time.textColor = [UIColor grayColor];
        [self.V_top addSubview:_L_time];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.mas_equalTo(self.L_bumen.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.V_top.mas_right).mas_offset(-5);
            make.bottom.mas_equalTo(self.V_top.mas_bottom);
        }];
        
    }
    return _L_time;
}
-(UIView*)V_contents
{
    if (!_V_contents) {
        _V_contents = [[UIView alloc]init];
        _V_contents.userInteractionEnabled = YES;
        [self addSubview:_V_contents];
    }
    return _V_contents;
}

@end
