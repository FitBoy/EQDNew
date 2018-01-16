//
//  PXChooseListViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//  各种选择

#import "FBBaseViewController.h"
#import "FB_PeiXun_ListModel.h"

@interface PXChooseListViewController : FBBaseViewController
/// 培训申请
@property (nonatomic,assign) NSInteger  temp;
@property (nonatomic,weak) id  delegate;
@end
@protocol PXChooseListViewControllerdelegate <NSObject>
-(void)getPeiXunlistModel:(FB_PeiXun_ListModel*)model;
@end
