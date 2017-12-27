//
//  HaoYouModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/4.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseModel.h"

@interface HaoYouModel : FBBaseModel
@property (nonatomic,copy) NSString* Guid;
@property (nonatomic,copy) NSString* uname;
@property (nonatomic,copy) NSString* iphoto;
@property (nonatomic,copy) NSString* upname;
-(NSString*)img_header;
-(NSString*)left0;
@end
