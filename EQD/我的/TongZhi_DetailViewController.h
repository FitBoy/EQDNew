//
//  TongZhi_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "GongGao_ListModel.h"
@interface TongZhi_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  GongGao_ListModel *model;
///1 是审批 0是未审批
@property (nonatomic,assign)  NSInteger isShenpi;
@end
