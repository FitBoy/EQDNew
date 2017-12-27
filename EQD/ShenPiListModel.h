//
//  ShenPiListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface ShenPiListModel : FBBaseModel
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* leaveId;
@property (nonatomic,copy) NSString* message;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* step;
///审批人的名字
@property (nonatomic,copy) NSString* uname;
///调休的id
@property (nonatomic,copy) NSString* offId;
///出差的id
@property (nonatomic,copy) NSString* travelId;
///合同的id
@property (nonatomic,copy) NSString* contractId;
@property (nonatomic,copy) NSString* username;

/*
 companyId,departId,id,type,uname,userGuid  权限设置的公告审批人
 */
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* userGuid;

-(NSString*)left0;
-(NSString*)right0;
-(NSString*)left1;
-(NSString*)createTime;

///迟到早退的id
@property (nonatomic,copy) NSString* sickleaveId;
@end
