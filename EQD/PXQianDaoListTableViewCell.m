//
//  PXQianDaoListTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/1.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PXQianDaoListTableViewCell.h"
#import <Masonry.h>
@implementation PXQianDaoListTableViewCell
-(void)setModel:(PXKaoQinListModel *)model
{
    self.L_left0.text = model.userName;
    self.L_left1.text = [NSString stringWithFormat:@"%@-%@",model.depName,model.postName];
    if ([model.status integerValue]==-2) {
        self.L_center.hidden=NO;
        self.L_center.text =@"查看原因";
    }else
    {
        self.L_center.hidden=YES;
    }
    if ([model.status integerValue]==-2) {
        self.L_right0.text = @"未到";
        self.L_right0.textColor = [UIColor redColor];
        self.L_right1.text = nil;
    }else if ([model.status integerValue]==-1)
    {
        self.L_right0.text = @"迟到";
        self.L_right0.textColor = [UIColor orangeColor];
        self.L_right1.text = model.signInTime;
    }else if([model.status integerValue]==1)
    {
        self.L_right0.text =@"正常";
        self.L_right0.textColor = [UIColor blackColor];
        self.L_right1.text = model.signInTime;
    }else
    {
        self.L_right1.text = nil;
    }
    
}
-(UILabel*)L_left0{
    if (!_L_left0) {
        _L_left0 =[[UILabel alloc]init];
        [self addSubview:_L_left0];
        _L_left0.userInteractionEnabled =YES;
        _L_left0.font = [UIFont systemFontOfSize:17];
        [_L_left0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 24));
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-2);
        }];
        
    }
    return _L_left0;
}
-(UILabel*)L_left1
{
    if (!_L_left1) {
        _L_left1 = [[UILabel alloc]init];
        [self addSubview:_L_left1];
        _L_left1.userInteractionEnabled =YES;
        _L_left1.font = [UIFont systemFontOfSize:13];
        _L_left1.textColor = [UIColor grayColor];
        [_L_left1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.L_right1.mas_left).mas_offset(-5);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(3);
        }];
        
    }
    return _L_left1;
}
-(UILabel*)L_right0
{
    if (!_L_right0) {
        _L_right0 = [[UILabel alloc]init];
        [self addSubview:_L_right0];
        _L_right0.userInteractionEnabled =YES;
        _L_right0.font = [UIFont systemFontOfSize:17];
        _L_right0.textAlignment = NSTextAlignmentCenter;
        [_L_right0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 25));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-3);
        }];
    }
    return _L_right0;
}
-(UILabel*)L_right1
{
    if (!_L_right1) {
        _L_right1 = [[UILabel alloc]init];
        [self addSubview:_L_right1];
        _L_right1.font = [UIFont systemFontOfSize:13];
        _L_right1.textAlignment = NSTextAlignmentCenter;
        _L_right1.textColor = [UIColor grayColor];
        _L_right1.userInteractionEnabled =YES;
        [_L_right1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(120, 20));
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_centerY).mas_offset(2);
        }];
        
    }
    return _L_right1;
}
-(UILabel*)L_center
{
    if (!_L_center) {
        _L_center = [[UILabel alloc]init];
        [self addSubview:_L_center];
        _L_center.userInteractionEnabled =YES;
        _L_center.textAlignment = NSTextAlignmentCenter;
//        _L_center.textColor = [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1];
        _L_center.textColor =[UIColor whiteColor];
        _L_center.text =@"查看原因";
        _L_center.hidden = YES;
        _L_center.layer.masksToBounds = YES;
        _L_center.layer.cornerRadius=3;
        _L_center.backgroundColor = [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1];
        _L_center.font = [UIFont systemFontOfSize:15];
        [_L_center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(85, 24));
            make.bottom.mas_equalTo(self.mas_centerY).mas_offset(-2);
            make.centerX.mas_equalTo(self.mas_centerX);
        }];
        
    }
    return _L_center;
}

@end
