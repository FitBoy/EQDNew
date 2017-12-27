//
//  Bumen_MutableViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/11/7.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBPeople.h"
#import "ZuZhiModel.h"
@interface Bumen_MutableViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSArray *arr_bumen;
@end
@protocol Bumen_MutableViewControllerDelegate <NSObject>
-(void)bumenArr:(NSArray*)arr;
@end
