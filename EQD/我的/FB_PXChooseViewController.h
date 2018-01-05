//
//  FB_PXChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//  获取部门下的岗位 或者全部的岗位  根据操作人的权限  

#import "FBBaseViewController.h"
#import "GangweiModel.h"
@interface FB_PXChooseViewController : FBBaseViewController
@property (nonatomic,weak) id  delegate;
@property (nonatomic,strong) NSArray  *arr_choseModel;
@end
@protocol FB_PXChooseViewControllerDelegate  <NSObject>
-(void)getGangweiModel:(NSArray<GangweiModel*>*)arr_gangwei;
@end
