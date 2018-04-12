//
//  FBGNHomeModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/16.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface FBGNHomeModel : NSObject
@property (nonatomic,copy) NSString* text;
@property (nonatomic,copy) NSString* icon;
@property (nonatomic,copy) NSString* module;
@property (nonatomic,strong)  NSArray *children;
@property (nonatomic,copy) NSString* number_red;
@end
