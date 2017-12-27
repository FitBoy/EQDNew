//
//  RWD_FuJiamodel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface RWD_FuJiamodel : FBBaseModel
@property (nonatomic,copy) NSString* company;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* departmentId;
@property (nonatomic,copy) NSString* guid;
@property (nonatomic,copy) NSString* headImage;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* nickName;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* postId;
-(NSString*)img_header;
-(NSString*)left0;
-(NSString*)left1;
@end
