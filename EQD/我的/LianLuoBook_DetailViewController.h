//
//  LianLuoBook_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "LianLuoBook_ListModel.h"
@interface LianLuoBook_DetailViewController : FBBaseViewController
@property (nonatomic,strong)  LianLuoBook_ListModel *model;
///1 是审批 其他不是
@property (nonatomic,assign) NSInteger isShenPi;
@end
