//
//  TiaoBan_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//


#import "FBBaseViewController.h"
#import "TiaoBan_ListModel.h"
@interface TiaoBan_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  TiaoBan_ListModel *model;
/// 1是审批
@property (nonatomic,assign)NSInteger isshenpi;

/// 1代表的人事
@property (nonatomic,assign) NSInteger isRenShi;
@end
