//
//  GLLianXiRenViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/23.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "LXRAddViewController.h"
#import "GLLianXiModel.h"
@interface GLLianXiRenViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
///1 是用的协议代理
@property (nonatomic,assign) NSInteger ischoose;
@end
@protocol  GLLianXiRenViewControllerdelegate <NSObject>
-(void)lianxiModel:(GLLianXiModel*)model;
@end
