//
//  FBTextVViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/24.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBTextVViewController : FBBaseViewController
@property (nonatomic,copy) NSString* S_maxnum;
@property (nonatomic,strong)  NSIndexPath *indexpath;
@property (nonatomic,assign) id delegate;
@property (nonatomic,copy) NSString* contentTitle;
@property (nonatomic,copy) NSString* content;
@end
@protocol FBTextVViewControllerDelegate <NSObject>

-(void)textVtext:(NSString*)text indexPath:(NSIndexPath*)indexPath;

@end
