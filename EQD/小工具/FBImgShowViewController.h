//
//  FBImgShowViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 根据 url 多图片查看 

#import <UIKit/UIKit.h>

@interface FBImgShowViewController : UIViewController
@property (nonatomic,strong) NSArray <NSString*>*imgstrs;
///记录被选中的是哪一种图片 必传
@property (nonatomic,assign) NSInteger selected;
@end
