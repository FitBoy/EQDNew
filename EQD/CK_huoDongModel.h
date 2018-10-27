//
//  CK_huoDongModel.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/9.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CK_huoDongModel : NSObject
@property (nonatomic,copy) NSString* Id;
@property (nonatomic,copy) NSString* activeImg;
@property (nonatomic,copy) NSString* activeTitle;
@property (nonatomic,copy) NSString* activeCity;
@property (nonatomic,copy) NSString*pageView;
@property (nonatomic,copy) NSString* regCount;
@property (nonatomic,copy) NSString* price;
@property (nonatomic,copy) NSString* activeStartTime;
@property (nonatomic,copy) NSString* activer;
@property (nonatomic,copy) NSString* status;
@property (nonatomic,copy) NSString* createTime;
@property (nonatomic,assign)  float cellHeight;

-(NSString*)createTime;
@end
