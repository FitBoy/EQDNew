//
//  FBContactPeopleViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/10/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
// 获取通讯录里的所有联系人

#import "FBBaseViewController.h"

@interface FBContactPeopleViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@end
@protocol FBContactPeopleViewControllerdelegate<NSObject>
-(void)contactName:(NSString*)name  phone:(NSString*)phone;
@end

