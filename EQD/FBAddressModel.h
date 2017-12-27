//
//  FBAddressModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBAddressModel : NSObject
@property (nonatomic,copy) NSString* name;
@property (nonatomic,copy) NSString* code;
@property (nonatomic,strong) NSArray *sub;
@property (nonatomic,copy) NSString* qucode;
@end
