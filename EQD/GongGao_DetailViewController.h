//
//  GongGao_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "GongGao_ListModel.h"
@interface GongGao_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  GongGao_ListModel *model;
/// 审批1 其他不是
@property (nonatomic,assign) NSInteger isShenpi;
@end
