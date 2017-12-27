//
//  RenWuSearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/31.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "Search_rewuModel.h"

@interface RenWuSearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end
@protocol RenWuSearchViewControllerDelegate <NSObject>

-(void)searchRenwumodel:(Search_rewuModel*)model indexpath:(NSIndexPath*)indexPath;


@end
