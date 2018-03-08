//
//  FBHeadScrollTitleView.m
//  EQD
//
//  Created by 梁新帅 on 2018/2/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBHeadScrollTitleView.h"
#import <Masonry.h>
#import "FBindexTapGestureRecognizer.h"
@implementation FBHeadScrollTitleView

-(void)setArr_titles:(NSArray *)arr_titles
{
    self.showsHorizontalScrollIndicator =NO;
    self.showsVerticalScrollIndicator = NO;

    _arr_titles = arr_titles;
    UIView *tview = [[UIView alloc]init];
    [self addSubview:tview];
    
    self.arr_labels = [NSMutableArray arrayWithCapacity:0];
    redView = [[UIView alloc]init];
    [tview addSubview:redView];
   redView.backgroundColor = [UIColor redColor];
    float  width = 0;
    for (int i=0; i<arr_titles.count; i++) {
        UILabel *tlabel = [[UILabel alloc]init];
        tlabel.userInteractionEnabled = YES;
        tlabel.textColor = [UIColor grayColor];
        tlabel.text = arr_titles[i];
        tlabel.textAlignment = NSTextAlignmentCenter;
        [tview addSubview:tlabel];
        
        FBindexTapGestureRecognizer  *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.index = i;
        [tlabel addGestureRecognizer:tap];
        NSMutableAttributedString  *tstr = [[NSMutableAttributedString alloc]initWithString:arr_titles[i] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor grayColor]}];
        CGSize size = [tstr boundingRectWithSize:CGSizeMake(200, 30) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        tlabel.frame = CGRectMake(width+10, 5, size.width+2, 30);
        width = size.width+2+10+width;
        if (i==0) {
            CGRect rect = tlabel.frame;
            rect.size.height = 2;
            rect.origin.y = rect.origin.y+31;
            redView.frame = rect;
            tlabel.textColor = [UIColor redColor];
           previewLabel = tlabel;
        }else
        {
            
        }
        [self.arr_labels addObject:tlabel];
    }

    if (width <DEVICE_WIDTH-30) {
        tview.frame =CGRectMake((DEVICE_WIDTH-30-width)/2.0, 0, width+5, 40);
        self.contentSize = CGSizeMake(DEVICE_WIDTH, 40);
    }else
    {
        tview.frame = CGRectMake(15, 0, width+5, 40);
        self.contentSize = CGSizeMake(width+35, 40);
    }
    
    
}
-(void)setClickTapIndex:(NSInteger)index
{
    FBindexTapGestureRecognizer  *tap = [[FBindexTapGestureRecognizer alloc]init];
    tap.index = index;
    [self tapClick:tap];
}
-(void)tapClick:(FBindexTapGestureRecognizer*)tap{
    UILabel *tlabel = self.arr_labels[tap.index];
    previewLabel.textColor = [UIColor grayColor];
    CGRect rect = tlabel.frame;
    rect.size.height = 2;
    rect.origin.y = rect.origin.y+31;
    redView.frame = rect;
    tlabel.textColor = [UIColor redColor];
    previewLabel =tlabel;
    if ([self.delegate_head respondsToSelector:@selector(getSelectedIndex:)]) {
        [self.delegate_head getSelectedIndex:tap.index];
    }
}



@end
