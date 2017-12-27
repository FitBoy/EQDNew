//
//  FQSearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/6/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
@interface FQSearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;

@end
@protocol FQSearchViewControllerDelegate <NSObject>

-(void)Com_userModel:(Com_UserModel*)model;

@end

