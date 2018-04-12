//
//  FFMyExpenseDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/21.
//  Copyright © 2018年 FitBoy. All rights reserved.
//报销单的详情

#import "FBBaseViewController.h"

@interface FFMyExpenseDetailViewController : FBBaseViewController
/// 1 只看详情  2 审批
@property (nonatomic,copy) NSString* isShow;
///报销单的Id
@property (nonatomic,copy) NSString* Id;

@end
