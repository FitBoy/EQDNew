//
//  FB_friendSearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/9/11.
//  Copyright © 2018年 FitBoy. All rights reserved.
// 好友或者易企点用户的搜索

#import "FBBaseViewController.h"
#import "HaoYouModel.h"
@interface FB_friendSearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_friend;
@end
@protocol FB_friendSearchViewControllerDelegate <NSObject>
-(void)gethaoyouModel:(HaoYouModel*)tmodel;
@end
