//
//  FBImgViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/4/21.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

@interface FBImgViewController : FBBaseViewController
@property (nonatomic,strong)  NSIndexPath *indexPath;
@property (nonatomic,copy) NSString* contentTitle;
@property (nonatomic,copy) NSString* content;
@property (nonatomic,strong)  UIImage *image;
@property (nonatomic,assign) NSInteger flag;
@property (nonatomic,assign) id delegate;
@end
@protocol FBImgViewControllerDelegate <NSObject>

-(void)img:(UIImage*)img flag:(NSInteger)flag  indexPath:(NSIndexPath*)indexPath;

@end
