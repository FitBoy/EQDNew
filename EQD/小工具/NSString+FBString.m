//
//  NSString+FBString.m
//  YiQiDian
//
//  Created by 梁新帅 on 2017/2/10.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "NSString+FBString.h"
#import <ImageIO/ImageIO.h>
#import <RongIMKit/RongIMKit.h>
#import "CalendarModel.h"
@implementation NSString (FBString)

#pragma mark - 正则相关
 - (BOOL)isValidateByRegex:(NSString *)regex{
        NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pre evaluateWithObject:self];
    }
//手机号分服务商
 - (BOOL)isMobileNumberClassification{
         /**
            15      * 手机号码
            16      * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188,1705
            17      * 联通：130,131,132,152,155,156,185,186,1709
            18      * 电信：133,1349,153,180,189,1700
            19      */
       //    NSString * MOBILE = @"^1((3//d|5[0-35-9]|8[025-9])//d|70[059])\\d{7}$";//总况
    
         /**
            23      10         * 中国移动：China Mobile
            24      11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188，1705
            25      12         */
         NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d|705)\\d{7}$";
         /**
            28      15         * 中国联通：China Unicom
            29      16         * 130,131,132,152,155,156,185,186,1709
            30      17         */
        NSString * CU = @"^1((3[0-2]|5[256]|8[56])\\d|709)\\d{7}$";
        /**
            33      20         * 中国电信：China Telecom
            34      21         * 133,1349,153,180,189,1700
            35      22         */
         NSString * CT = @"^1((33|53|8[09])\\d|349|700)\\d{7}$";
    
   
       /**
            40      25         * 大陆地区固话及小灵通
            41      26         * 区号：010,020,021,022,023,024,025,027,028,029
            42      27         * 号码：七位或八位
            43      28         */
         NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    
         //    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
         if (([self isValidateByRegex:CM])
                        || ([self isValidateByRegex:CU])
                        || ([self isValidateByRegex:CT])
                        || ([self isValidateByRegex:PHS]))
             {
                return YES;
                 }
         else
             {
                     return NO;
                 }
     }

 //手机号有效性
 - (BOOL)isMobileNumber{
         /**
            65      *  手机号以13、15、18、170开头，8个 \d 数字字符
            66      *  小灵通 区号：010,020,021,022,023,024,025,027,028,029 还有未设置的新区号xxx
            67      */
         NSString *mobileNoRegex = @"^1((3\\d|5[0-35-9]|8[025-9])\\d|70[059])\\d{7}$";//除4以外的所有个位整数，不能使用[^4,\\d]匹配，这里是否iOS Bug?
         NSString *phsRegex =@"^0(10|2[0-57-9]|\\d{3})\\d{7,8}$";
     
         BOOL ret = [self isValidateByRegex:mobileNoRegex];
         BOOL ret1 = [self isValidateByRegex:phsRegex];
     
         return (ret || ret1);
     }


