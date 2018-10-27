//
//  ActiveFenLeiViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/10/5.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface ActiveFenLeiViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_class;
@property (nonatomic,strong) NSIndexPath *indexpath;
@end
@protocol ActiveFenLeiViewControllerDelegate <NSObject>
-(void)getClass:(NSString*)className WithIndexPath:(NSIndexPath*)indexPath;
@end
