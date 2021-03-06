//
//  FBAddressViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBAddressViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,assign) id delegate;
@property (nonatomic,assign) BOOL isXiangXi;
@end
@protocol FBAddressViewControllerDelegate <NSObject>

-(void)address:(NSString*)address Withindexpath:(NSIndexPath*)indexPath arr_address:(NSArray*)arr_address;

@end
