//
//  GongGao_ListViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/14.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface GongGao_ListViewController : FBBaseViewController
/// 1审核人 其他不是 
@property (nonatomic,assign) NSInteger  ischeker;
///通知  公告 通告
@property (nonatomic,copy) NSString* notieName;
@end
