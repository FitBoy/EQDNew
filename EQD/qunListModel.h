//
//  qunListModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/6.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface qunListModel : FBBaseModel
@property (nonatomic,copy) NSString* groupid;
@property (nonatomic,copy) NSString* groupname;
@property (nonatomic,copy) NSString* groupphoto;
@property (nonatomic,copy) NSString* type;
///群主
@property (nonatomic,copy) NSString* GroupCreater;
@property (nonatomic,assign) BOOL isChoose;

///群成员数
@property (nonatomic,copy) NSString* MemberCount;
///群创建时间
@property (nonatomic,copy) NSString* CreateTime;
-(NSString*)img_header;
-(NSString*)left0;
@end
