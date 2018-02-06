//
//  PXKaoQinListModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/2/2.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PXKaoQinListModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* absentCause;
@property (nonatomic,copy) NSString* depName;
@property (nonatomic,copy) NSString* postName;
@property (nonatomic,copy) NSString* signInTime;
///-2 未签到 -1迟到  1 正常
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* userName;
-(NSString*)signInTime;
@end
