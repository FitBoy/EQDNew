//
//  TX_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/29.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "TiaoXiu_listModel.h"
@interface TX_DetailViewController : FBBaseViewController
@property (nonatomic,strong) TiaoXiu_listModel *model;
///1 是审批 其他不是审批
@property (nonatomic,assign) NSInteger isShenPi;
///1是人事 其他不是
@property (nonatomic,assign) NSInteger isRenShi;
@end
