//
//  QJ_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "QingJiaListModel.h"
@interface QJ_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  QingJiaListModel *model;
///1 表示审批  0 表示未审批
@property (nonatomic,assign) NSInteger isshenpi;
@property (nonatomic,assign) NSInteger isRenShi;
@end
