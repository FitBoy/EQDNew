//
//  EQDR_articleModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/15.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface EQDR_articleModel : FBBaseModel
@property (nonatomic,copy) NSString* createrTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isdraft;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,copy) NSString* userGuid;
-(NSString*)createrTime;
-(NSString*)left0;
-(NSString*)right1;
@end
