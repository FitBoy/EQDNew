//
//  CKHD_LIstBaomingViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 查看报名情况

#import "FBBaseViewController.h"

@interface CKHD_LIstBaomingViewController : FBBaseViewController
@property (nonatomic,copy) NSString* activeId;
///查看报名签到情况  0 报名情况  1 签到情况
@property (nonatomic,assign) NSInteger temp;
@end
