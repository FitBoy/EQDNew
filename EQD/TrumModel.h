//
//  TrumModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface TrumModel : FBBaseModel
@property (nonatomic,copy) NSString* comid;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* createDate;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* trumCode;
@property (nonatomic,copy) NSString* userGuid;
-(NSString*)createTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
@property (nonatomic,assign) float cellHeight;
@end
