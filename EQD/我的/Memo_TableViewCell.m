//
//  Memo_TableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/12/5.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "Memo_TableViewCell.h"
#import <Masonry.h>
@implementation Memo_TableViewCell
-(UIImageView*)IV_img
{
    if (!_IV_img) {
        _IV_img = [[UIImageView alloc]init];
        [self addSubview:_IV_img];
        _IV_img.image = [UIImage imageNamed:@"memo_circle"];
        [_IV_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.top.mas_equalTo(self.mas_top).mas_offset(20);
            make.left.mas_equalTo(self.mas_left).mas_offset(10);
        }];
    }
    return _IV_img;
}
-(UIView*)V_line

{
    if (!_V_line) {
        _V_line = [[UIView alloc]init];
        _V_line.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [self addSubview:_V_line];
        [_V_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(1);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.top.mas_equalTo(self.mas_top).mas_offset(40);
        }];
        
    }
    return _V_line;
}
-(UIImageView*)IV_time
{
    if (!_IV_time ) {
        _IV_time = [[UIImageView alloc]init];
        [self addSubview:_IV_time];
        _IV_time.image = [UIImage imageNamed:@"memo_time"];
        [_IV_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15, 15));
            make.left.mas_equalTo(self.mas_left).mas_offset(30);
            make.top.mas_equalTo(self.mas_top).mas_offset(17);
        }];
        
    }
    return _IV_time;
}
-(UILabel*)L_time
{
    if (!_L_time) {
        _L_time = [[UILabel alloc]init];
        [self addSubview:_L_time];
        _L_time.textColor =  [UIColor grayColor];
        [_L_time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.IV_time.mas_right).mas_offset(5);
            make.right.mas_equalTo(self.L_type.mas_left).mas_offset(-5);
            make.height.mas_equalTo(20);
            make.top.mas_equalTo(self.mas_top).mas_offset(15);
        }];
    }
    return _L_time;
}
-(UILabel*)L_type
{
    if (!_L_type) {
        _L_type = [[UILabel alloc]init];
        _L_type.font = [UIFont systemFontOfSize:15];
        _L_type.textAlignment  = NSTextAlignmentRight;
        [self addSubview:_L_type];
        [_L_type  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.top.mas_equalTo(self.mas_top).mas_offset(10);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    return _L_type;
}

-(UIView*)V_contents
{
    if (!_V_contents) {
        _V_contents = [[UIView alloc]init];
        _V_contents.layer.masksToBounds = YES;
        _V_contents.layer.cornerRadius =6;
        [self addSubview:_V_contents];
        _V_contents.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
        [_V_contents mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.mas_top).mas_offset(50);
            make.left.mas_equalTo(self.mas_left).mas_offset(30);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        }];
    }
    return _V_contents;
    
}
-(YYLabel*)yl_contents
{
    if (!_yl_contents) {
        _yl_contents = [[YYLabel alloc]init];
        _yl_contents.numberOfLines =0;
        [self.V_contents addSubview:_yl_contents];
        
    }
    return _yl_contents;
}
-(UILabel*)L_address
{
    if(!_L_address)
    {
        _L_address = [[UILabel alloc]init];
        _L_address.textColor = [UIColor grayColor];
        _L_address.font = [UIFont systemFontOfSize:13];
//        _L_address.textAlignment =  NSTextAlignmentRight;
        [self.V_contents addSubview:_L_address];
        [_L_address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.V_contents.mas_right).mas_offset(-5);
            make.bottom.mas_equalTo(self.V_contents.mas_bottom).mas_offset(-5);
            make.left.mas_equalTo(self.IV_location.mas_right).mas_offset(5);
        }];
    }
    return _L_address;
}
-(UIImageView*)IV_location
{
    if (!_IV_location) {
        _IV_location = [[UIImageView alloc]init];
        [self.V_contents addSubview:_IV_location];
        _IV_location.image = [UIImage imageNamed:@"memo_location"];
        [_IV_location mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 13));
            make.bottom.mas_equalTo(self.V_contents.mas_bottom).mas_offset(-7);
            make.right.mas_equalTo(self.L_address.mas_left).mas_offset(-5);
        }];
    }
    return _IV_location;
}

-(void)setModel:(Memo_DetailModel * _Nonnull)model
{
    _model = model;
    self.L_time.text = [NSString stringWithFormat:@"%@ ~ %@",model.startTime,model.endTime];
    if ([model.eventType isEqualToString:@"空闲"]) {
        self.L_type.textColor =[UIColor blueColor];
    }else if([model.eventType isEqualToString:@"暂定"])
    {
        self.L_type.textColor =[UIColor orangeColor];
    }else if([model.eventType isEqualToString:@"忙碌"])
    {
        self.L_type.textColor =[UIColor redColor];
    }else
    {
        self.L_type.textColor =[UIColor greenColor];
    }
    self.L_type.text = model.eventType;
    self.L_address.text = model.place;
    NSMutableAttributedString *contents = [[NSMutableAttributedString alloc]initWithString:model.eventName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]}];
    NSMutableAttributedString *cont = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"\n%@",model.memoInfo] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor colorWithRed:86/255.0 green:86/255.0 blue:86/255.0 alpha:1]}];
    [contents appendAttributedString:cont];
    contents.yy_lineSpacing =6;
    CGSize size = [contents boundingRectWithSize:CGSizeMake(self.frame.size.width-40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    self.yl_contents.attributedText = contents;
    [self.V_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+30);
        make.top.mas_equalTo(self.mas_top).mas_offset(50);
        make.left.mas_equalTo(self.mas_left).mas_offset(25);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    [self.yl_contents mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(size.height+5);
        make.left.mas_equalTo(self.V_contents.mas_left).mas_offset(5);
        make.right.mas_equalTo(self.V_contents.mas_right).mas_offset(-5);
        make.top.mas_equalTo(self.V_contents.mas_top).mas_offset(5);
    }];
    
    model.cell_height = size.height + 50 + 40 +10;
   
    self.V_line.hidden = NO;
    self.IV_img.hidden = NO;
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
