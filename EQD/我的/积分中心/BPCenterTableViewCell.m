//
//  BPCenterTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/12.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "BPCenterTableViewCell.h"
#import <Masonry.h>
@implementation BPCenterTableViewCell
-(void)setModel_renwu:(BP_renwuModel * _Nonnull)model_renwu
{
    _model_renwu = model_renwu;
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius =6;
    self.L_title.text = model_renwu.remark;
    if ([model_renwu.times integerValue]==-1) {
        self.L_jifen.text =[NSString stringWithFormat:@"+%@积分",model_renwu.BP];
        if([model_renwu.finish integerValue]==0)
        {
            [self.btn_right  setTitle:@"未完成" forState:UIControlStateNormal];
            [self.btn_right setTintColor:[UIColor whiteColor]];
            self.btn_right.layer.backgroundColor = [UIColor colorWithRed:49/255.0 green:72/255.0 blue:196/255.0 alpha:1].CGColor;
        }else
        {
            [self.btn_right setTintColor:[UIColor blackColor]];
            self.btn_right.layer.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1].CGColor;
            [self.btn_right  setTitle:@"已完成" forState:UIControlStateNormal];
        }
    }else
    {
        self.L_jifen.text = [NSString stringWithFormat:@"+%@积分(%@/%@)",model_renwu.BP,model_renwu.finishTiems,model_renwu.times];
        if ([model_renwu.finishTiems integerValue] < [model_renwu.times integerValue]) {
            [self.btn_right  setTitle:@"未完成" forState:UIControlStateNormal];
            [self.btn_right setTintColor:[UIColor whiteColor]];
            self.btn_right.layer.backgroundColor = [UIColor colorWithRed:49/255.0 green:72/255.0 blue:196/255.0 alpha:1].CGColor;
        }else
        {
            [self.btn_right setTintColor:[UIColor blackColor]];
            self.btn_right.layer.backgroundColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1].CGColor;
            [self.btn_right  setTitle:@"已完成" forState:UIControlStateNormal];
        }
    }
    
   
}
-(UILabel*)L_title
{
    if (!_L_title) {
        _L_title = [[UILabel alloc]init];
        _L_title.font = [UIFont systemFontOfSize:19];
        [self addSubview:_L_title];
        [_L_title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.right.mas_equalTo(self.btn_right.mas_left);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-5);
            
        }];
        
        
        
    }
    return _L_title;
}

-(FBButton*)btn_right
{
    if (!_btn_right) {
        _btn_right = [FBButton buttonWithType:UIButtonTypeSystem];
        [self addSubview:_btn_right];
        _btn_right.layer.masksToBounds= YES;
        _btn_right.layer.cornerRadius =20;
        
        _btn_right.layer.backgroundColor =  [UIColor colorWithRed:49/255.0 green:72/255.0 blue:196/255.0 alpha:1].CGColor;
        [_btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(90, 40));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _btn_right;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.image = [UIImage imageNamed:@"C_jifenTrue"];
        
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(2.5);
        }];
    }
    return _IV_img;
}
-(UILabel*)L_jifen
{
    if (!_L_jifen) {
        _L_jifen = [[UILabel alloc]init];
        _L_jifen.font = [UIFont systemFontOfSize:13];
        _L_jifen.textColor = [UIColor grayColor];
          [self addSubview:_L_jifen];
        [_L_jifen mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.IV_img.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.btn_right.mas_left).mas_offset(-5);
        }];
        
      
        
    }
    return _L_jifen;
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
