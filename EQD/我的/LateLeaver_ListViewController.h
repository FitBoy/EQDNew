//
//  LateLeaver_ListViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface LateLeaver_ListViewController : FBBaseViewController
///1 迟到早退审批     2 人事的审批   3 漏打卡列表  4 漏打卡审批  5 漏打卡人事审批
@property (nonatomic,assign) NSInteger isShenpi;
@end
