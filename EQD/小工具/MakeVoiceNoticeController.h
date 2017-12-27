//
//  MakeVoiceNoticeController.h
//  kyExpress_Internal
//
//  Created by iOS_Chris on 16/7/7.
//  Copyright © 2016年 kyExpress. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MakeVoiceNoticeController : UIViewController
@property (nonatomic,weak) id delegate;
@end
@protocol MakeVoiceNoticeControllerDelegate <NSObject>
///获取mp3格式的音频
-(void)getvoiceData:(NSData*)data  time:(NSString*)time;
@end
