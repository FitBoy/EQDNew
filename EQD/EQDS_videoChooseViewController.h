//
//  EQDS_videoChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface EQDS_videoChooseViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@end
@protocol EQDS_videoChooseViewControllerDelegate <NSObject>
-(void)getVideoArr:(NSArray*)arr_Video;
@end
