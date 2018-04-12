//
//  DAYaoQingViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "GangweiModel.h"
@interface DAYaoQingViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
@protocol DAYaoQingViewControllerDelegate <NSObject>
-(void)getGangWeiModel:(GangweiModel*)model_gangwei  indexPath:(NSIndexPath*)indexPath;
@end
