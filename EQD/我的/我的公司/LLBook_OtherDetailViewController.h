//
//  LLBook_OtherDetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//  

#import "FBBaseViewController.h"
#import "LianLuoBook_ListModel.h"
#import "GongGao_ListModel.h"
@interface LLBook_OtherDetailViewController : FBBaseViewController
@property (nonatomic,strong)  LianLuoBook_ListModel *model;
/// 0是联络书  1是通知  2是公告
@property (nonatomic,assign) NSInteger isLianLuoBook;
@property (nonatomic,strong) GongGao_ListModel *model_TG;
@end
