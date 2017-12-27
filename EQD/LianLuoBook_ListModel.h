//
//  LianLuoBook_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface LianLuoBook_ListModel : FBBaseModel
/**列表**/
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* liasionBookName;
@property (nonatomic,copy) NSString* liasionBookTheme;
@property (nonatomic,copy) NSString* objectName;
-(NSString*)createTime;

/****联络书详情***/

@property (nonatomic,copy) NSString* Enclosure;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* checkMessage;
@property (nonatomic,copy) NSString* checkStatus;
@property (nonatomic,copy) NSString* checkTime;
@property (nonatomic,copy) NSString* checker;
@property (nonatomic,copy) NSString* checkerName;
///申请人
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createrCompany;
@property (nonatomic,copy) NSString* createrCompanyId;
@property (nonatomic,copy) NSString* createrDepartId;
@property (nonatomic,copy) NSString* createrDepartment;
@property (nonatomic,copy) NSString* createrName;
@property (nonatomic,copy) NSString* isReply;
@property (nonatomic,copy) NSString* liaisonBookCode;
@property (nonatomic,copy) NSString* liaisonBookContent;
@property (nonatomic,copy) NSString* liaisonBookName;
@property (nonatomic,copy) NSString* liaisonBookTheme;
@property (nonatomic,copy) NSString* objecDepartName;
@property (nonatomic,copy) NSString* objectCompany;
@property (nonatomic,copy) NSString* objectCompanyId;
@property (nonatomic,copy) NSString* objectDepartId;
///被联络人
@property (nonatomic,copy) NSString* objecter;
@property (nonatomic,copy) NSString* objecterName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* timeLimit;
-(NSString*)checkTime;
-(NSString*)checkMessage;
-(NSString*)checkStatus;
@end
