//
//  SPDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "RuZhiSPModel.h"
@interface SPDetailViewController : FBBaseViewController
@property (nonatomic,strong)  RuZhiSPModel *model;
///详情0 入职审批    ***1在职，离职详情
@property (nonatomic,copy) NSString *isDetail;
@end
