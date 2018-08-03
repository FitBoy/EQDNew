//
//  FB_twoTongShi2ViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/7.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FB_twoTongShi2ViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_tongshiDan;
@property (nonatomic,strong) NSIndexPath *indexPath;
@end
@protocol FB_twoTongShi2ViewControllerDelegate <NSObject>
-(void)getComUserModel:(Com_UserModel*)model_com indexpath:(NSIndexPath*)indexPath;
@end
