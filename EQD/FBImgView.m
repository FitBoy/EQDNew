//
//  FBImgView.m
//  EQD
//
//  Created by 梁新帅 on 2017/7/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBImgView.h"
#import <UIImageView+AFNetworking.h>
@implementation FBImgView
-(instancetype)initWithImgurls:(NSArray*)iurls
{
    if (self =[super init]) {
        self.arr_imgVarr =[NSMutableArray arrayWithCapacity:0];
        self.imgurls = iurls;
        self.height = (DEVICE_WIDTH-10*(iurls.count+1))/(float)iurls.count;
        for (int i=0; i<iurls.count; i++) {
            UIImageView *imgV =[[UIImageView alloc]initWithFrame:CGRectMake(10+(self.height+10)*i, 5, self.height, self.height)];
            imgV.tag =i+2000;
            [self addSubview:imgV];
            [imgV setImageWithURL:[NSURL URLWithString:iurls[i]] placeholderImage:[UIImage imageNamed:@"imageerro"]];
            [self.arr_imgVarr addObject:imgV];
        }
    }
    return self;
}

@end
