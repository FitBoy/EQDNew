//
//  FB_MyPXSQ_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/6.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FB_MyPXSQ_DetailViewController : FBBaseViewController
@property (nonatomic,copy) NSString*  ID;
/// 1 是人事审批  2是领导审批  其他是0
@property (nonatomic,assign) NSInteger isRenshi;
@end
