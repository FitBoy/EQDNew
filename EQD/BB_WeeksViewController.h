//
//  BB_WeeksViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/8/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface BB_WeeksViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,strong)  NSArray *arr_names;
///为了设置初始选中的是哪些
@property (nonatomic,strong)  NSMutableArray *arr_contents;
@end
@protocol BB_WeeksViewControllerDelegate <NSObject>

-(void)chooseArr:(NSArray*)tarr indexPath:(NSIndexPath*)indexPath;

@end