- (BOOL)judgeIdentityStringValid{
    
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


-(BOOL)isValidateEmail

{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
    
}
-(NSString*)birthdayFromShenfenCard{
    
    NSString *tstr =[self substringWithRange:NSMakeRange(6, 8)];
    NSString *year = [tstr substringWithRange:NSMakeRange(0, 4)];
    NSString *month = [tstr substringWithRange:NSMakeRange(4, 2)];
    NSString *day = [tstr substringWithRange:NSMakeRange(6, 2)];
    NSString *birthday =[NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    return birthday;
}
-(NSString*)sexFromshenfenCard{
    
    NSString *tstr =[self substringWithRange:NSMakeRange(16, 1)];
    NSInteger num =[tstr integerValue]%2;
    if (num>0) {
        return @"男";
    }
    else{
        return @"女";
    }
}

-(NSString*)ageFromshenfenCard{
    NSString *tstr = [self substringWithRange:NSMakeRange(6, 4)];
    NSDate *date =[NSDate date];
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    NSString *str1 = [formatter stringFromDate:date];
    NSInteger age = [tstr integerValue]-[str1 integerValue];
    return [NSString stringWithFormat:@"%ld",(long)age];
    
}

-(NSString*)formatDateString
{
    NSString *tstr =[self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *tstr2= [tstr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSArray *tarr =[tstr2 componentsSeparatedByString:@"."];
    NSString *tstr3 =tarr[0];
    NSArray *tarr2 =[tstr3 componentsSeparatedByString:@":"];
    NSString *tstr4 =[NSString stringWithFormat:@"%@:%@",tarr2[0],tarr2[1]];
    
    
    return tstr4;
    
}

-(NSString*)formatdateYearMonth
{
    NSString *tstr =[self stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    NSString *tstr2= [tstr stringByReplacingOccurrencesOfString:@"/" withString:@"-"];
    NSArray *tarr =[tstr2 componentsSeparatedByString:@" "];
   
    return tarr[0];
}
// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}

+ (CGSize)getImageSizeWithURL2:(id)URL{
    NSURL * url = nil;
    if ([URL isKindOfClass:[NSURL class]]) {
        url = URL;
    }
    if ([URL isKindOfClass:[NSString class]]) {
        url = [NSURL URLWithString:URL];
    }
    if (!URL) {
        return CGSizeZero;
    }
    CGImageSourceRef imageSourceRef =     CGImageSourceCreateWithURL((CFURLRef)url, NULL);
    CGFloat width = 0, height = 0;
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, NULL);
        if (imageProperties != NULL) {
            CFNumberRef widthNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelWidth);
            if (widthNumberRef != NULL) {
                CFNumberGetValue(widthNumberRef, kCFNumberFloat64Type, &width);
            }
            CFNumberRef heightNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyPixelHeight);
            if (heightNumberRef != NULL) {
                CFNumberGetValue(heightNumberRef, kCFNumberFloat64Type, &height);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return CGSizeMake(width, height);
}

/**
 * 网址正则验证 1或者2使用哪个都可以
 *
 *  @param string 要验证的字符串
 *
 *  @return 返回值类型为BOOL
 */
- (BOOL)urlValidation{
    NSError *error;
    // 正则1
    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";
    // 正则2
    regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                                                          options:NSRegularExpressionCaseInsensitive
                                                                            error:&error];
    NSArray *arrayOfAllMatches = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    
    for (NSTextCheckingResult *match in arrayOfAllMatches){
        NSString* substringForMatch = [self substringWithRange:match.range];
      
        return YES;
    }
    return NO;
}
+(BOOL) deptNumInputShouldNumber:(NSString*)str
{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

-(BOOL)zhanghaoJudge
{
    NSString *match = @"^[a-zA-Z][a-zA-Z0-9_]{4,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

-(NSString*)datefromDatestring
{
    NSDateFormatter *formatter =[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *tstr =[self formatDateString];
    
    NSDate *date =[formatter dateFromString:tstr];
    
  return   [RCKitUtility ConvertChatMessageTime:date.timeIntervalSince1970];
    
}
-(CGSize)getsizefromURL
{
    NSUserDefaults *userd = [NSUserDefaults standardUserDefaults];
    NSString *str_size =[userd objectForKey:self];
    if(str_size==nil)
    {
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:self]];
    UIImage *image =[[UIImage alloc]initWithData:data];
    if(image!=nil)
    {
        NSString *tstr = [NSString stringWithFormat:@"%f,%f",image.size.width,image.size.height];
        
        [userd setObject:tstr forKey:self];
        [userd synchronize];
        return image.size;
    }
    else
    {
        [userd setObject:@"100,100" forKey:self];
        [userd synchronize];
        return CGSizeMake(100, 100);
    }
    }else
    {
        NSArray *tarr = [str_size componentsSeparatedByString:@","];
        return CGSizeMake([tarr[0] floatValue], [tarr[1] floatValue]);
    }
   
}

+(float)day_numberWithdate1:(NSDate*)date1 date2:(NSDate*)date2  Withweeks:(NSArray*)weekArr
{
//    NSArray *weeks =[NSString weeksWithArr:weekArr];
    NSTimeInterval time =[date2 timeIntervalSinceDate:date1];
    NSInteger hour =time/(60*60);
    float day =hour/24;
    if (time<0) {
        return 0;
    }
    
    else
    {
        
//    for (int i=0; i<time; i=i+24*60*60) {
//        NSDate *date3=[date1 dateByAddingTimeInterval:i];
//        CalendarModel *model =[[CalendarModel alloc]initWithDate:date3];
//        if (![weeks containsObject:[NSString stringWithFormat:@"%ld",model.weekday]]) {
//            day=day-1;
//        }
//    }
    
    if (hour%24>0) {
        if (hour%24>4) {
            day=day+1;
        }
        else
        {
            day =day+0.5;
        }
    }
    return day;
    }
}

+(float)hourWithDate1:(NSDate*)date1 date2:(NSDate*)date2
{
    NSTimeInterval time =[date2 timeIntervalSinceDate:date1];
    float min =time/60.0;
    float hour =min/60.0;
    return hour;
}
+(NSArray*)weeksWithArr:(NSArray*)weekArr
{
    NSMutableArray *weeks =[NSMutableArray arrayWithCapacity:0];
    if ([weekArr containsObject:@"星期一"]) {
        [weeks addObject:@"2"];
    }
    if ([weekArr containsObject:@"星期二"]) {
        [weeks addObject:@"3"];
    }
    if ([weekArr containsObject:@"星期三"]) {
        [weeks addObject:@"4"];
    }
    if ([weekArr containsObject:@"星期四"]) {
        [weeks addObject:@"5"];
    }
    if ([weekArr containsObject:@"星期五"]) {
        [weeks addObject:@"6"];
    }
    if ([weekArr containsObject:@"星期六"]) {
        [weeks addObject:@"7"];
    }
    if ([weekArr containsObject:@"星期日"]) {
        [weeks addObject:@"1"];
    }
    return weeks;
}
-(NSString*)formatDateStringWithoutYear
{
    NSString *tstr =[self formatDateString];
    return  [tstr substringWithRange:NSMakeRange(5, 11)];
   
}

//判断是否银行卡
+ (BOOL) checkCardNo:(NSString*) cardNo{
    int oddsum = 0;    //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength -1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1,1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) ==0)
        return YES;
    else
        return NO;
}

+(NSString *)returnBankName:(NSString*) idCard{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bank" ofType:@"plist"];
    
    NSDictionary* resultDic = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    
    NSArray *bankName = [resultDic objectForKey:@"bankName"];
    
    NSArray *bankBin = [resultDic objectForKey:@"bankBin"];
    
    int index = -1;
    
    if(idCard==nil || idCard.length<16 || idCard.length>19){
        
        return @"";
        
    }
    
    //6位Bin号
    
    NSString* cardbin_6 = [idCard substringWithRange:NSMakeRange(0, 6)];
    
    for (int i = 0; i < bankBin.count; i++) {
        
        if ([cardbin_6 isEqualToString:bankBin[i]]) {
            
            index = i;
            
        }
        
    }
    
    if (index != -1) {
        
        return bankName[index];
        
    }
    
    //8位Bin号
    
    NSString* cardbin_8 = [idCard substringWithRange:NSMakeRange(0, 8)];
    
    for (int i = 0; i < bankBin.count; i++) {
        
        if ([cardbin_8 isEqualToString:bankBin[i]]) {
            
            index = i;
            
        }
        
    }
    
    if (index != -1) {
        
        return bankName[index];
        
    }
    
    return @"";
    
}

+(NSString*)numberWithStr:(NSString*)str
{
    NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *tstr=[str stringByTrimmingCharactersInSet:nonDigits];
    if (tstr.length==0) {
      return @"0";
    }else
    {
        return tstr;
    }
}



@end
