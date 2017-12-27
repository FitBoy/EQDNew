//
//  FanKuiModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface FanKuiModel : FBBaseModel
@property (nonatomic,copy) NSString*  contactWay;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* dealMessage;
@property (nonatomic,copy) NSString* fbackTitle;
@property (nonatomic,copy) NSString* fbackType;
@property (nonatomic,copy) NSString* fbcontent;
@property (nonatomic,copy) NSString* fbpicture;
@property (nonatomic,copy) NSArray* picAddress;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* ID;
-(NSString*)createTime;
@end
