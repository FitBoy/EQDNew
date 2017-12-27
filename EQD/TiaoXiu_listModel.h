//
//  TiaoXiu_listModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface TiaoXiu_listModel : FBBaseModel
@property (nonatomic,copy) NSString*  createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString*  offCode;
@property (nonatomic,copy) NSString* planEndTime;
@property (nonatomic,copy) NSString* planStartTime;
-(NSString*)createTime;
-(NSString*)planEndTime;
-(NSString*)planStartTime;
@end
