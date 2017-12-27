//
//  EQDR_IVLView.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_IVLView.h"
#import <Masonry.h>
@implementation EQDR_IVLView

-(void)setImg:(NSString*)img  name:(NSString*)name
{
    self.IV_img.image = [UIImage imageNamed:img];
    self.L_show.text = name;
}
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.userInteractionEnabled =YES;
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerX.mas_equalTo(self.mas_centerX);
            make.top.mas_equalTo(self.mas_top);
        }];
        
        
    }
    return _IV_img;
}
-(UILabel*)L_show
{
    if (!_L_show) {
        _L_show = [[UILabel alloc]init];
        [self addSubview:_L_show];
        _L_show.textColor = [UIColor whiteColor];
        _L_show.textAlignment =NSTextAlignmentCenter;
        _L_show.font = [UIFont systemFontOfSize:12];
        [_L_show mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(15);
            make.width.mas_equalTo(self.mas_width);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-3);
            make.left.mas_equalTo(self.mas_left);
        }];
    }
    return _L_show;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
