//
//  CardChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "qunListModel.h"
@interface CardChooseViewController : FBBaseViewController
///群id 或者用户id
@property (nonatomic,strong) NSString* userGuid;
@property (nonatomic,assign) BOOL isQun;

@end
