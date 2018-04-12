//
//  FBShareLinkViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/30.
//  Copyright © 2018年 FitBoy. All rights reserved.
///message sourceUrl imgUrl source type sourceTitle


#import "FBBaseViewController.h"

@interface FBShareLinkViewController : FBBaseViewController
@property (nonatomic,copy) NSString* message;
@property (nonatomic,copy) NSString* sourceUrl;
@property (nonatomic,copy) NSString* imgUrl;
@property (nonatomic,copy) NSString* source;
@property (nonatomic,copy) NSString* type;
@property (nonatomic,copy) NSString* sourceTitle;



@end
