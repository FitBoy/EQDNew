//
//  BB_List_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "BanbieModel.h"
@interface BB_List_DetailViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end
@protocol BB_List_DetailViewControllerDelegate <NSObject>

-(void)model:(BanbieModel*)model  indexPath:(NSIndexPath*)indexPath;

@end
