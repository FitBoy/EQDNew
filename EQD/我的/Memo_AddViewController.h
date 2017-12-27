//
//  Memo_AddViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/9/26.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface Memo_AddViewController : FBBaseViewController
@property (nonatomic,copy) NSString* date_selected;
///只有从聊天去转入的时候才有值
@property (nonatomic,copy) NSString*  content;
@end
