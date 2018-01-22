//
//  PX_NotificationListModel.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/13.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "PX_NotificationListModel.h"
#import "NSString+FBString.h"
#import <MJExtension.h>
@implementation PX_NotificationListModel

 

-(id)mutableCopyWithZone:(NSZone *)zone
{
    PX_NotificationListModel *model = [[[self class] allocWithZone:zone]init];
    model.receTrainDepName=self.receTrainDepName;
    model.createTime = self.createTime;
    model.ID =self.ID;
    model.personNumber=self.personNumber;
    model.cellHeight =self.cellHeight;
    model.status =self.status;
    model.trainees=self.trainees;
    model.theplace=self.theplace;
    model.teacherName = self.teacherName;
    model.theTheme=self.theTheme;
    model.aSyllabus=self.aSyllabus;
    model.theTrainTime = self.theTrainTime;
    model.presetReleaseTime=self.presetReleaseTime;
    model.receTrainDepId = self.receTrainDepId;
    model.teacherGuid =self.teacherGuid;
    model.teacherInfo= self.teacherInfo;
    model.thePlanId = self.thePlanId;
    model.signstatus = self.signstatus;
    model.betrainedPostId = self.betrainedPostId;
    model.Id = self.Id;
    
    return model;
    
}
+(NSDictionary*)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
-(NSString*)createTime
{
    return [_createTime formatDateString];
}
@end
