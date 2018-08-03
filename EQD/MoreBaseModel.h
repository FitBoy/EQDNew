//
//  MoreBaseModel.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreBaseModel : NSObject
@property (nonatomic,copy) NSString* head_imgurl;
@property (nonatomic,copy) NSString* left0;
@property (nonatomic,copy) NSString* left1;
@property (nonatomic,copy) NSString* right0;
@property (nonatomic,copy) NSString* right1;
@property (nonatomic,copy) NSString* contents;
@property (nonatomic,strong)  NSArray * imgurls;
@property (nonatomic,copy) NSString* bottom_right0;
@property (nonatomic,copy) NSString* bottom_right1;
///有关点赞人的信息model
@property (nonatomic,strong) NSArray *zan_imgurls;
@property (nonatomic,assign) NSString *isZan_FB;

@property (nonatomic,copy) NSString* address;
@property (nonatomic,assign) float cell_height;

@end
