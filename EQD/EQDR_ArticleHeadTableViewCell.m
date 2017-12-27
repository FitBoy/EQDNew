//
//  EQDR_ArticleHeadTableViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "EQDR_ArticleHeadTableViewCell.h"

@implementation EQDR_ArticleHeadTableViewCell
-(UILabel*)L_title
{
    if (!_L_title) {
        _L_title = [[UILabel alloc]init];
        [self addSubview:_L_title];
        _L_title.font = [UIFont systemFontOfSize:21];
        _L_title.numberOfLines=0;
    }
    return _L_title;
}
-(UILabel*)L_shuoming
{
    if(!_L_shuoming)
    {
        _L_shuoming = [[UILabel alloc]init];
        [self addSubview:_L_shuoming];
        _L_shuoming.textColor = [UIColor grayColor];
        _L_shuoming.font =[UIFont systemFontOfSize:13];
    }
    return _L_shuoming;
}




@end
