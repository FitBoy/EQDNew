//
//  Memo_DetailModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface Memo_DetailModel : FBBaseModel
@property (nonatomic,copy) NSString* createDate;
@property (nonatomic,copy) NSString* endDate;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,copy) NSString* eventCode;
@property (nonatomic,copy) NSString*  eventName;
@property (nonatomic,copy) NSString* eventType;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* memoInfo;
@property (nonatomic,copy) NSString* place;
@property (nonatomic,copy) NSString* startDate;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* timeToRemind;
@property (nonatomic,copy) NSString* userGuid;
-(NSString*)startDate;
-(NSString*)endDate;
-(NSString*)startTime;
-(NSString*)endTime;
@end
