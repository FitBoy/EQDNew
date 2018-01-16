//
//  FBShareMessageContent.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 String title;
 String content;
 String url;
 String imgUrl;
 String source;
 String sourceOwner;
 */

#import <RongIMLib/RongIMLib.h>

@interface FBShareMessageContent : RCMessageContent
@property (nonatomic,strong)  NSDictionary *content;
//初始化分享的链接内容
-(instancetype)initWithgeRenCardWithcontent:(NSDictionary*)content;
-(NSData*)encode;
-(void)decodeWithData:(NSData *)data;
+ (NSString *)getObjectName;
-(NSArray <NSString*>*)getSearchableWords;
+ (RCMessagePersistent)persistentFlag;
-(NSString*)conversationDigest;

@end
