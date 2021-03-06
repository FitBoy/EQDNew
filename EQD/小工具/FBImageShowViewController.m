//
//  FBImageShowViewController.m
//  EQD
//
//  Created by 梁新帅 on 2017/5/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBImageShowViewController.h"
#import "STImageVIew.h"
@interface FBImageShowViewController ()<UIScrollViewDelegate,STImageViewDelegate>
{
    NSInteger selected_scroll;
    NSMutableArray *arr_images;
    CGFloat _lastScale;
}

@end

@implementation FBImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationItem.title = [NSString stringWithFormat:@"%ld / %ld",self.indexPath.row+1,self.modelArr.count-1];
     [self.view addSubview:self.S_scroll];
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"删除" style:UIBarButtonItemStylePlain target:self action:@selector(shanchuClick)];
    [self.navigationItem setRightBarButtonItem:right];
    arr_images = [NSMutableArray arrayWithCapacity:0];
    selected_scroll =self.indexPath.row;
    [self scrollUI];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(tapClcik)];
    [self.navigationItem setLeftBarButtonItem:left];
    _lastScale=1.f;
    
}

- (void)stImageVIewSingleClick:(STImageVIew *)imageView{
    [self tapClcik];
}

-(void)tapClcik
{
    if ([self.delegate respondsToSelector:@selector(modelArr:WithSelected:)]) {
        [self.delegate modelArr:self.modelArr WithSelected:selected_scroll];
    }
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)shanchuClick{
    //删除
    for (int i=0; i<arr_images.count; i++) {
        UIImageView *tview = arr_images[i];
        [tview removeFromSuperview];
    }
     [self.modelArr  removeObjectAtIndex:selected_scroll];
    if (selected_scroll ==self.modelArr.count-2) {
        selected_scroll-=1;
    }
    
    [self scrollUI];
    self.navigationItem.title = [NSString stringWithFormat:@"%d / %ld",(int)(selected_scroll+1),_modelArr.count-1];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navigationItem.title = [NSString stringWithFormat:@"%d / %ld",(int)(scrollView.contentOffset.x/DEVICE_WIDTH+1),_modelArr.count-1];
    selected_scroll =scrollView.contentOffset.x/DEVICE_WIDTH;
    
}

-(UIScrollView*)S_scroll
{
    if (!_S_scroll) {
        _S_scroll =[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, DEVICE_WIDTH, DEVICE_HEIGHT-64)];
        _S_scroll.delegate=self;
        _S_scroll.zoomScale=3;
        _S_scroll.maximumZoomScale=3;
        _S_scroll.pagingEnabled=YES;
        _S_scroll.backgroundColor =[UIColor blackColor];
        
        [self.view addSubview:_S_scroll];
    }
    return _S_scroll;
}
-(void)scrollUI{
     self.S_scroll.contentSize =CGSizeMake(DEVICE_WIDTH*(_modelArr.count-1), DEVICE_HEIGHT-64);
    self.S_scroll.pagingEnabled=YES;
    for (int i =0; i<_modelArr.count-1; i++) {
        FBTextImgModel *model =_modelArr[i];
        float height =(float)DEVICE_WIDTH *model.asset.pixelHeight/model.asset.pixelWidth;
        STImageVIew *tview =[[STImageVIew alloc]initWithFrame:CGRectMake(DEVICE_WIDTH*i, (DEVICE_HEIGHT-64-height)/2.0, DEVICE_WIDTH, height)];
        tview.delegate =self;
        [self.S_scroll addSubview:tview];
        tview.image = model.image;
        [arr_images addObject:tview];
    }
    [self.S_scroll setContentOffset:CGPointMake(DEVICE_WIDTH*selected_scroll, 0)];

}

@end
