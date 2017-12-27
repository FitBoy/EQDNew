//
//  liZhiListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface liZhiListModel : FBBaseModel
@property (nonatomic,copy) NSString* JobNumber;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString*  departName;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* message;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* quitId;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* status;


-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;

@end
