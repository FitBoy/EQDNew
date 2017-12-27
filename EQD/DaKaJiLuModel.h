//
//  DaKaJiLuModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DaKaJiLu.h"
@interface DaKaJiLuModel : NSObject
@property (nonatomic,copy) NSString* date;
@property (nonatomic,strong)  NSArray *list;
-(NSString*)date;
@end
