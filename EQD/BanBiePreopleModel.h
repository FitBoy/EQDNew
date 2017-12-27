//
//  BanBiePreopleModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface BanBiePreopleModel : FBBaseModel
@property (nonatomic,copy) NSString* department;
@property (nonatomic,copy) NSString* headimage;
@property (nonatomic,copy) NSString* post;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* usrename;

-(NSString*)left0;
-(NSString*)left1;
-(NSString*)img_header;
@end
