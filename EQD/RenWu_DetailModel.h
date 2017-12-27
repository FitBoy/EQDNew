//
//  RenWu_DetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"
#import "RWD_FuJiamodel.h"
@interface RenWu_DetailModel : FBBaseModel
@property (nonatomic,copy) NSString* Assist;
@property (nonatomic,copy) NSString* CheckStandard;
@property (nonatomic,copy) NSString* CheckTime;
@property (nonatomic,copy) NSString* Checker;
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,copy) NSString* CompleteImageUrl;
@property (nonatomic,copy) NSArray* CompleteImageUrls;
@property (nonatomic,copy) NSString* CompleteMessage;
@property (nonatomic,copy) NSString* CompleteTime;
@property (nonatomic,copy) NSString* Duty;
@property (nonatomic,copy) NSString* EndTime;
@property (nonatomic,copy) NSString* Initiator;
@property (nonatomic,copy) NSString* IsCheck;
@property (nonatomic,copy) NSString* Isdel;
@property (nonatomic,copy) NSString* Notify;
@property (nonatomic,copy) NSString* OptionMessage;
@property (nonatomic,copy) NSString* OptionTime;
@property (nonatomic,copy) NSString* ParentTaskId;
@property (nonatomic,copy) NSString* StartTime;
@property (nonatomic,copy) NSString* Status;
@property (nonatomic,copy) NSString* TaskCode;
@property (nonatomic,copy) NSString* TaskDesc;
@property (nonatomic,copy) NSString* TaskName;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,strong)  NSArray *RS_newAssist;
@property (nonatomic,strong)  RWD_FuJiamodel *RS_newChecker;
@property (nonatomic,strong)  RWD_FuJiamodel *RS_newInitiator;
@property (nonatomic,strong)  NSArray  *RS_newNotify;
@property (nonatomic,strong)  RWD_FuJiamodel *RS_newRecipient;
@property (nonatomic,copy) NSString* recipient;
@property (nonatomic,copy) NSString* parentTaskName;

-(NSString*)CompleteTime;
@end
