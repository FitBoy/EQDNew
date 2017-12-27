//
//  FBSearchMapViewController.h
//  EQD
//
//  Created by 梁新帅 on 2017/5/22.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBBaseViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface FBSearchMapViewController : FBBaseViewController
@property (nonatomic,weak) id delegate;
@property (nonatomic,assign) CLLocationCoordinate2D  coor2d;
@end
@protocol FBSearchMapViewControllerDelegate <NSObject>

-(void)mapAddress:(NSString*)mapadress  location:(CLLocationCoordinate2D)coor2d;


@end
