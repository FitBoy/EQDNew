//
//  QJCCModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface QJCCModel : FBBaseModel
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* approvalLevel;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* maxTime;
@property (nonatomic,copy) NSString* minTime;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* uname;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
@end
