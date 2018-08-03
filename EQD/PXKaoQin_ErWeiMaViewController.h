//
//  PXKaoQin_ErWeiMaViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/26.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 考勤的二维码 

#import "FBBaseViewController.h"
#import "PXQianDaoModel.h"
#import "MeetingModel.h"
@interface PXKaoQin_ErWeiMaViewController : FBBaseViewController
/// 0 培训考勤的签到二维码 1 会议签到的二维码
@property (nonatomic,assign) NSInteger temp;
@property (nonatomic,strong)  PXQianDaoModel  *model_qiandao;
@property (nonatomic,strong)  MeetingModel  *model_huiyi;
@end
