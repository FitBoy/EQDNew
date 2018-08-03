//
//  RiZhi_PingLunDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/4/28.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "GZQ_PingLunModel.h"
@interface RiZhi_PingLunDetailViewController : FBBaseViewController
@property (nonatomic,strong)  GZQ_PingLunModel  *model;
/// 0 日志 1任务
@property (nonatomic,assign)  NSInteger temp;
@end
