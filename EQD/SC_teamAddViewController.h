//
//  SC_teamAddViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/6/23.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "SC_TeamModel.h"
@interface SC_teamAddViewController : FBBaseViewController
@property (nonatomic,strong)  SC_TeamModel *model_list;

/// 1是荣誉墙
@property (nonatomic,assign)  NSInteger temp;

@end
