//
//  BB_choosebcViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "BanCiModel.h"

@interface BB_choosebcViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
@protocol BB_choosebcViewControllerDelegate <NSObject>

-(void)banciModel:(BanCiModel*)model indexPath:(NSIndexPath*)indexPath;

@end
