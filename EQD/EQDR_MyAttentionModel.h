//
//  EQDR_MyAttentionModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EQDR_MyAttentionModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* attention;
@property (nonatomic,copy) NSString* createTime;
///我的关注 creater 是自己   我的粉丝 creater是粉丝
@property (nonatomic,copy) NSString* createriphoto;
@property (nonatomic,copy) NSString*createruname;
@property (nonatomic,copy) NSString* createrupname;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* upname;
@property (nonatomic,copy) NSString* userGuid;

@property (nonatomic,copy) NSString* isguanzhu;

@property (nonatomic,copy) NSString* isAttention;

-(NSString*)createTime;

@end
