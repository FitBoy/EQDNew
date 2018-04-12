//
//  TrueBrthdayViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface TrueBrthdayViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexpath;
//@property (nonatomic,copy) NSString* content;
@property (nonatomic,weak) id delegate;
@end
@protocol TrueBrthdayViewControllerDelegate <NSObject>

-(void)birthDayWithcontent:(NSString*)content indexPath:(NSIndexPath*)indexpath;


@end
