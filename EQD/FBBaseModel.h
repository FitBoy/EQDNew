//
//  FBBaseModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FBBaseModel : NSObject
@property (nonatomic,copy) NSString* left0;
@property (nonatomic,copy) NSString* left1;
@property (nonatomic,copy) NSString* right0;
@property (nonatomic,copy) NSString* right1;
///头像的地址
@property (nonatomic,copy) NSString* img_header;
///是否被选中
@property (nonatomic,assign) BOOL ischoose;

@end
