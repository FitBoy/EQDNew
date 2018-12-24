//
//  FBBaseSearchViewController.h
//  EQD
//
//  Created by 梁新帅 on 2018/12/13.
//  Copyright © 2018 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FBBaseSearchViewController : FBBaseViewController
@property (nonatomic,weak) id delegate_search;

@end

@protocol FBBaseSearchViewControllerDelegate <NSObject>

-(void)getSearchKey:(NSString*)searchKey;

@end

NS_ASSUME_NONNULL_END
