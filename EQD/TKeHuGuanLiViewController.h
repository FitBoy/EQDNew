//
//  TKeHuGuanLiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 客户管理

#import "FBBaseViewController.h"
#import "KeHu_ListModel.h"
@interface TKeHuGuanLiViewController : FBBaseViewController
/// 0 个人客户 1 人事客户 3 选择客户导入联系人
@property (nonatomic,assign) NSInteger isRenShi;
@end
@protocol TKeHuGuanLiViewControllerDelegate <NSObject>

@end
