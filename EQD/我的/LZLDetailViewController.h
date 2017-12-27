//
//  LZLDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "LiZhiModel.h"
@interface LZLDetailViewController : FBBaseViewController
@property (nonatomic,strong) LiZhiModel *model;
///1 是领导  2是人事
@property (nonatomic,assign) NSInteger  isshenpi;
@end
