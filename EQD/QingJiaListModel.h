//
//  QingJiaListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface QingJiaListModel : FBBaseModel
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
///请假编码
@property (nonatomic,copy) NSString* leaveCode;
///请假类型
@property (nonatomic,copy) NSString* leaveType;
-(NSString*)left0;
-(NSString*)right0;

@end
