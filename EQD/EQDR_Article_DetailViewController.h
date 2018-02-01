//
//  EQDR_Article_DetailViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/19.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
typedef NS_ENUM(NSInteger, EQDArticle_type) {
    EQDArticle_typeRead =0,//易企阅
    EQDArticle_typeMade  // 易企创
};
@interface EQDR_Article_DetailViewController : FBBaseViewController
@property (nonatomic,copy) NSString* articleId;

///0易企阅 1 易企创
@property (nonatomic,assign) NSInteger temp;
@end
