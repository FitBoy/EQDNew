//
//  FB_PXLeiBieChooseViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/1/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "FBAddressModel.h"
@interface FB_PXLeiBieChooseViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong) NSArray *arr_chosemodel;
@end
@protocol FB_PXLeiBieChooseViewControllerdelegate <NSObject>
-(void)getTecherLeiBieModel:(NSArray<FBAddressModel*>*)arr_teachers;
@end
