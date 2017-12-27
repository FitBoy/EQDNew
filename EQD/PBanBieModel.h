//
//  PBanBieModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface PBanBieModel : FBBaseModel
@property (nonatomic,copy) NSString* ruleName;
@property (nonatomic,copy) NSString* weeks;
@property (nonatomic,copy) NSString* holidays;
@property (nonatomic,copy) NSString* shiftName;
@property (nonatomic,strong)  NSArray *times;

@end

@interface StartEndModel : NSObject
@property (nonatomic,copy) NSString* startTime;
@property (nonatomic,copy) NSString* endTime;

-(NSString*)startTime;
-(NSString*)endTime;
@end
