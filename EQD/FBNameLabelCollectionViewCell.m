//
//  FBNameLabelCollectionViewCell.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/4.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBNameLabelCollectionViewCell.h"
#import <Masonry.h>
@implementation FBNameLabelCollectionViewCell
-(UILabel*)L_name
{
    if (!_L_name) {
        _L_name = [[UILabel alloc]init];
        _L_name.textAlignment = NSTextAlignmentCenter;
        _L_name.userInteractionEnabled =YES;
        _L_name.layer.borderWidth =1;
        _L_name.layer.borderColor= [UIColor redColor].CGColor;
       
        _L_name.font = [UIFont systemFontOfSize:15];
        [self addSubview:_L_name];
    }
    return _L_name;
}
@end
