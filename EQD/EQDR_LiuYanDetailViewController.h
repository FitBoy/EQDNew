//
//  EQDR_LiuYanDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//  易企阅文章的评论

#import "FBBaseViewController.h"
#import "EQDR_pingLunModel.h"
#import "EQDM_PingLunModel.h"
@interface EQDR_LiuYanDetailViewController : FBBaseViewController
///易企阅的评论
@property (nonatomic,strong)  EQDR_pingLunModel  *model;
///易企创的评论
@property (nonatomic,strong)  EQDM_PingLunModel *model_Eqdm;
/// 1 是易企创
@property (nonatomic,assign) NSInteger temp;

@end
