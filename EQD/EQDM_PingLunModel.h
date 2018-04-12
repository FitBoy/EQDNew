//
//  EQDM_PingLunModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/29.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDM_PingLunModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* commentContext;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* lowerCount;
@property (nonatomic,copy) NSString* praiseCount;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* userName;
@property (nonatomic,strong) NSArray *SonCmets;
@property (nonatomic,copy) NSString* isPraised;
@property (nonatomic,copy) NSString* articleId;
@property (nonatomic,copy) NSString* beClosed;
-(NSString*)createTime;
@property (nonatomic,assign) float cellHeight;

@property (nonatomic,copy) NSString* upCmetContext;
@property (nonatomic,copy) NSString* upCmetCreateTime;
@property (nonatomic,copy) NSString* upCmetUserGuid;
@property (nonatomic,copy) NSString* upCmetUserName;

@end
