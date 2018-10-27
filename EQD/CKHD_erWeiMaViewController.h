//
//  CKHD_erWeiMaViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 活动二维码

#import "FBBaseViewController.h"
#import "CKHD_detailModel.h"
@interface CKHD_erWeiMaViewController : FBBaseViewController
///1是报名二维码  2是签到二维码
@property (nonatomic,assign) NSInteger temp;

/// 活动的主题  时间 地点
@property (nonatomic,strong) CKHD_detailModel *model_detail;

@end
