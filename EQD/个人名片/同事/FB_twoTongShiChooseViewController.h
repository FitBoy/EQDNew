//
//  FB_twoTongShiChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "Com_UserModel.h"
@interface FB_twoTongShiChooseViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_tongshi;
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,strong) NSArray *arr_guid;
@end
@protocol FB_twoTongShiChooseViewControllerDelegate <NSObject>
-(void)getChooseArr_model:(NSArray*)arr_tmodel indexpath:(NSIndexPath*)indexpath;
@end
