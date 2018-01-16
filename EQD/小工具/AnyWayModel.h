//
//  AnyWayModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/15.
//  Copyright © 2018年 FitBoy. All rights reserved.
//
/*
 1 text
 2 img
 3 text + img
 */

#import <Foundation/Foundation.h>

@interface AnyWayModel : NSObject
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* contents;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,assign) float cellHeight;
@end
