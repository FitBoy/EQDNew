//
//  Car_managerOnlyViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/2.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "CarManagerModel.h"
@interface Car_managerOnlyViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
///是否是选择的需要
@property (nonatomic,assign) NSInteger isChoose;
@end
@protocol Car_managerOnlyViewControllerDelegate <NSObject>
-(void)getCar_managerOnlyModel:(CarManagerModel*)model;
@end
