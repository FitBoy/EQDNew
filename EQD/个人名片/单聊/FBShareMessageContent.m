//
//  FBShareMessageContent.m
//  EQD
//
//  Created by 梁新帅 on 2018/1/8.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBShareMessageContent.h"

@implementation FBShareMessageContent
-(instancetype)initWithgeRenCardWithcontent:(NSDictionary*)content
{
    if (self =[super init]) {
        
        self.content =content;
        
    }
    return self;
    
}

/// NSCoding
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.content = [aDecoder decodeObjectForKey:@"content"];
    }
    return self;
}

/// NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.content forKey:@"content"];
}


-(NSData*)encode
{
    NSMutableDictionary *datadic =[NSMutableDictionary dictionary];
    [datadic setObject:self.content forKey:@"content"];
    if (self.senderUserInfo) {
        NSMutableDictionary *userInfoDic = [[NSMutableDictionary alloc] init];
        if (self.senderUserInfo.name) {
            [userInfoDic setObject:self.senderUserInfo.name
                 forKeyedSubscript:@"name"];
        }
        if (self.senderUserInfo.portraitUri) {
            [userInfoDic setObject:self.senderUserInfo.portraitUri
                 forKeyedSubscript:@"icon"];
        }
        if (self.senderUserInfo.userId) {
            [userInfoDic setObject:self.senderUserInfo.userId
                 forKeyedSubscript:@"id"];
        }
        [datadic setObject:userInfoDic forKey:@"user"];
    }
    
    return  [NSJSONSerialization dataWithJSONObject:datadic options:NSJSONWritingPrettyPrinted error:nil];
}

-(void)decodeWithData:(NSData *)data{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"dic==%@",dic);
    self.content=dic[@"content"];
    NSDictionary *userinfoDic = dic[@"user"];
    [self decodeUserInfo:userinfoDic];
    
}



+ (NSString *)getObjectName
{
    return @"EQD:lk";
    
}
-(NSString*)conversationDigest
{
    return @"易企点平台的链接";
}
-(NSArray <NSString*>*)getSearchableWords
{
    return @[@"易企点平台的链接"];
}
+ (RCMessagePersistent)persistentFlag
{
    return  MessagePersistent_ISPERSISTED| MessagePersistent_ISCOUNTED;
}
@end
