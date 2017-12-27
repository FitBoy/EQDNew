//
//  MutableChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/6/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface MutableChooseViewController : FBBaseViewController
@property (nonatomic,copy) NSString *contentTitle;
@property (nonatomic,strong)  NSIndexPath *indexpath;
@property (nonatomic,weak) id delegate;
@end

@protocol MutableChooseViewControllerDelegate <NSObject>

-(void)contentArr:(NSArray*)arr indexpath:(NSIndexPath*)indexPath;

@end
