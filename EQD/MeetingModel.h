//
//  MeetingModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/24.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeadPersonModel.h"
@interface MeetingModel : NSObject
@property (nonatomic,assign) float cell_height;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,strong) HeadPersonModel* admin;
///会议目的
@property (nonatomic,copy) NSString* aim;
@property (nonatomic,strong) NSArray* attendees;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,strong) HeadPersonModel* compere;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* duration;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,strong) HeadPersonModel *creater;
@property (nonatomic,copy) NSString* frequency;
@property (nonatomic,copy) NSString* adminName;
-(NSString*)frequency;
@property (nonatomic,copy) NSString* motion;
@property (nonatomic,copy) NSString* place;
@property (nonatomic,strong) HeadPersonModel* recorder;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* timeInterval;
///会议类型
@property (nonatomic,copy) NSString* type;
///0：未开始签到，1：开始签到，2：签到结束
@property (nonatomic,copy) NSString* status;
-(NSString*)createTime;
-(NSString*)startTime;
-(NSString*)endTime;
@end
