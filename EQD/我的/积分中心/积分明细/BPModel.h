//
//  BPModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/11/10.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BPModel : NSObject
@property (nonatomic,copy) NSString* createTime;
///获得的积分
@property (nonatomic,copy) NSString* credit;
/// 操作
@property (nonatomic,copy) NSString* operation;
///备注
@property (nonatomic,copy) NSString* remark;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* userGuid;
-(NSString*)createTime;
@end

NS_ASSUME_NONNULL_END
