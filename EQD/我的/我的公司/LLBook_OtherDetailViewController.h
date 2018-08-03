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

@property (nonatomic,copy) NSString* isShenPi;
@property (nonatomic,strong)  LianLuoBook_ListModel *model;
/// 0是联络书 （model）   2是公告 通知 通告（Id gongwen）
@property (nonatomic,assign) NSInteger isLianLuoBook;
///下面俩
@property (nonatomic,copy)   NSString* Id;
@property (nonatomic,copy) NSString* gongwen;

@end
