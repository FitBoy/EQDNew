//
//  YSDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/3.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "RenWuListModel.h"
@interface YSDetailViewController : FBBaseViewController
@property (nonatomic,strong)  RenWuListModel *model;
////NO是验收 其他不是
@property (nonatomic,assign) BOOL isyanshou;
@end
