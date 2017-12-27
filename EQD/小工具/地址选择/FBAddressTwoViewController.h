//
//  FBAddressTwoViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/7/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBAddressTwoViewController : FBBaseViewController
@property (nonatomic,strong) NSIndexPath *indexPath;
@property (nonatomic,weak) id delegate;
@end
@protocol FBAddressTwoViewControllerDelegate <NSObject>

-(void)address2:(NSString*)address indexPath:(NSIndexPath*)indexpath arr_address:(NSArray*)arr_address;

@end
