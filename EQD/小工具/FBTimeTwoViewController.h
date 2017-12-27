//
//  FBTimeTwoViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBTimeTwoViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexpath;
@property (nonatomic,assign) id delegate;
@property (nonatomic,copy) NSString* contenttitle;
@end
@protocol FBTimeTwoViewControllerDelegate <NSObject>

-(void)timetwo:(NSArray<NSString*>*)timearr indexpath:(NSIndexPath*)indexpath;

@end
