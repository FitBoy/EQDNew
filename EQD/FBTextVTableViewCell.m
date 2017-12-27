//
//  FBTextVTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/4/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBTextVTableViewCell.h"
#import <Masonry.h>
@implementation FBTextVTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.L_name = [[UILabel alloc]init];
        [self addSubview:self.L_name];
        self.L_name.font =[UIFont systemFontOfSize:17];
        
        self.L_content =[[UILabel alloc]init];
        self.L_content.font =[UIFont systemFontOfSize:12];
        [self addSubview:self.L_content];
        self.L_content.numberOfLines=0;
        //下面增加约束
        [self.L_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.mas_left).mas_offset(15);
            make.height.mas_equalTo(20);
            make.right.mas_equalTo(self.mas_right).mas_offset(-15);
            make.top.mas_equalTo(self.mas_top);
        }];
              
    }
    return self;
    
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
