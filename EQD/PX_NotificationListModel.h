//
//  PX_NotificationListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PX_NotificationListModel : NSObject <NSMutableCopying>
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* personNumber;
@property (nonatomic,copy) NSString* receTrainDepName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* teacherName;
@property (nonatomic,copy) NSString* theTheme;
@property (nonatomic,copy) NSString* theplace;
@property (nonatomic,copy) NSString* trainees;

@property (nonatomic,assign)  float cellHeight;
-(NSString*)createTime;

/**通知详情多出来的字段**/
@property (nonatomic,copy) NSString* aSyllabus;
@property (nonatomic,copy) NSString* presetReleaseTime;
@property (nonatomic,copy) NSString* receTrainDepId;
@property (nonatomic,copy) NSString* teacherGuid;
@property (nonatomic,copy) NSString* teacherInfo;
@property (nonatomic,copy) NSString* thePlanId;
@property (nonatomic,copy) NSString* theTrainTime;
/*培训考勤
 Id = 3;
 betrainedPostId = "25,26";
 createTime = "2018-01-13T16:18:53.77";
 personNumber = 10;
 receTrainDepName = "\U7814\U8ba8\U90e8,\U9886\U5bfc\U5c42,\U62db\U8058";
 signstatus = 0;
 status = 1;
 teacherName = "\U90ed\U660a\U539f";
 theTheme = "\U4e16\U754c\U548c\U5e73";
 theplace = "\U57f9\U8bad\U5730\U70b9";
 trainees =
 
 */
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* betrainedPostId;
@property (nonatomic,copy) NSString* signstatus;
-(id)mutableCopyWithZone:(NSZone *)zone;
@end
