//
//  PX_CourseManagerViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 课程管理

#import "FBBaseViewController.h"
#import "PX_courseManageModel.h"

@interface PX_CourseManagerViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@end
@protocol PX_CourseManagerViewControllerDelegate <NSObject>
-(void)getCourse:(PX_courseManageModel*)model_course;
@end
