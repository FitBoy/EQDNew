//
//  Meeting_noticeViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 会议通知

#import "FBBaseViewController.h"
#import "MeetingModel.h"
@interface Meeting_noticeViewController : FBBaseViewController
///1 是人事查看所有的 通知  0是个人查看通知
@property (nonatomic,assign) NSInteger temp;
@property (nonatomic,weak) id delegate_huiyi;
@end
@protocol Meeting_noticeViewControllerDelegate <NSObject>
-(void)getMeetingModel:(MeetingModel*)tmodel;
@end

