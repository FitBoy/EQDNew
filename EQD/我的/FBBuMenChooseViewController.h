//
//  FBBuMenChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/11/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "GangweiModel.h"

@interface FBBuMenChooseViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,copy) NSString* departId;
@property (nonatomic,copy) NSString* comId;
@end

@protocol FBBuMenChooseViewControllerDelegate <NSObject>
-(void)getGangWei:(GangweiModel*)model;
@end
