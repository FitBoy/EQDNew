//
//  EQDR_MyWenJiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/12/13.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import "EQDR_wenjiListModel.h"

@interface EQDR_MyWenJiViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;

@end
@protocol EQDR_MyWenJiViewControllerDelegate <NSObject>
-(void)getWenjiModel:(EQDR_wenjiListModel*)wenjiModel;
@end
