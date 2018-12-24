//
//  BPqiandaoShow.m
//  EQD
//
//  Created by 梁新帅 on 2018/11/14.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "BPqiandaoShow.h"
#import <Masonry.h>
@implementation BPqiandaoShow
-(UILabel*)L_top
{
    if (!_L_top) {
        _L_top = [[UILabel alloc]init];
        [self addSubview:_L_top];
        _L_top.font = [UIFont systemFontOfSize:13];
        _L_top.textAlignment = NSTextAlignmentCenter;
        [_L_top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.height.mas_equalTo(20);
        }];
        
    }
    return _L_top;
}

-(UIImageView*)IV_center
{
    if (!_IV_center) {
        _IV_center  = [[UIImageView alloc]init];
        [self addSubview:_IV_center];
        _IV_center.image = [UIImage imageNamed:@"C_jifenFalse"];
        [_IV_center mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.center.mas_equalTo(self.center);
        }];
    }
    return _IV_center;
}
-(UILabel*)L_bottom
{
    if (!_L_bottom) {
        _L_bottom = [[UILabel alloc]init];
        [self addSubview:_L_bottom];
        _L_bottom.textAlignment = NSTextAlignmentCenter;
        _L_bottom.font = [UIFont systemFontOfSize:13];
        [_L_bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self);
            make.height.mas_equalTo(20);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
        
    }
    return _L_bottom;
}

-(void)setTop:(NSString*)topName  bottomName:(NSString*)bottomName  isQiandao:(BOOL)isQianDao
{
    self.L_top.text = topName;
    self.L_bottom.text = bottomName;
    if (isQianDao == NO) {
        self.L_bottom.textColor = [UIColor blackColor];
        self.IV_center.image = [UIImage imageNamed:@"C_jifenFalse"];
    }else
    {
        self.L_bottom.textColor = [UIColor redColor];
        self.IV_center.image = [UIImage imageNamed:@"C_jifenTrue"];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
