//
//  FBImageShowViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 本地相册的图片展示

#import "FBBaseViewController.h"
#import "FBTextImgModel.h"
@interface FBImageShowViewController : FBBaseViewController
///该属性必传
@property (nonatomic,strong) NSMutableArray<FBTextImgModel*>* modelArr;
@property (nonatomic,weak)  id delegate;
@property (nonatomic,strong)  UIScrollView *S_scroll;
///该属性必传
@property (nonatomic,strong)  NSIndexPath *indexPath;

@end
@protocol FBImageShowViewControllerDelegate <NSObject>

-(void)modelArr:(NSArray <FBTextImgModel*>*)arr WithSelected:(NSInteger)selected;

@end
