//
//  XuQiuPersonModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/11/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface XuQiuPersonModel : FBBaseModel
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* demandAtWorkTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* recruitRenShu;
@property (nonatomic,copy) NSString* remark;
-(NSString*)createTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
/**岗位详情***/
@property (nonatomic,copy) NSString* BZrenshu;
@property (nonatomic,copy) NSString* DLZrenshu;
@property (nonatomic,copy) NSString* XYrenshu;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* depName;
@property (nonatomic,copy) NSString* postDuty;
@property (nonatomic,copy) NSString* recruitReason;
@property (nonatomic,copy) NSString* recruitType;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* createrName;
@end
