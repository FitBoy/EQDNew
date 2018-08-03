//
//  GZQ_ZanViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface GZQ_ZanViewController : FBBaseViewController
@property (nonatomic,strong)  NSString *cell_id;
/// 1 是日志的点赞 0是工作圈的点赞 2 是任务的点赞的人
@property (nonatomic,assign) NSInteger temp;
@end
