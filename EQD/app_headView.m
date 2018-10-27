//
//  app_headView.m
//  EQD
//
//  Created by 梁新帅 on 2018/10/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "app_headView.h"
#import "FBindexTapGestureRecognizer.h"
@implementation app_headView
-(float)resetFrameWithArrModels:(NSArray<GNmodel*>*)arrModels
{
    _arr_models = arrModels;
    float height = 70;
    float interval = (DEVICE_WIDTH -30 -70*4)/3.0;
    if(arrModels.count>4)
    {
        for(int i=0;i<arrModels.count;i++)
        {
            GNmodel *model = arrModels[i];
            IV_lableView *tILv = [[IV_lableView alloc]init];
            [tILv setimg:model.img tiele:model.name isLocal:YES];
            tILv.userInteractionEnabled = YES;
            [self addSubview:tILv];
            tILv.frame = CGRectMake(15+(70+interval)*(i%4), 0+(i/4)*80, 70, 70);
            FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            tap.index = i;
            [tILv addGestureRecognizer:tap];
            
        }
        height =150;
    }else
    {
        height =70;
        for (int i=0; i<arrModels.count; i++) {
            GNmodel *model = arrModels[i];
            IV_lableView *tILv = [[IV_lableView alloc]init];
             [tILv setimg:model.img tiele:model.name isLocal:YES];
            tILv.userInteractionEnabled = YES;
            [self addSubview:tILv];
            tILv.frame = CGRectMake(15+(70+interval)*i, 0, 70, 70);
            FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            tap.index = i;
            [tILv addGestureRecognizer:tap];
        }
    }
    return height;
}

-(void)tapClick:(FBindexTapGestureRecognizer*)tap{
    if ([self.delegate_appHead respondsToSelector:@selector(appHeadSelectedIndex:)]) {
        [self.delegate_appHead appHeadSelectedIndex:tap.index];
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
