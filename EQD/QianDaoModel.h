//
//  QianDaoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QianDaoModel : NSObject
/** 考勤签到的字段*/
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* signStartTime;
@property (nonatomic,copy) NSString* courseStartTime;
@property (nonatomic,copy) NSString* courseEndTime;
@property (nonatomic,copy) NSString* theTrainTime;
@property (nonatomic,copy) NSString* theplace;
@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSString* comName;
@property (nonatomic,copy) NSString* trainees;
@property (nonatomic,copy) NSString* teacherName;
/** 考勤签到的字段*/
/**会议签到的字段 id,type,place,startTime endTime **/
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* place;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* endTime;
/**会议签到的字段**/

@end
