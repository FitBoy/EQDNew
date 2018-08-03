//
//  RenWuListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface RenWuListModel : FBBaseModel
///任务编码
@property (nonatomic,copy) NSString* code;
@property (nonatomic,copy) NSString* creatTime;
@property (nonatomic,copy) NSString* ID;
//是否验收
@property (nonatomic,copy) NSString* ischeck;
///任务名称
@property (nonatomic,copy) NSString* name;
///责任人
@property (nonatomic,copy) NSString* recipient;
///任务的完成状态
@property (nonatomic,copy) NSString* status;
///任务描述
@property (nonatomic,copy) NSString* taskDesc;
@property (nonatomic,assign) float height_cell;
-(NSString*)left0;
-(NSString*)right0;
-(NSString*)right1;
-(NSString*)left1;
@end
