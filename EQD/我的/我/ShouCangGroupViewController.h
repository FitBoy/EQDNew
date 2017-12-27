//
//  ShouCangGroupViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "ShouCang_GroupModel.h"
#import "MyShouCangModel.h"
@interface ShouCangGroupViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  MyShouCangModel  *model ;
@end
@protocol ShouCangGroupViewControllerDelegate <NSObject>
-(void)shoucangGroupWithmodel:(ShouCang_GroupModel*)model  shoucang:(MyShouCangModel*)model2;

@end
