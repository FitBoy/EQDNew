//
//  FBIVLView.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBIVLView.h"

@implementation FBIVLView
-(instancetype)initWithimg:(NSString*)img andName:(NSString*)name{
    if (self = [super init]) {
        self.IV_img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _IV_img.userInteractionEnabled=YES;
        [self addSubview:self.IV_img];
        
        self.L_name=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, 50, 15)];
        self.L_name.font= [UIFont systemFontOfSize:12];
        [self addSubview:self.L_name];
        
    }
    return self;
}

@end
