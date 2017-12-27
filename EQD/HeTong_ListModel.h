//
//  HeTong_ListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/8.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface HeTong_ListModel : FBBaseModel
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* contractCode;
@property (nonatomic,copy) NSString* signatory;
@property (nonatomic,copy) NSString* creater;
@property (nonatomic,copy) NSString* createTime;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right0;
-(NSString*)right1;
@end
