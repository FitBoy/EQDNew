//
//  FGongZuoQuanViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/20.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FGongZuoQuanViewController : FBBaseViewController
///1 是个人空间
@property (nonatomic,assign) NSInteger temp;
/// 要查看的别人的guid
@property (nonatomic,copy) NSString* friendGuid;
@end
