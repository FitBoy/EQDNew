//
//  GongZuoQunModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/9.
//  Copyright © 2017年 FitBoy. All rights reserved.
//朋友圈 + 工作圈  2

#import "MoreBaseModel.h"
#import "ZanModel.h"
@interface GongZuoQunModel : MoreBaseModel
///评论数  2
@property (nonatomic,copy) NSString* CommentCount;
@property (nonatomic,copy) NSString* CompanyId;
///2
@property (nonatomic,copy) NSString* CreateTime;
///发布者的Guid; 2
@property (nonatomic,copy) NSString* Creater;
@property (nonatomic,copy) NSString* DepartId;
/// 2
@property (nonatomic,copy) NSString* Id;
///2
@property (nonatomic,copy) NSString* ImageUrls;
///2
@property (nonatomic,copy) NSString* Message;
@property (nonatomic,copy) NSString* PostId;
///点赞人列表 2
@property (nonatomic,strong)  NSArray *UserZan;
/// 2 
@property (nonatomic,copy) NSString* ZanCount;
@property (nonatomic,copy) NSString* com_name;
@property (nonatomic,copy) NSString* departName;
/// 2
@property (nonatomic,copy) NSString* iphoto;
/// 2
@property (nonatomic,copy) NSString* isZan;
///2
@property (nonatomic,copy) NSString* location;
///2
@property (nonatomic,strong)  NSArray *GZQ_newImages;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* staffName;
/// 2
@property (nonatomic,copy) NSString* uname;
///2 昵称
@property (nonatomic,copy) NSString* upname;

///type =1  的链接多出来的字段  来源 “易企阅”

@property (nonatomic,copy) NSString* source;
///链接的标题
@property (nonatomic,copy) NSString* sourceTitle;
/// 链接的url
@property (nonatomic,copy) NSString* sourceUrl;
/// type  0:工作圈 1:网页连接，2：视频，3：音乐，9：广告
@property (nonatomic,copy) NSString* type;

@property (nonatomic,assign) float cellHeight;
-(NSString*)bottom_right0;
-(NSString*)bottom_right1;
-(NSArray*)zan_imgurls;
-(NSString*)head_imgurl;
-(NSString*)left0;
-(NSString*)left1;
-(NSString*)right1;
-(NSString*)contents;
-(NSArray*)imgurls;
-(NSString*)isZan_FB;
-(NSString*)address;
@end
