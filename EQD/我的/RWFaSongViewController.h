//
//  RWFaSongViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface RWFaSongViewController : FBBaseViewController
// 1 是聊天过来的  其他的不是  2是聊天的内容
@property (nonatomic,assign) NSInteger isChat;
@property (nonatomic,copy) NSString* userGuid;
@property (nonatomic,copy) NSString* name;

///聊天的内容
@property (nonatomic,copy) NSString* content;
@end
