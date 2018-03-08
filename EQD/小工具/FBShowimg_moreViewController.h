//
//  FBShowimg_moreViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBShowimg_moreViewController : FBBaseViewController
///所有的图片的集合
@property (nonatomic,strong)  NSArray <NSString*>*arr_imgs;
///选中的是哪一张图片 默认第一张
@property (nonatomic,assign) NSInteger index;
@end
