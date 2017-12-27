//
//  QingJiaDetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface QingJiaDetailModel : FBBaseModel
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* JobNumber;
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* departmentId;
@property (nonatomic,copy) NSString* enclosure;
@property (nonatomic,copy) NSString* leaveCode;
@property (nonatomic,copy) NSString* leaveEndTime;
@property (nonatomic,copy) NSString* leaveReason;
@property (nonatomic,copy) NSString* leaveStartTime;
@property (nonatomic,copy) NSString* leaveTimes;
@property (nonatomic,copy) NSString* leaveType;
@property (nonatomic,copy) NSArray* QJ_newImages;
@property (nonatomic,copy) NSString* payMoney;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* uname;
-(NSString*)leaveStartTime;
-(NSString*)leaveEndTime;
@end
