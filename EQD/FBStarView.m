//
//  FBStarView.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/12.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBStarView.h"
#import "FBindexTapGestureRecognizer.h"
#import <Masonry.h>
@implementation FBStarView
-(void)setViewWithnumber:(NSInteger)number selected:(NSInteger)index
{
    if(arr_iviews.count)
    {
        [arr_iviews  removeAllObjects];
    }else
    {
    arr_iviews = [NSMutableArray arrayWithCapacity:0];
    }
    float  width = (DEVICE_WIDTH-30-5*(number-1))/number;
    for (int i=0; i<number; i++) {
        UIImageView  *tview = [[UIImageView alloc]init];
        tview.userInteractionEnabled =YES;
        FBindexTapGestureRecognizer *tap= [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.index = i;
        if (i>index) {
           tview.image = [UIImage imageNamed:@"pingjia_kong"];
        }else
        {
              tview.image = [UIImage imageNamed:@"pingjia_man"];
        }
      
        [tview addGestureRecognizer:tap];
        [self addSubview:tview];
        [tview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.centerY.mas_equalTo(self.mas_centerY);
            make.left.mas_equalTo(self.mas_left).mas_offset(15+(width+5)*i);
        }];
        
        [arr_iviews addObject:tview];
    }
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap{
    //以点击的为准，两边绝对分
    for(int i=0;i<arr_iviews.count;i++)
    {
        UIImageView *tivew = arr_iviews[i];
        if (i>tap.index) {
            tivew.image = [UIImage imageNamed:@"pingjia_kong"];
        }else
        {
            tivew.image = [UIImage imageNamed:@"pingjia_man"];
        }
    }
    if([self.delegate_number respondsToSelector:@selector(getNumber:selected:)])
    {
        [self.delegate_number getNumber:tap.index selected:self.selected_index];
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
