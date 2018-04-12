//
//  FBImgsScrollView.m
//  EQD
//
//  Created by 梁新帅 on 2018/3/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBImgsScrollView.h"
#import <Masonry.h>
#import "FBindexTapGestureRecognizer.h"
#import <UIImageView+WebCache.h>
@implementation FBImgsScrollView
-(void)setArr_stringImgs:(NSArray *)arr_stringImgs Withsize:(CGSize)size
{
    self.size =size;
    _arr_stringImgs = arr_stringImgs;
    self.arr_imageViews = [NSMutableArray arrayWithCapacity:0];
    self.contentSize = CGSizeMake((self.size.width+5)*arr_stringImgs.count+30, self.size.height+10);
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
    
    for (int i=0; i<arr_stringImgs.count; i++) {
        UIImageView *tview = [[UIImageView alloc]init];
        tview.userInteractionEnabled =YES;
        tview.layer.masksToBounds =YES;
        tview.layer.cornerRadius =5;
        [tview sd_setImageWithURL:[NSURL URLWithString:arr_stringImgs[i]]];
        [self addSubview:tview];
        FBindexTapGestureRecognizer *tap = [[FBindexTapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
        tap.index = i;
        [tview addGestureRecognizer:tap];
        [tview mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.size);
            make.top.mas_equalTo(self.mas_top).mas_offset(5);
            make.left.mas_equalTo(self.mas_left).mas_offset(15+(self.size.width+5)*i);
        }];
        
        
        [self.arr_imageViews addObject:tview];
    }
}

-(void)tapClick:(FBindexTapGestureRecognizer*)tap{
    
    if ([self.delegate_imgviews respondsToSelector:@selector(getImgsScrollViewSelectedViewWithtag:indexPath:)]) {
        [self.delegate_imgviews getImgsScrollViewSelectedViewWithtag:tap.index indexPath:self.indexPath];
    }
}

@end
