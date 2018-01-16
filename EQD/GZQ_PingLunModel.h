//
//  GZQ_PingLunModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/11.
//  Copyright © 2017年 FitBoy. All rights reserved.
//
/*
 {
 CompanyId = 14;
 CreateTime = "2018-01-16T11:16:37.05";
 Creater = 33c6bdfc281c48c3871d85a2718620e9;
 DepartId = 251;
 Id = 1439;
 Message = 1111111111;
 ParentId = 0;
 PostId = 102;
 WorkCircleId = 3318;
 commentCount = 0;
 departName = "\U7814\U8ba8\U90e8";
 firstId = 0;
 iphoto = "https://www.eqid.top:8009/image/20171118/15286837836/20171118100250headimage.png";
 list =             (
 );
 parentUPname = "";
 parentUserGuid = "";
 postName = "\U8d1f\U8d23\U4eba";
 staffName = "\U6881\U65b0\U5e05";
 upname = Relax;
 }

 */
#import <Foundation/Foundation.h>

@interface GZQ_PingLunModel : NSObject
@property (nonatomic,copy) NSString* CompanyId;
@property (nonatomic,copy) NSString* CreateTime;
@property (nonatomic,copy) NSString* Creater;
@property (nonatomic,copy) NSString* DepartId;
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* Message;
@property (nonatomic,copy) NSString* ParentId;
@property (nonatomic,copy) NSString* PostId;
@property (nonatomic,copy) NSString* WorkCircleId;
//评论数
@property (nonatomic,copy) NSString* commentCount;
@property (nonatomic,copy) NSString* departName;
@property (nonatomic,copy) NSString* firstId;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* parentUPname;
@property (nonatomic,copy) NSString*parentUserGuid;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* staffName;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,assign) float cellHeight;
-(NSString*)CreateTime;
@end
