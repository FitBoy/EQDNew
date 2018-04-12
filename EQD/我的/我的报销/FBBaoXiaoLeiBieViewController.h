//
//  FBBaoXiaoLeiBieViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/20.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "OptionModel.h"

@interface FBBaoXiaoLeiBieViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end
@protocol FBBaoXiaoLeiBieViewControllerDelegate <NSObject>
-(void)getBaoXiaoLeiBieModel:(OptionModel*)model_baoxiao indexPath:(NSIndexPath*)indexPath;
@end
