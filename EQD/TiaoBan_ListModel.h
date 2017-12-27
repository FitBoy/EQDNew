//
//  TiaoBan_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/28.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface TiaoBan_ListModel : FBBaseModel
@property (nonatomic,copy) NSString* changeShiftCode;
@property (nonatomic,copy) NSString* changeShiftName;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
-(NSString*)left0;
-(NSString*)right0;
@end

