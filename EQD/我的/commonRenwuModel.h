//
//  commonRenwuModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface commonRenwuModel : FBBaseModel
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* contents;
@property (nonatomic,copy) NSArray* imgurls;
@property (nonatomic,copy) NSString* time;

-(NSString*)left0;
-(NSString*)right0;
-(NSString*)left1;
@end
