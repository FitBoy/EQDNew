//
//  projectExprienceModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/12.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface projectExprienceModel : FBBaseModel
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* duty;
@property (nonatomic,copy) NSString* endTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isDel;
@property (nonatomic,copy) NSString* isOvert;
@property (nonatomic,copy) NSString* ownedCompany;
@property (nonatomic,copy) NSString* projectDescription;
@property (nonatomic,copy) NSString* projectName;
@property (nonatomic,copy) NSString* projectURL;
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* userGuid;
-(NSString*)startTime;
-(NSString*)endTime;
-(NSString*)left0;
-(NSString*)left1;
-(BOOL)ischoose;
@end
