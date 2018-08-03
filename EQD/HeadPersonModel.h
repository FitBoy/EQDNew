//
//  HeadPersonModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/25.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeadPersonModel : NSObject
@property (nonatomic,copy) NSString* headImage;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* username;

///通知详情
@property (nonatomic,copy) NSString* guid;
@property (nonatomic,copy) NSString* depName;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* realName;
@end
