//
//  Meeting_addViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/5/22.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface Meeting_addViewController : FBBaseViewController
/// 1 是会议通知   0是会议设置   2  是会议设置的详情
@property (nonatomic,assign)NSInteger temp;
@property (nonatomic,copy) NSString *settingId;
@end
