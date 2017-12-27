//
//  HeTong_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "HeTong_ListModel.h"
@interface HeTong_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  HeTong_ListModel *model;
///0 详情 1 签订  2 人事审批  3 最高领导审批
@property (nonatomic,assign) NSInteger isQianDing;
@end
