//
//  LateLeaver_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "LaterModel.h"
@interface LateLeaver_DetailViewController : FBBaseViewController
/// 0 迟到早退的详情  1 迟到早退的审批  2 迟到早退的人事审批   3 漏打卡详情 4 审批 5人事的审批
@property (nonatomic,assign) NSInteger  isShenPi;
@property (nonatomic,strong)  LaterModel *model;
@end
