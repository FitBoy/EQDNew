//
//  PX_PlanViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/10.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 培训计划

#import "FBBaseViewController.h"
#import "PlanListModel.h"

@interface PX_PlanViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@end
@protocol PX_PlanViewControllerDelegate <NSObject>
-(void)getPlanListModel:(PlanListModel*)planModel;
@end
