//
//  TimeChild.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeChild : NSObject
@property (nonatomic,copy) NSString* time;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* time_type;
-(NSString*)time_type;
@end
