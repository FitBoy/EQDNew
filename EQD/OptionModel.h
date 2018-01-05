//
//  OptionModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OptionModel : NSObject
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* ID;
@property (nonatomic,assign) BOOL  isChoose;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,assign) float cellHeight;
@end
