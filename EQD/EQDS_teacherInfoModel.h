//
//  EQDS_teacherInfoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDS_teacherInfoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* LecturerBackground;
@property (nonatomic,copy) NSString* PersonalProfile;
@property (nonatomic,copy) NSString* ResearchField;
@property (nonatomic,copy) NSString* WorkingMethod;
@property (nonatomic,copy) NSString* city;
@property (nonatomic,copy) NSString* courses;
@property (nonatomic,copy) NSString* headimage;
@property (nonatomic,copy) NSString* realname;
@property (nonatomic,copy) NSString* realName;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* sex;
@property (nonatomic,copy) NSString* address;
@property (nonatomic,copy) NSString* TradeCount;
@property (nonatomic,copy) NSString* browCount;
@property (nonatomic,copy) NSString* companyId;
@property (nonatomic,assign) float cellHeight;

@property (nonatomic,copy) NSString* CooperativePrice;
/*
 搜索到的讲师
 {
 CooperativePrice = 20000;
 Id = 64;
 LecturerBackground = "<p><img src=\"https://www.eqid.top:8009/image/20180223/upload/18022315331019127.png\" style=\"max-width:100%;\"><br></p><p>\U7535\U996d\U9505</p>";
 ResearchField = "\U6536\U6b3e\U6280\U5de7,\U6e20\U9053\U9500\U552e";
 WorkingMethod = "";
 city = "\U9f99\U5ca9\U5e02";
 courses = "\U963f\U8428\U5fb7";
 headimage = "https://www.eqid.top:8009/image/20180228/2018022809055339735.png";
 realname = "\U6881\U65b0\U5e05";
 userGuid = 33c6bdfc281c48c3871d85a2718620e9;
 }
 
 最新搜索到的讲师
 
 {
 CooperativePrice = 20000;
 ResearchField = "\U5f15\U5bfc\U6280\U672f,\U5173\U952e\U5ba2\U6237,\U62db\U6295\U6807";
 TradeCount = 0;
 address = "\U6cb3\U5357\U7701\U5b89\U9633\U5e02\U6797\U5dde\U5e02\U54c8\U54c8\U54c8";
 browCount = 1;
 companyId = 46;
 courses = "\U793e\U4f1a\U4e0e\U6cd5";
 creatTime = "2018/4/27 15:19:06";
 headimage = "http://47.94.173.253:8008/image/20180907/2018090717035492470.png";
 realName = "\U90ed\U660a\U539f";
 sex = "\U7537";
 userGuid = a7bdb62145b349b99c9d74f0deb516f9;
 }
 
 
 */
@end
