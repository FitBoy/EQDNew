//
//  LianLuoBook_SearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/16.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface LianLuoBook_SearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@end
@protocol LianLuoBook_SearchViewControllerDelegate <NSObject>

-(void)lianluoModel:(Com_UserModel*)model  indexpath:(NSIndexPath*)indexPath;

@end
