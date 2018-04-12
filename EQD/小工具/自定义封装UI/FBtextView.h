//
//  FBtextView.h
//  EQD
//
//  Created by 梁新帅 on 2018/3/31.
//  Copyright © 2018年 FitBoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBtextView : UITextView
@property (nonatomic,copy) NSString* placeHoder;
-(void)setPlaceHoder:(NSString *)placeHoder;
@end
