//
//  RSCW_baoXiaoModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/19.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSCW_baoXiaoModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* checkName;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* maxMoney;
@property (nonatomic,copy) NSString* minMoney;
@property (nonatomic,copy) NSString* postId;
@property (nonatomic,copy) NSString* postName;
-(NSString*)createTime;
@end
