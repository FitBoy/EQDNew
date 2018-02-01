//
//  FBMyErWeiMaViewController.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/3/1.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Com_UserModel.h"
@interface FBMyErWeiMaViewController : UIViewController
// 是个人不必传  不是个人必须传参数 1 
@property (nonatomic,assign) BOOL isOther;
@property (nonatomic,strong)  Com_UserModel *C_user;

@end
