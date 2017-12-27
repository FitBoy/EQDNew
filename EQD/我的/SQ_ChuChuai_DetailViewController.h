//
//  SQ_ChuChuai_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "ChuChai_ListModel.h"
@interface SQ_ChuChuai_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  ChuChai_ListModel *model;
///1是审批 其他不是
@property (nonatomic,assign) NSInteger isShenPi;
/// 1是人事 其他不是
@property (nonatomic,assign) NSInteger isRenShi;
@end
