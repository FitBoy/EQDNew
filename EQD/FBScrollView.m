//
//  FBScrollView.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#import "FBScrollView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
@implementation FBScrollView
-(UIPageControl*)pageControl
{
    if (!_pageControl) {
        _pageControl =[[UIPageControl alloc]init];
        [_pageControl addTarget:self action:@selector(pageChoose) forControlEvents:UIControlEventValueChanged];
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        [self addSubview:_pageControl];
        [_pageControl bringSubviewToFront:self.scrollV];
        [_pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
            make.left.right.mas_equalTo(self);
            make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-5);
        }];
    }
    return _pageControl;
}
-(UIScrollView*)scrollV
{
    if(!_scrollV)
    {
        _scrollV =[[UIScrollView alloc]init];
        _scrollV.delegate =self;
        [self addSubview:_scrollV];
         _scrollV.pagingEnabled =YES;
        _scrollV.alwaysBounceVertical=NO;
        [_scrollV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(self);
        }];
        
        
    }
    return _scrollV;
}

-(void)setArr_urls:(NSArray *)arr_urls
{
    self.userInteractionEnabled=YES;
    _arr_urls =arr_urls;
    self.scrollV.contentSize =CGSizeMake(self.frame.size.width*arr_urls.count, self.frame.size.height);
    self.scrollV.showsHorizontalScrollIndicator =NO;
    self.pageControl.numberOfPages =arr_urls.count;
    self.arr_imageView =[NSMutableArray arrayWithCapacity:0];
    for (int i=0; i<arr_urls.count; i++) {
        FBIndexpathImageView *tview =[[FBIndexpathImageView alloc]initWithFrame:CGRectMake(self.frame.size.width*i, 0, self.frame.size.width, self.frame.size.height)];
        tview.userInteractionEnabled=YES;
        tview.index=i;
        tview.userInteractionEnabled=YES;
        [self.scrollV addSubview:tview];
        [tview sd_setImageWithURL:[NSURL URLWithString:arr_urls[i]]];
        [self.arr_imageView addObject:tview];
    }
}

-(void)pageChoose{
    [self.scrollV setContentOffset:CGPointMake(self.frame.size.width*self.pageControl.currentPage, 0)];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (NSInteger)scrollView.contentOffset.x/self.frame.size.width;
    
}


@end
