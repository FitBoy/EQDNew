//
//  NSString+FBString.h
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ImageIO/ImageIO.h>
#import <UIKit/UIKit.h>

@interface NSString (FBString)
///判断是否是手机号
- (BOOL)isMobileNumber;
///判断是否是身份证号
- (BOOL)judgeIdentityStringValid;
///判断是否是邮箱
-(BOOL)isValidateEmail;
///根据身份证号找到生日 返回2016/02/29
-(NSString*)birthdayFromShenfenCard;
///根据身份证判断性别  男 ：YES  女：NO
-(NSString*)sexFromshenfenCard;
///根据身份证号返回年龄
-(NSString*)ageFromshenfenCard;
///根据url返回图片的大小
+(CGSize)getImageSizeWithURL:(id)imageURL;
///根据url返回图片的大小2
+ (CGSize)getImageSizeWithURL2:(id)URL;

///判断字符串是否是url
- (BOOL)urlValidation;
//判断是否是纯数字
+ (BOOL) deptNumInputShouldNumber:(NSString*)str;
///判断是否是纯汉字
- (BOOL)isChinese;

///判断是否含有汉字
- (BOOL)includeChinese;
///(字母开头，允许5-16字节，允许字母数字下划线
-(BOOL)zhanghaoJudge;
///格式化时间 yyyy-MM-dd hh:mm
-(NSString*)formatDateString;
/// 格式化时间  yyyy-MM-dd
-(NSString*)formatdateYearMonth;
///去掉时间的年与秒
-(NSString*)formatDateStringWithoutYear;
///工作圈的时间显示
-(NSString*)datefromDatestring;
///根据url获取图片的长宽
-(CGSize)getsizefromURL;
///以数字返回上班的天数
+(NSArray*)weeksWithArr:(NSArray*)weekArr;
///返回两天的时间差
+(float)day_numberWithdate1:(NSDate*)date1 date2:(NSDate*)date2 Withweeks:(NSArray*)weekArr;
+(float)hourWithDate1:(NSDate*)date1 date2:(NSDate*)date2;
///判断银行卡号是否合法
+ (BOOL) checkCardNo:(NSString*) cardNo;
///根据银行卡号返回银行
+(NSString *)returnBankName:(NSString*) idCard;
///返回其中的数字
+(NSString*)numberWithStr:(NSString*)str;

@end
