//
//  MaiMai_TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/8/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "MaiMai_TableViewCell.h"
#import <Masonry.h>
#import <UIImageView+WebCache.h>
@implementation MaiMai_TableViewCell

-(UIImageView*)IV_head
{
    if (!_IV_head) {
        _IV_head = [[UIImageView alloc]init];
        [self addSubview:_IV_head];
        _IV_head.layer.masksToBounds = YES;
        _IV_head.layer.cornerRadius = 25;
        _IV_head.userInteractionEnabled = YES;
        [_IV_head mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.left.mas_equalTo(15);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _IV_head;
}
-(FBButton*)B_add
{
    if (!_B_add) {
        _B_add = [FBButton buttonWithType:UIButtonTypeSystem];
      
        _B_add.layer.borderWidth =1;
        _B_add.layer.borderColor = [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1].CGColor;
        
        [_B_add setTitle:@"+好友" titleColor:[UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1] backgroundColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:19]];
        _B_add.layer.masksToBounds = YES;
        _B_add.layer.cornerRadius = 15;
        [self addSubview:_B_add];
        [_B_add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(70, 30));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
        
    }
    return _B_add;
}
-(YYLabel*)L_contents
{
    if (!_L_contents) {
        _L_contents = [[YYLabel alloc]init];
        [self addSubview:_L_contents];
        _L_contents.numberOfLines =0;
        _L_contents.attributedText = nil;
        [_L_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80);
            make.left.mas_equalTo(self.IV_head.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.B_add.mas_left).mas_offset(-5);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
    }
    return _L_contents;
}

-(void)setModel_maimai:(MaiMaiModel *)model_maimai
{
    [self.IV_head sd_setImageWithURL:[NSURL URLWithString:model_maimai.headimage] placeholderImage:[UIImage imageNamed:@"no_login_head"]];
    NSMutableAttributedString  *name = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@\n",model_maimai.name] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18]}];
    
    NSMutableAttributedString *post = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@-%@\n",model_maimai.department,model_maimai.post] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:post];
    NSMutableAttributedString  *com = [[NSMutableAttributedString alloc]initWithString:model_maimai.company attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor grayColor]}];
    [name appendAttributedString:com];
    
    name.yy_lineSpacing =4;
    self.L_contents.attributedText = name;
    
    
}

@end
