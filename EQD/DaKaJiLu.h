//
//  DaKaJiLu.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface DaKaJiLu : FBBaseModel
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* clockTime;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,copy) NSString* place;
@property (nonatomic,copy) NSString* WIFIName;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* type;
-(NSString*)clockTime;
-(NSString*)createTime;
@end
