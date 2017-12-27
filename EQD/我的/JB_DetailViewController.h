//
//  JB_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/30.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "JiaBan_ListModel.h"
@interface JB_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  JiaBan_ListModel *model;
///1 是审批 其他不是
@property (nonatomic,assign) NSInteger isShenPi;
/// 1是人事 其他不适
@property (nonatomic,assign) NSInteger isRenShi;
@end
