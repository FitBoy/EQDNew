//
//  FBTextFieldViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/25.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBTextFieldViewController : FBBaseViewController
@property (nonatomic,copy) NSString* content;
@property (nonatomic,copy) NSString* contentTitle;
@property (nonatomic,copy) NSString* contentTishi;
@property (nonatomic,weak) id delegate;
@property (nonatomic,strong)  NSIndexPath *indexPath;
 @end
@protocol FBTextFieldViewControllerDelegate <NSObject>

-(void)content:(NSString*)content WithindexPath:(NSIndexPath*)indexPath;

@end
