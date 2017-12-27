//
//  FBGeRenCardMessageContent.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <RongIMLib/RongIMLib.h>

@interface FBGeRenCardMessageContent : RCMessageContent
/**
 dic2 = @{
 @"imgurl":model.iphoto,
 @"name":model.pname,
 @"bumen":dic1[@"postname"],
 @"gangwei":dic1[@"careername"],
 @"company":@"公司名称",
 @"uid":model.uname,
 @"comid":dic1[@"cid"]
 */
@property (nonatomic,strong)  NSDictionary *content;
//初始化个人名片内容
-(instancetype)initWithgeRenCardWithcontent:(NSDictionary*)content;
-(NSData*)encode;
-(void)decodeWithData:(NSData *)data;
+ (NSString *)getObjectName;
-(NSArray <NSString*>*)getSearchableWords;
+ (RCMessagePersistent)persistentFlag;
-(NSString*)conversationDigest;
- (NSArray<NSString *> *)getSearchableWords;
@end
