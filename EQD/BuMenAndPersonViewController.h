//
//  BuMenAndPersonViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "Com_UserModel.h"

@interface BuMenAndPersonViewController : FBBaseViewController
@property (nonatomic,weak) id  delegate_person;
@end
@protocol BuMenAndPersonViewControllerDelegate <NSObject>
-(void)getComModel:(Com_UserModel*)model_com;
@end
