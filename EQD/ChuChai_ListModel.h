//
//  ChuChai_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface ChuChai_ListModel : FBBaseModel
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* travelAddress;
@property (nonatomic,copy) NSString* travelCode;
-(NSString*)createTime;
@end
