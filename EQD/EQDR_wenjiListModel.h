//
//  EQDR_wenjiListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface EQDR_wenjiListModel : FBBaseModel
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* articleName;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* isdel;
@property (nonatomic,copy) NSString* updateTime;
@property (nonatomic,copy) NSString* updater;
@property (nonatomic,copy) NSString* userGuid;
@end
