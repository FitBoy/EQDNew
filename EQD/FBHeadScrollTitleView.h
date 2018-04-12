//
//  FBHeadScrollTitleView.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 40 左右

#import <UIKit/UIKit.h>
@interface FBHeadScrollTitleView : UIScrollView
{
    UIView *redView;
    UILabel *previewLabel;
}

@property (nonatomic,strong)  NSArray *arr_titles;
@property (nonatomic,strong)  NSMutableArray  *arr_labels;
@property (nonatomic,weak) id delegate_head;
-(void)setArr_titles:(NSArray *)arr_titles;
-(void)setClickTapIndex:(NSInteger)index;

@end
@protocol FBHeadScrollTitleViewDelegate <NSObject>
-(void)getSelectedIndex:(NSInteger)index;
@end

