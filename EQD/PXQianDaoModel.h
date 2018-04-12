//
//  PXQianDaoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXQianDaoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* comName;
@property (nonatomic,copy) NSString* courseEndTime;
@property (nonatomic,copy) NSString* courseStartTime;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* noticeId;
@property (nonatomic,copy) NSString* signDetailIsWhole;
@property (nonatomic,copy) NSString* signLaunchTime;
@property (nonatomic,copy) NSString* signStartTime;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* theTrainTime;
-(NSString*)courseEndTime;
-(NSString*)courseStartTime;
-(NSString*)signStartTime;
-(NSString*)signLaunchTime;
/*考勤的的时候多出来的字段*/
@property (nonatomic,copy) NSString* betrainedPostId;
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* courseId;
@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSString* trainees;
@property (nonatomic,copy) NSString* teacherName;
@property (nonatomic,copy) NSString* teacherGuid;
@property (nonatomic,copy) NSString* theplace;
@property (nonatomic,assign) float  cellHeight;

-(NSArray*)getStartTimeAndEndTime;
@end
