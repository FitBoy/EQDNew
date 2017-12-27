//
//  FBScrollView.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBIndexpathImageView.h"
@interface FBScrollView : UIView<UIScrollViewDelegate>
@property (nonatomic,strong) UIPageControl  *pageControl;
@property (nonatomic,strong) UIScrollView *scrollV;
@property (nonatomic,strong)  NSMutableArray *arr_imageView;
@property (nonatomic,strong)  NSArray  *arr_urls;
-(void)setArr_urls:(NSArray *)arr_urls;
@end
