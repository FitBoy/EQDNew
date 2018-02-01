//
//  EQDS_SearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 讲师的搜索


#import "FBBaseViewController.h"
#import "EQDS_teacherInfoModel.h"

@interface EQDS_SearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@end
@protocol EQDS_SearchViewControllerDelegate <NSObject>
-(void)getTeacherInfo:(EQDS_teacherInfoModel*)model;

@end
