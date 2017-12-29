//
//  WebRequest.m
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "WebRequest.h"

@implementation WebRequest

+(UserModel*)GetUserInfo{
    NSDictionary *dic = [USERDEFAULTS objectForKey:Y_USERINFO];
    return [UserModel mj_objectWithKeyValues:dic];
}
+(void)EQDimages_Get_EQDimageAnd:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@EQDimages/Get_EQDimage.ashx",HTTP_HEAD];
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(BOOL)updateUserinfoWithKey:(NSString*)key value:(NSString*)value
{
    NSDictionary *dic=[USERDEFAULTS objectForKey:Y_USERINFO];
    NSMutableDictionary  *dic2=[NSMutableDictionary dictionaryWithDictionary:dic];
    [dic2 setObject:value forKey:key];
    [USERDEFAULTS setObject:dic2 forKey:Y_USERINFO];
    return [USERDEFAULTS synchronize];
}
+ (NSString *)sha1:(NSString *)inputString{
    NSData *data = [inputString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes,(unsigned int)data.length,digest);
    NSMutableString *outputString = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [outputString appendFormat:@"%02x",digest[i]];
    }
    return [outputString lowercaseString];
}

+(void)user_loginWithu1:(NSString*)u1 password:(NSString*)password And:(void(^)(NSDictionary *dic))block{

        NSString *pass1 =[NSString stringWithFormat:@"%@EQD",password];
    NSString *pass= [self sha1:pass1];
    NSString *urlString = [NSString stringWithFormat:@"%@register.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_U1:u1,
                                 Z_password:pass
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)user_enterWithu1:(NSString*)u1 u2:(NSString*)u2  And:(void(^)(NSDictionary *dic))block{
    NSString *urlString = [NSString stringWithFormat:@"%@User_login1.ashx",HTTP_HEAD];
    u1=[u1 stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    NSString *pass1 =[NSString stringWithFormat:@"%@EQD",u2];
    NSString *pass= [self sha1:pass1];
    NSDictionary *parameters = @{
                                 Z_U1:u1,
                                 Z_U2:pass,
                                 };
    

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
       block(@{@"status":@"220",@"error":error});
    }];

}

+(void)user_backpassWithtemail:(NSString*)temail  aname:(NSString*)aname And:(void(^)(NSDictionary *dic))block{
    NSString *urlString = [NSString stringWithFormat:@"%@User_backpass.aspx",HTTP_HEAD];
    temail = [temail stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    aname = [aname stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    NSDictionary *parameters = @{
                                 Z_TEMAIL:temail,
                                 Z_ANAME:aname
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       block(@{@"status":@"220",@"error":error});
    }];

}

+(void)user_cpassWithaname:(NSString*)aname apass:(NSString*)apass ran:(NSString*)ran And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_cpass.aspx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_ANAME:aname,
                                 Z_APASS:apass,
                                 Z_RAN:ran
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_AddFriendWithuserid:(NSString*)userid friendid:(NSString*)friendid content:(NSString*)content  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_AddFriend.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_USERID:userid,
                                 Z_FRIENDID:friendid,
                                 Z_addcontent:content,
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
       block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_Friend_OptionWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Friend_Option.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendGuid:friendGuid,
                                 Z_type:type
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_AddFriend_RequestWithuid:(NSString*)uid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_AddFriend_Request.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_UID:uid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      block(@{@"status":@"220",@"error":error});
    }];

}


+(void)User_GetFriendListuid:(NSString*)uid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_FriendList.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:uid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_RyHttpClientWithuserId:(NSString*)userId name:(NSString*)name portraitUri:(NSString*)portraitUri And:(void(^)(NSDictionary *dic))block

{
    NSString *urlString = [NSString stringWithFormat:@"%@User_RyHttpClient.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userId:userId,
                                 Z_NAME:name,
                                 Z_portraitUri:portraitUri
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_rname_authenWithiphoto:(UIImage*)iphoto idnum:(NSString*)idnum sex:(int)sex nation:(NSString*)nation brith:(NSString*)brith pnative:(NSString*)pnative email:(NSString*)email uname:(NSString*)uname name:(NSString*)name And:(void(^)(NSDictionary *dic))block{
    NSString *urlString = [NSString stringWithFormat:@"%@User_rname_authen.aspx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_IDNUM:idnum,
                                 Z_SEX:@(sex),
                                 Z_NATION:nation,
                                 Z_BRITH:brith,
                                 Z_PNATIVE:pnative,
                                 Z_EMAIL:email,
                                 Z_UNAME:uname,
                                 Z_NAME:name,
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
   

    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data =UIImageJPEGRepresentation(iphoto, 0.1);
//        [formData appendPartWithFormData:data name:@"ios_zhengjian.jpg"];
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_zhengjian.jpg" mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"=上传进度==%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败");
    }];
    
}

+(void)GetuserinfoWithimg:(UIImage *)img And:(void(^)(NSDictionary *dic))block{
    NSString *urlString = [NSString stringWithFormat:@"https://api-cn.faceplusplus.com/cardpp/v1/ocridcard"];
    NSData *data = UIImageJPEGRepresentation(img, 0.1);
    NSString *base64=[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *parameters = @{
                                 @"api_key":@"BDTL1FCK4QfGQ-0CbMcjctjwYNV5j2wV",
                                 @"api_secret":@"BZe8oWV7CjxfNfO5U5OTWp5a5mRbT8Nb",
                                 @"image_base64":base64
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_updatePasswordWithuserGuid:(NSString*)userGuid oldPassword:(NSString*)oldPassword  newPasswor:(NSString*)newPasswor And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_updatePassword.ashx",HTTP_HEAD];
    
    NSString *old =[NSString stringWithFormat:@"%@EQD",oldPassword];
    old =[self sha1:old];
    NSString *new = [NSString stringWithFormat:@"%@EQD",newPasswor];
    new = [self sha1:new];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_oldPassword:old,
                                 Z_newPassword:new
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_Group_CreateWithuserid:(NSString*)userid groupid:(NSString*)groupid groupname:(NSString*)groupname GroupMembers:(NSString*)GroupMembers And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Group_Create.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userid:userid,
                                 Z_GROUPID:groupid,
                                 Z_GROUPNAME:groupname,
                                 Z_GroupMembers:GroupMembers
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}


+(void)User_AddgroupWithuserGuid:(NSString*)userGuid Groupid:(NSString*)Groupid GroupName:(NSString*)GroupName And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Addgroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_GROUPID:Groupid,
                                 Z_GroupName:GroupName
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_DismissgroupWithuserGuid:(NSString*)userGuid Groupid:(NSString*)Groupid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Dismissgroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_Groupid:Groupid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_GroupmemberWithgroupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Groupmember.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_GROUPID:groupid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}


+(void)User_QuitgroupWithuserGuid:(NSString*)userGuid Groupid:(NSString*)Groupid GroupName:(NSString*)GroupName  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Quitgroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_Groupid:Groupid,
                                 Z_GroupName:GroupName
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Option_AreasAndWithtype:(NSInteger)type And:(void(^)(NSArray *arr))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Option_AreasAnd.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_type:@(type)
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *arr1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(arr1);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@[@"name",@"服务器错误"]);
    }];
}

+(void)Usre_SearchGroupWithgroupname:(NSString*)groupname groupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Usre_SearchGroup.ashx",HTTP_HEAD];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (groupname==nil && groupid!=nil) {
        [parameters setValue:groupid forKey:Z_GROUPID];
    }
    else if (groupname!=nil && groupid==nil)
    {
        [parameters setValue:groupname forKey:Z_GROUPNAME];
    }
    else
    {
        
    }
    
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_GetGroupsWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_GetGroups.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_loginWithcomname:(NSString*)comname comdutyman:(NSString*)comdutyman comdutyIDnum:(NSString*)comdutyIDnum comdutytel:(NSString*)comdutytel comtype:(NSString*)comtype combusi:(NSString*)combusi comadres:(NSString*)comadres comcontact:(NSString*)comcontact comemai:(NSString*)comemai uid:(NSString*)uid province:(NSString*)province city:(NSString*)city area:(NSString*)area And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_register.ashx",HTTP_HEAD];
    NSArray *hangye = [combusi componentsSeparatedByString:@"-"];
    NSArray *address = [comadres componentsSeparatedByString:@"-"];
    
    
    NSDictionary *parameters = @{
                                 Z_province:province,
                                 Z_city:city,
                                 Z_area:area,
                                 Z_userGuid:uid,
                                 Z_NAME:comname,
                                 Z_dutyman:comdutyman,
                                 Z_dutyIDnum:comdutyIDnum,
                                 Z_dutytel:comdutytel,
                                 Z_type:comtype,
                                 
                                 Z_hangye:hangye[0],
                                 Z_address:address[0],
                                 Z_contact:comcontact,
                                 Z_email:comemai,
                                 Z_quhao:address[1],
                                 Z_hangyehao:hangye[1]
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_UpdateUserinfoWithuserGuid:(NSString*)userGuid para:(NSString*)para And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_UpdateUserinfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_para:para
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_UpdateGroupInfoWithgroupid:(NSString*)groupid groupname:(NSString*)groupname groupphoto:(UIImage*)groupphoto And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_UpdateGroupInfo.aspx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_GROUPID:groupid,
                                 Z_GROUPNAME:groupname
                                 };
   
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (groupphoto==nil) {
            
        }
        else
        {
        NSData *data = UIImageJPEGRepresentation(groupphoto, 0.1);
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_quntouxiang.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    

}


+(void)Com_regiInfoWithcomId:(NSString*)comId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_regiInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_comId:comId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_JudgeExistWithuid:(NSString*)uid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_JudgeExist.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_username:uid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_CreateDepartmentWithcompanyId:(NSString*)companyId parentId:(NSString*)parentId name:(NSString*)name userGuid:(NSString*)userGuid desc:(NSString*)desc And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_CreateDepartment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_parentId:parentId,
                                 Z_NAME:name,
                                 Z_userGuid:userGuid,
                                 Z_desc:desc
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_SelectDepartmentWithCompanyId:(NSString*)CompanyId ParentId:(NSString*)ParentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_SelectDepartment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:CompanyId,
                                 Z_ParentId:ParentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_CreatePostWithcompanyId:(NSString*)companyId departId:(NSString*)departId name:(NSString*)name type:(NSString*)type desc:(NSString*)desc isleader:(NSString*)isleader userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_CreatePost.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_NAME:name,
                                 Z_type:type,
                                 Z_desc:desc,
                                 Z_isleader:isleader,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_alterSimpleNameWithuserGuid:(NSString*)userGuid comId:(NSString*)comId simpleName:(NSString*)simpleName And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_alterSimpleName.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comId:comId,
                                 Z_simpleName:simpleName
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_SelectPostWithdepartId:(NSString*)departId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_SelectPost.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_departId:departId,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_alterLogoWithuserGuid:(NSString*)userGuid comId:(NSString*)comId img:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_alterLogo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comId:comId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(img, 0.1);
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_logo" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
   


}

+(void)Com_rname_authenWithimgArr:(NSArray<UIImage*>*)img codecertifinumb:(NSString*)codecertifinumb buslicensenumb:(NSString*)buslicensenumb productcertifinum:(NSString*)productcertifinum maincustomer:(NSString*)maincustomer registeredassets:(NSString*)registeredassets busscope:(NSString*)busscope bussetdate:(NSString*)bussetdate  busterm:(NSString*)busterm mainbus:(NSString*)mainbus mainbusadress:(NSString*)mainbusadress  staffnum:(NSString*)staffnum  comid:(NSString*)comid userGuid:(NSString*)userGuid user:(NSString*)user And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_Certification.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_codecertifi:codecertifinumb,
                                 Z_buslicense:buslicensenumb,
                                 Z_productcertifi:productcertifinum,
                                 Z_maincustomer:maincustomer,
                                 Z_registered:registeredassets,
                                 Z_busScope:busscope,
                                 Z_busSetdate:bussetdate,
                                 Z_busterm:busterm,
                                 Z_mainbus:mainbus,
                                 Z_mainbusadress:mainbusadress,
                                 Z_staffnum:staffnum,
                                 Z_user:user,
                                 Z_comId:comid,
                                 Z_userid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSArray *arrnames =@[@"dutyIDnumphotofront",@"dutyIDnumphotoback",@"dutyIDnumhandphoto",@"codecertifiphoto",@"buslicensephoto",@"productcertifiphoto"];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0;i<img.count;i++) {
            UIImage *image = img[i];
            NSData *data=UIImageJPEGRepresentation(image, 0.1);
            [formData appendPartWithFileData:data name:arrnames[i] fileName:[NSString stringWithFormat:@"ios_%d.jpg",i] mimeType:@"image/jpeg"];
        }
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
    


}
+(void)Com_Update_DepartWithname:(NSString*)name describe:(NSString*)describe userGuid:(NSString*)userGuid ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_Update_Depart.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_NAME:name,
                                 Z_describe:describe,
                                 Z_userGuid:userGuid,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}


+(void)user_phonesWithphoneArr:(NSArray*)phoneArr companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSMutableString *phones=[NSMutableString string];
    for (int i=0; i<phoneArr.count; i++) {
        if (i==phoneArr.count-1) {
            [phones appendString:phoneArr[i]];
        }
        else
        {
            [phones appendFormat:@"%@;",phoneArr[i]];
        }
    }
    NSString *urlString = [NSString stringWithFormat:@"%@user_phones.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_phones:phones
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}



+(void)Com_Delete_DepartWithcompanyId:(NSString*)companyId departId:(NSString*)departId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_Delete_Depart.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_departId:departId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_Update_HeadimageWithuser:(NSString*)user userGuid:(NSString*)userGuid img:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Update_Headimage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_user:user,
                                 Z_userGuid:userGuid
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(img, 0.1);
          [formData appendPartWithFileData:data name:@"haedImg" fileName:@"ios_head.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       block(@{@"status":@"220",@"error":error});
    }];
    
    
    


}

+(void)Com_InsertStaffInfoWithuserGuid:(NSString*)userGuid  name:(NSString*)name imagearr:(NSArray<UIImage*>*)imageArr idnum:(NSString*)idnum sex:(NSString*)sex age:(NSString*)age date:(NSString*)date rdate:(NSString*)rdate pnative:(NSString*)pnative nation:(NSString*)nation mail:(NSString*)mail housetype:(NSString*)housetype houseadress:(NSString*)houseadress ptel:(NSString*)ptel And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_InsertStaffInfo.aspx",HTTP_HEAD];
    NSDictionary  *parameters = @{
                                 Z_NAME:name,
                                 Z_IDNUM:idnum,
                                 Z_SEX:sex,
                                 Z_age:age,
                                 Z_date:date,
                                 Z_PNATIVE:pnative,
                                 Z_NATION:nation,
                                 Z_houseadress:houseadress,
                                 Z_housetype:housetype,
                                 Z_rdate:rdate,
                                 Z_userGuid:userGuid,
                                 Z_user:ptel,
                                 Z_ptel:ptel
                                 };
    NSMutableDictionary *paramters1 =[NSMutableDictionary dictionaryWithDictionary:parameters];
    if (![mail isEqualToString:@"请输入"]) {
        [paramters1 setObject:mail forKey:Z_mail];
        
    }
    else
    {
        [paramters1 setObject:@" " forKey:Z_mail];
    }
    
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSArray *arrnames= @[@"iphoto",@"idumfrontphoto",@"idumbackphoto",@"withidumphoto"];
    [manager POST:urlString parameters:paramters1 constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i=0;i<imageArr.count;i++) {
            UIImage *image = imageArr[i];
            NSData *data=UIImageJPEGRepresentation(image, 0.1);
            [formData appendPartWithFileData:data name:arrnames[i] fileName:[NSString stringWithFormat:@"ios_%d.jpg",i] mimeType:@"image/jpeg"];
        }

        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
    
    
    
}



+(void)User_StaffInfoWithuserGuid:(NSString*)userGuid password:(NSString*)password And:(void(^)(NSDictionary *dic))block
{
    
    NSString *pass1 =[NSString stringWithFormat:@"%@EQD",password];
    NSString *pass= [self sha1:pass1];
    NSString *urlString = [NSString stringWithFormat:@"%@User_StaffInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_password:pass
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}


+(void)User_Friend_DeleteWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Friend_Delete.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid :userGuid,
                                 Z_friendGuid:friendGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}



+(void)Com_Update_PostWithname:(NSString*)name type:(NSString*)type desc:(NSString*)desc userGuid:(NSString*)userGuid ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_Update_Post.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_id:ID
                                 };
    NSMutableDictionary *canshu = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if (type!=nil) {
        [canshu setValue:type forKey:Z_type];
    }
    if (name!=nil) {
        [canshu setValue:name forKey:Z_NAME];
    }
    if (desc!=nil) {
        [canshu setValue:desc forKey:Z_desc];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:canshu progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Delete_PostWithpostId:(NSString*)postId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_Delete_Post.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_postId:postId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Add_NewStaffWithphones:(NSArray*)phones companyId:(NSString*)companyId company:(NSString*)company departId:(NSString*)departId department:(NSString*)department postId:(NSString*)postId post:(NSString*)post userGuid:(NSString*)userGuid user:(NSString*)user And:(void(^)(NSDictionary *dic))block
{
    NSMutableString *tstr =[NSMutableString string];
    for (int i=0; i<phones.count; i++) {
        if (i==phones.count-1) {
            [tstr appendString:phones[i]];
        }
        else
        {
            [tstr appendFormat:@"%@;",phones[i]];
        }
    }
    NSString *urlString = [NSString stringWithFormat:@"%@Com_Add_NewStaff.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_phones:tstr,
                                 Z_companyId:companyId,
                                 Z_company:company,
                                 Z_departId:departId,
                                 Z_department:department,
                                 Z_postId:postId,
                                 Z_post:post,
                                 Z_userGuid:userGuid,
                                 Z_user:user
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_AffirmBossbossid:(NSString*)bossid cid:(NSString*)cid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_AffirmBoss.aspx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_CID:cid,
                                 Z_bossid:bossid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_SetPersonnelWithuid:(NSString*)uid cid:(NSString*)cid post:(NSString*)post status:(NSString*)status And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_SetPersonnel.aspx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_post:post,
                                 Z_UID:uid,
                                 Z_CID:cid,
                                 Z_status:status
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       block(@{@"status":@"220",@"error":error});
    }];

}



+(void)Com_SelectAutherWithcid:(NSString*)cid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_SelectAuther.aspx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_CID:cid
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_getcompostWithcomid:(NSString*)comid  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_getcompost.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_comId:comid,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}










+(void)Com_GetUserByDepartWithdepartId:(NSString*)departId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com_GetUserByDepart.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_departId:departId,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_Friend_SeachWithuserGuid:(NSString*)userGuid account:(NSString*)account And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Friend_Seach.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_account:account
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_InvitationWithuser:(NSString*)user And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Invitation.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_user:user
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_ApplyForEntryWithuserGuid:(NSString*)userGuid user:(NSString*)user entryId:(NSString*)entryId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_ApplyForEntry.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_user:user,
                                 Z_entryId:entryId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_GetQuitRecordListWithquitId:(NSString*)quitId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_GetQuitRecordList.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_quitId:quitId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_InvertAgreeWithuserGuid:(NSString*)userGuid entryId:(NSString*)entryId userPhone:(NSString*)userPhone And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_InvertAgree.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_entryId:entryId,
                                 Z_userPhone:userPhone
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_Delete_ApplyForEntryWithentryId:(NSString*)entryId  status:(NSString*)status And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Delete_ApplyForEntry.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_entryId:entryId,
                                 Z_status:status
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)trumpet_Push_trumpetWithuserGuid:(NSString*)userGuid comid:(NSString*)comid content:(NSString*)content And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@trumpet/Push_trumpet.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_content:content
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_GetBeInviterWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_GetBeInviter.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_InvertRefuseWithuserGuid:(NSString*)userGuid entryId:(NSString*)entryId userPhone:(NSString*)userPhone And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_InvertRefuse.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_entryId:entryId,
                                 Z_userPhone:userPhone
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)User_QuitWithcompanyId:(NSString*)companyId  postId:(NSString*)postId departId:(NSString*)departId userGuid:(NSString*)userGuid  joinTime:(NSString*)joinTime quitReason:(NSString*)quitReason quitType:(NSString*)quitType joinNumber:(NSString*)joinNumber  quitTime:(NSString*)quitTime And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_Quit.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_postId:postId,
                                 Z_departId:departId,
                                 Z_userGuid:userGuid,
                                 Z_joinTime:joinTime,
                                 Z_quitReason:quitReason,
                                 Z_quitTime:quitTime,
                                 Z_quitType:quitType,
                                 Z_joinNumber:joinNumber
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_GetQuitInfoWithquitId:(NSString*)quitId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_GetQuitInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_quitId:quitId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}




+(void)Com_User_BusinessCardWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/User_BusinessCard.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Update_upnameWithuserGuid:(NSString*)userGuid upname:(NSString*)upname And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_upname.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_upname:upname
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Update_loginLocationWithuserGuid:(NSString*)userGuid loginLocation:(NSString*)loginLocation province:(NSString*)province city:(NSString*)city And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_loginLocation.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_loginLocation:loginLocation,
                                 Z_province:province,
                                 Z_city:city
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)userashx_Update_loginphonenoWithuserGuid:(NSString*)userGuid password:(NSString*)password uname:(NSString*)uname And:(void(^)(NSDictionary *dic))block
{
    NSString *pas1 =[NSString stringWithFormat:@"%@EQD",password];
    NSString *pas2 =[self sha1:pas1];
    
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_loginphoneno.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_password:pas2,
                                 Z_UNAME:uname
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Com_User_ByCompanyWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Com_User_ByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Com_StaffWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Com_Staff.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Com_Staff_QuitWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Com_Staff_Quit.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_User_Search_InfoWithcompanyId:(NSString*)companyId para:(NSString*)para And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/User_Search_Info.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_para:para
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_User_SearchWithcompanyId:(NSString*)companyId para:(NSString*)para userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/User_Search.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_para:para,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_TaskWithuserGuid:(NSString*)userGuid TaskName:(NSString*)TaskName ParentTaskId:(NSString*)ParentTaskId recipient:(NSString*)recipient assist:(NSString *)assist notify:(NSString*)notify startTime:(NSString*)startTime endTime:(NSString*)endTime checkStandard:(NSString*)checkStandard checker:(NSString*)checker checkTime:(NSString*)checkTime duty:(NSString*)duty companyId:(NSString*)companyId departId:(NSString*)departId taskDesc:(NSString*)taskDesc  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Add_Task.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_TaskName:TaskName,
                                 Z_ParentTaskId:ParentTaskId,
                                 Z_recipient:recipient,
                                 Z_assist:assist,
                                 Z_notify:notify,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_checkStandard:checkStandard,
                                 Z_checker:checker,
                                 Z_checkTime:checkTime,
                                 Z_duty:duty,
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_taskDesc:taskDesc
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Task_ByCreaterWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_Task_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_id:ID,
                                 Z_status:status
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_Task_InfoWithtaskId:(NSString*)taskId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_Task_Info.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_taskId:taskId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Set_AgreeTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message name:(NSString*)name And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Set_AgreeTask.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_taskId:taskId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_NAME:name
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Set_RefuseTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message name:(NSString*)name And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Set_RefuseTask.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_taskId:taskId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_NAME:name
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Set_CompleteTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message imgs:(NSArray<UIImage*>*)imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Set_CompleteTask.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_taskId:taskId,
                                 Z_userGuid:userGuid,
                                 Z_message:message
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imgs!=nil) {
            for (int i=0; i<imgs.count; i++) {
                UIImage *timg =imgs[i];
                NSData *tdata = UIImageJPEGRepresentation(timg, 0.1);
                [formData appendPartWithFileData:tdata name:@"file" fileName:@"ios_img" mimeType:@"image/jpeg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
    
  
}
+(void)Set_CheckTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message imgs:(NSArray*)imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Set_CheckTask.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_taskId:taskId,
                                 Z_userGuid:userGuid,
                                 Z_message:message
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imgs!=nil) {
            for (int i=0; i<imgs.count; i++) {
                UIImage *timg =imgs[i];
                NSData *tdata = UIImageJPEGRepresentation(timg, 0.1);
                [formData appendPartWithFileData:tdata name:@"file" fileName:@"ios_img" mimeType:@"image/jpeg"];
            }
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
}
+(void)Get_Task_ByRecipientWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_Task_ByRecipient.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_id:ID,
                                 Z_status:status
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_Task_ByOtherWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_Task_ByOther.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_id:ID,
                                 Z_status:status
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_Task_ByCheckerWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_Task_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_id:ID,
                                 Z_status:status
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_TaskCheckWithtaskId:(NSString*)taskId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_TaskCheck.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_taskId:taskId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Task_BySearchWithcompanyId:(NSString*)companyId startDate:(NSString*)startDate endDate:(NSString*)endDate para:(NSString*)para And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@MyTask/Get_Task_BySearch.ashx",HTTP_HEAD];
    NSMutableDictionary *parameters =[NSMutableDictionary dictionaryWithDictionary:@{Z_companyId:companyId}];
    if (startDate!=nil) {
        [parameters setValue:startDate forKey:Z_startDate];
    }
    if(endDate!=nil)
    {
       [parameters setValue:endDate forKey:Z_endDate];
    }
    if (para!=nil &&![para isEqualToString:@""]) {
        [parameters setValue:para forKey:Z_para];
    }
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_WorkCircleWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid  message:(NSString*)message name:(NSString*)name location:(NSString*)location  imgarr:(NSArray*)imaArr And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Add_WorkCircle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_NAME:name,
                                 Z_location:location
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imaArr.count; i++) {
            UIImage *img = imaArr[i];
            NSData *data = UIImageJPEGRepresentation(img, 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:[NSString stringWithFormat:@"ios_%d",i] mimeType:@"image/jpeg"];
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});

    }];
    
    
}

+(void)Add_WorkCircle_CommentWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid message:(NSString*)message workCircleId:(NSString*)workCircleId  parentId:(NSString*)parentId  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Add_WorkCircle_Comment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_workCircleId:workCircleId,
                                 Z_parentId:parentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_WorkCircle_ZanWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid  workCircleId:(NSString*)workCircleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Add_WorkCircle_Zan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_workCircleId:workCircleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_WorkCircle_ByCompanyWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Get_WorkCircle_ByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Comment_ByWorkCircleIdWithworkCircleId:(NSString*)workCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Get_Comment_ByWorkCircleId.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_id:ID,
                                 Z_workCircleId:workCircleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Delete_WorkCircleWithworkCircleId:(NSString*)workCircleId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Delete_WorkCircle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_workCircleId:workCircleId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_WorkCircle_ZanWithworkCircleId:(NSString*)workCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Get_WorkCircle_Zan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_workCircleId:workCircleId,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Comment_ByIdWithcommentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Get_Comment_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_commentId:commentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Delete_CommentWithuserGuid:(NSString*)userGuid commentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Delete_Comment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_commentId:commentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_WorkCircle_ByIdWithworkCircleId:(NSString*)workCircleId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Get_WorkCircle_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_workCircleId:workCircleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_LeaveWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId leadvStartTime:(NSString*)leadvStartTime leaveEndTime:(NSString*)leaveEndTime leaveTime:(NSString*)leaveTime leaveType:(NSString*)leaveType leaveReason:(NSString*)leaveReason img:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Add_Leave.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_leadvStartTime:leadvStartTime,
                                 Z_leaveEndTime:leaveEndTime,
                                 Z_leaveTime:leaveTime,
                                 Z_leaveType:leaveType,
                                 Z_leaveReason:leaveReason
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (img==nil) {
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            block(dic1);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(@{@"status":@"220",@"error":error});
        }];
 
    }
    
    else
    {
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data = UIImageJPEGRepresentation(img, 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_jiehun.jpg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    }
    
}

+(void)Get_Leave_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Get_Leave_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Leave_CheckWithleaveId:(NSString*)leaveId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Get_Leave_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_leaveId:leaveId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Set_Leave_ByLeaderWithleaveId:(NSString*)leaveId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Set_Leave_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_leaveId:leaveId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Set_Leave_ByHRWithleaveId:(NSString*)leaveId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Set_Leave_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_leaveId:leaveId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_Leave_ByLeaderWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Get_Leave_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Leave_ByHRWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Get_Leave_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Delete_LeaveWithuserGuid:(NSString*)userGuid leaveId:(NSString*)leaveId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Delete_Leave.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_leaveId:leaveId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Leave_ByIdWithleaveId:(NSString*)leaveId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Leaves/Get_Leave_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_leaveId:leaveId
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_User_LeaderWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Get_User_Leader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Set_News_ApproverWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid approver:(NSString*)approver Id:(NSString*)Id type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Set_News_Approver.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_approver:approver,
                                 Z_Id:Id,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}



+(void)Add_RuleShiftWithruleName:(NSString*)ruleName  ruleDescribe:(NSString*)ruleDescribe companyId:(NSString*)companyId userGuid:(NSString*)userGuid objecter:(NSString*)objecter shiftId:(NSString*)shiftId weeks:(NSString*)weeks holidays:(NSString*)holidays And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Add_RuleShift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_ruleName:ruleName,
                                 Z_ruleDescribe:ruleDescribe,
                                 Z_companyId:companyId,
                                 Z_objecter:objecter,
                                 Z_shiftId:shiftId,
                                 Z_weeks:weeks,
                                 Z_holidays:holidays
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_RuleShiftWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_RuleShift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Delete_RuleShiftWithuserGuid:(NSString*)userGuid shiftId:(NSString*)shiftId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Delete_RuleShift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_ruleShiftId:shiftId,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Update_RuleShiftWithshiftId:(NSString*)shiftId weeks:(NSString*)weeks holidays:(NSString*)holidays userGuid:(NSString*)userGuid companyId:(NSString*)companyId ruleShiftId:(NSString*)ruleShiftId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_RuleShift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_shiftId:shiftId,
                                 Z_weeks:weeks,
                                 Z_holidays:holidays,
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_ruleShiftId:ruleShiftId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Update_RuleShift_UserWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId ruleShiftId:(NSString*)ruleShiftId objecter:(NSString*)objecter And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_RuleShift_User.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_ruleShiftId:ruleShiftId,
                                 Z_objecter:objecter
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_Rule_UserWithruleShiftId:(NSString*)ruleShiftId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_Rule_User.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_ruleShiftId:ruleShiftId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_ShiftWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId shiftName:(NSString*)shiftName Arr:(NSArray*)timeArr And:(void(^)(NSDictionary *dic))block;
{
    NSMutableArray *tarr =[NSMutableArray arrayWithArray:@[@[@"00:00",@"00:00"],@[@"00:00",@"00:00"],@[@"00:00",@"00:00"],@[@"00:00",@"00:00"]]];
    [tarr replaceObjectsInRange:NSMakeRange(0, timeArr.count) withObjectsFromArray:timeArr];
    
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Add_Shift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_shiftName:shiftName,
                                 Z_startTime1:tarr[0][0],
                                 Z_endTime1:tarr[0][1],
                                 Z_startTime2:tarr[1][0],
                                 Z_endTime2:tarr[1][1],
                                 Z_startTime3:tarr[2][0],
                                 Z_endTime3:tarr[2][1],
                                 Z_startTime4:tarr[3][0],
                                 Z_endTime4:tarr[3][1]
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Shift_ByCompanyWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_Shift_ByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Delete_ShiftWithuserGuid:(NSString*)userGuid shiftId:(NSString*)shiftId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Delete_Shift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_shiftId:shiftId,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_User_ShiftWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_User_Shift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
     [manager.requestSerializer setTimeoutInterval:10.0f];
 
        [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            block(dic1);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            block(@{@"status":@"220",@"error":error});
        }];
   
  

}

+(void)create_labelWithowner:(NSString*)owner labelName:(NSString*)labelName labelfriends:(NSString*)labelfriends And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/create_label.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_labelName:labelName,
                                 Z_labelfriends:labelfriends
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_labellistWithowner:(NSString*)owner And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Get_labellist.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_labelWithowner:(NSString*)owner  labelid:(NSString*)labelid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Get_label.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_labelid:labelid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Add_labelmembersWithowner:(NSString*)owner  labelid:(NSString*)labelid  addmembers:(NSString*)addmembers And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Add_labelmembers.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_labelid:labelid,
                                 Z_addmembers:addmembers
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Prune_labelmembersWithowner:(NSString*)owner labelid:(NSString*)labelid  labelfriends:(NSString*)labelfriends And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Prune_labelmembers.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_labelid:labelid,
                                 Z_labelfriends:labelfriends
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Del_labelWithowner:(NSString*)owner labelid:(NSString*)labelid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Del_label.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_labelid:labelid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Update_ShiftWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId shiftId:(NSString*)shiftId shiftName:(NSString*)shiftName startTime1:(NSString*)startTime1 endTime1:(NSString*)endTime1 startTime2:(NSString*)startTime2 endTime2:(NSString*)endTime2 startTime3:(NSString*)startTime3 endTime3:(NSString*)endTime3 startTime4:(NSString*)startTime4 endTime4:(NSString*)endTime4 And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_Shift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_shiftId:shiftId,
                                 Z_shiftName:shiftName,
                                 Z_startTime1:startTime1,
                                 Z_startTime2:startTime2,
                                 Z_startTime3:startTime3,
                                 Z_startTime4:startTime4,
                                 Z_endTime1:endTime1,
                                 Z_endTime2:endTime2,
                                 Z_endTime3:endTime3,
                                 Z_endTime4:endTime4
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Add_TravelWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId travelStartTime:(NSString*)travelStartTime travelEndTime:(NSString*)travelEndTime travelTimes:(NSString*)travelTimes travelReason:(NSString*)travelReason travelAddress:(NSString*)travelAddress mapAddress:(NSString*)mapAddress And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@/travel/Add_Travel.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_travelStartTime:travelStartTime,
                                 Z_travelEndTime:travelEndTime,
                                 Z_travelTimes:travelTimes,
                                 Z_travelReason:travelReason,
                                 Z_travelAddress:travelAddress,
                                 Z_mapAddress:mapAddress
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_ChangeShiftWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid changeShiftId:(NSString*)changeShiftId changeShiftReason:(NSString*)changeShiftReason And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Add_ChangeShift1.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_changeShiftId:changeShiftId,
                                 Z_changeShiftReason:changeShiftReason
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_ChangeShft_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Get_ChangeShft_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_ChangeShift_ByIdWithchangeShiftId:(NSString*)changeShiftId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Get_ChangeShift_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_changeShiftId:changeShiftId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)
Get_ChangeShift_ByCheckerWithtype:(NSString*)type userGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Get_ChangeShift_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_type:type,
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Set_ChangeShift_ByCheckerWithchangeShiftId:(NSString*)changeShiftId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Set_ChangeShift_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_changeShiftId:changeShiftId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Set_ChangeShift_ByHRWithchangeShiftId:(NSString*)changeShiftId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Set_ChangeShift_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_changeShiftId:changeShiftId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_ChangeShift_ByHRWithtype:(NSString*)type userGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Get_ChangeShift_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_ChangeShift_CheckWithchangeShiftId:(NSString*)changeShiftId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Get_ChangeShift_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_changeShiftId:changeShiftId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Delete_ChangeShiftWithchangeShiftId:(NSString*)changeShiftId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ChangeShifts/Delete_ChangeShift.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_changeShiftId:changeShiftId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Add_OffWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId planStartTime:(NSString*)planStartTime planEndTime:(NSString*)planEndTime offStartTime:(NSString*)offStartTime offEndTime:(NSString*)offEndTime offTimes:(NSString*)offTimes And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Add_Off.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_planStartTime:planStartTime,
                                 Z_planEndTime:planEndTime,
                                 Z_offStartTime:offStartTime,
                                 Z_offEndTime:offEndTime,
                                 Z_offTimes:offTimes
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Off_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Get_Off_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Off_ByIdWithoffId:(NSString*)offId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Get_Off_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_offId:offId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Off_ByCheckerWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Get_Off_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];


}

+(void)Get_Off_ByHRWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Get_Off_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Set_Off_ByCheckerWithoffId:(NSString*)offId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Set_Off_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_offId:offId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Set_Off_ByHRWithoffId:(NSString*)offId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Set_Off_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_offId:offId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Get_Off_CheckWithoffId:(NSString*)offId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Get_Off_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_offId:offId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Get_Off_ByMonthWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Offs/Get_Off_ByMonth.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Add_OverTimeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId startOverTime:(NSString*)startOverTime endOverTime:(NSString*)endOverTime times:(NSString*)times overTimeReason:(NSString*)overTimeReason overTimeType:(NSString*)overTimeType And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Add_OverTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_startOverTime:startOverTime,
                                 Z_endOverTime:endOverTime,
                                 Z_times:times,
                                 Z_overTimeReason:overTimeReason,
                                 Z_overTimeType:overTimeType
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Get_OverTime_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Get_OverTime_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Get_OverTime_ByIdWithoverTimeId:(NSString*)overTimeId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Get_OverTime_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_overTimeId:overTimeId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Get_OverTime_ByCheckerWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Get_OverTime_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Get_OverTime_ByHRWithtype:(NSString*)type userGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Get_OverTime_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_type:type,
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Set_OverTime_ByCheckerWithoverTimeId:(NSString*)overTimeId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Set_OverTime_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_overTimeId:overTimeId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Set_OverTime_ByHRWithoverTimeId:(NSString*)overTimeId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Set_OverTime_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_overTimeId:overTimeId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)OverTimes_Get_OverTime_CheckWithoverTimeId:(NSString*)overTimeId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Get_OverTime_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_overTimeId:overTimeId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)OverTimes_Get_OverTime_ByMonthWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@OverTimes/Get_OverTime_ByMonth.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Get_Travel_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Get_Travel_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Get_Travel_ByIdWithtravelId:(NSString*)travelId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Get_Travel_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_travelId:travelId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Set_Travel_ByLeaderWithtravelId:(NSString*)travelId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Set_Travel_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_travelId:travelId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Set_Travel_ByHRWithtravelId:(NSString*)travelId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Set_Travel_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_travelId:travelId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)travel_Get_Travel_CheckWithuserGuidtravelId:(NSString*)travelId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Get_Travel_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_travelId:travelId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Get_Travel_ByLeaderWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Get_Travel_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)travel_Get_Travel_ByHRWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@travel/Get_Travel_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Clocks_Add_ClockWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId clockTime:(NSString*)clockTime place:(NSString*)place MAC:(NSString*)MAC WIFIName:(NSString*)WIFIName phoneUUID:(NSString*)phoneUUID phoneType:(NSString*)phoneType coordinate:(NSString*)coordinate type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    if (place==nil || coordinate==nil) {
        place=@"错误地址，定位被拒";
        coordinate=@"错误经纬度，定位被拒";
    }
    NSString *urlString = [NSString stringWithFormat:@"%@Clocks/Add_Clock.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_clockTime:clockTime,
                                 Z_place:place,
                                 Z_MAC:MAC,
                                 Z_WIFIName:WIFIName,
                                 Z_phoneUUID:phoneUUID,
                                 Z_phoneType:phoneType,
                                 Z_coordinate:coordinate,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Clocks_Get_Clock_ByMonthWithuserGuid:(NSString*)userGuid Month:(NSString*)Month   And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Clocks/Get_Clock_ByMonth.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_Month:Month
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Clocks_Update_ClockWithuserGuid:(NSString*)userGuid clockTime:(NSString*)clockTime place:(NSString*)place MAC:(NSString*)MAC WIFIName:(NSString*)WIFIName phoneUUID:(NSString*)phoneUUID phoneType:(NSString*)phoneType coordinate:(NSString*)coordinate clockId:(NSString*)clockId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Clocks/Update_Clock.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_clockTime:clockTime,
                                 Z_MAC:MAC,
                                 Z_WIFIName:WIFIName,
                                 Z_phoneUUID:phoneUUID,
                                 Z_phoneType:phoneType,
                                 Z_coordinate:coordinate,
                                 Z_clockId:clockId,
                                 Z_place:place
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Clocks_Get_ClockWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId date:(NSString*)date And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Clocks/Get_Clock.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_date:date
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Add_ContractWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId signatory:(NSString*)signatory signDepartId:(NSString*)signDepartId signPostId:(NSString*)signPostId signEntryTime:(NSString*)signEntryTime contractType:(NSString*)contractType contractNature:(NSString*)contractNature signedNumber:(NSString*)signedNumber lastReason:(NSString*)lastReason contractForm:(NSString*)contractForm contractStartTime:(NSString*)contractStartTime  contractEndTime:(NSString*)contractEndTime probation:(NSString*)probation bank:(NSString*)bank ProbationSalary:(NSString*)ProbationSalary And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Add_Contract.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_signatory:signatory,
                                 Z_signDepartId:signDepartId,
                                 Z_signPostId:signPostId,
                                 Z_signEntryTime:signEntryTime,
                                 Z_contractType:contractType,
                                 Z_contractNature:contractNature,
                                 Z_signedNumber:signedNumber,
                                 Z_lastReason:lastReason,
                                 Z_contractForm:contractForm,
                                 Z_contractStartTime:contractStartTime,
                                 Z_contractEndTime:contractEndTime,
                                 Z_probation:probation,
                                 Z_bank:bank,
                                 Z_ProbationSalary:ProbationSalary
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Get_Contract_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type  companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Get_Contract_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Get_Contract_ByIdWithcontractId:(NSString*)contractId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Get_Contract_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_contractId:contractId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Get_Contract_BySignatoryWithuserGuid:(NSString*)userGuid type:(NSString*)type  companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Get_Contract_BySignatory.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Get_Contract_ByLeaderWithuserGuid:(NSString*)userGuid  type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Get_Contract_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Set_Contract_BySignatoryWithcontractId:(NSString*)contractId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type bankCard:(NSString*)bankCard openBank:(NSString*)openBank And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Set_Contract_BySignatory.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_contractId:contractId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type,
                                 Z_bankCard:bankCard,
                                 Z_openBank:openBank
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Contracts_Set_Contract_ByCreaterWithcontractId:(NSString*)contractId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Set_Contract_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_contractId:contractId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Set_Contract_ByLeaderWithcontractId:(NSString*)contractId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Set_Contract_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_contractId:contractId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Contracts_Get_CheckWithcontractId:(NSString*)contractId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Contracts/Get_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_contractId:contractId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Get_Approver_ByNWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_Approver_ByN.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Set_LeaveTypeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId leaveType:(NSString*)leaveType And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Set_LeaveType.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_leaveType:leaveType
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)SetUp_Update_LeaveTypeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId  leaveType:(NSString*)leaveType leaveTypeId:(NSString*)leaveTypeId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_LeaveType.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_leaveType:leaveType,
                                 Z_leaveTypeId:leaveTypeId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Get_LeaveTypeWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_LeaveType.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Add_LeaveCheckTimeWithuserGuid:(NSString*)userGuid minTime:(NSString*)minTime maxTime:(NSString*)maxTime companyId:(NSString*)companyId approval:(NSString*)approval type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Add_LeaveCheckTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_minTime:minTime,
                                 Z_maxTime:maxTime,
                                 Z_companyId:companyId,
                                 Z_approval:approval,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Update_LeaveCheckTimeWithuserGuid:(NSString*)userGuid minTime:(NSString*)minTime maxTime:(NSString*)maxTime companyId:(NSString*)companyId approvalLevel:(NSString*)approvalLevel  type:(NSString*)type ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_LeaveCheckTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_minTime:minTime,
                                 Z_maxTime:maxTime,
                                 Z_companyId:companyId,
                                 Z_approvalLevel:approvalLevel,
                                 Z_type:type,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)SetUp_Delete_LeaveCheckTimeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Delete_LeaveCheckTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Get_LeaveCheckTimeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_LeaveCheckTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
}

+(void)WorkCircles_Update_WorkImageWithuserGuid:(NSString*)userGuid user:(NSString*)user  img:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@WorkCircles/Update_WorkImage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_user:user
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data =UIImageJPEGRepresentation(img, 0.1);
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_imgbg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});

    }];
    
    

}

+(void)trumpet_Get_trumpetWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@trumpet/Get_trumpet.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Notices_Add_NoticeWithcompanyId:(NSString*)companyId noticeName:(NSString*)noticeName objectType:(NSString*)objectType objectDepartId:(NSString*)objectDepartId noticeTheme:(NSString*)noticeTheme noticeContent:(NSString*)noticeContent userGuid:(NSString*)userGuid duty:(NSString*)duty noticeCycle:(NSString*)noticeCycle And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Add_Notice.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_noticeName:noticeName,
                                 Z_objectType:objectType,
                                 Z_objectDepartId:objectDepartId,
                                 Z_noticeTheme:noticeTheme,
                                 Z_noticeContent:noticeContent,
                                 Z_userGuid:userGuid,
                                 Z_duty:duty,
                                 Z_noticeCycle:noticeCycle
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Notices_Get_Notice_ByIdWithnoticeId:(NSString*)noticeId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Get_Notice_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_noticeId:noticeId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Notices_Get_Notice_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Get_Notice_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Notices_Get_Notice_ByCheckerWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Get_Notice_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Notices_Get_Notice_ByCompanyWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Get_Notice_ByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Notices_Get_Notice_ByDepartmentWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Get_Notice_ByDepartment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Notices_Set_Notice_CheckWithnoticeId:(NSString*)noticeId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Set_Notice_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_noticeId:noticeId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Notices_Get_Notice_ByAllWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Notices/Get_Notice_ByAll.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)trumpet_Get_AlltrumpetWithuserGuid:(NSString*)userGuid comid:(NSString*)comid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@trumpet/Get_Alltrumpet.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Add_NewsWithcompanyId:(NSString*)companyId newsName:(NSString*)newsName objectType:(NSString*)objectType objectDepartId:(NSString*)objectDepartId newsTheme:(NSString*)newsTheme newsContent:(NSString*)newsContent userGuid:(NSString*)userGuid createDepartId:(NSString*)createDepartId duty:(NSString*)duty newsCycle:(NSString*)newsCycle isAdmin:(NSString*)isAdmin And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Add_News.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_newsName:newsName,
                                 Z_objectType:objectType,
                                 Z_objectDepartId:objectDepartId,
                                 Z_newsTheme:newsTheme,
                                 Z_newsContent:newsContent,
                                 Z_userGuid:userGuid,
                                 Z_createDepartId:createDepartId,
                                 Z_duty:duty,
                                 Z_newsCycle:newsCycle,
                                 Z_isAdmin:isAdmin
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Get_News_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Get_News_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Get_Notice_ByIdWithnewsId:(NSString*)newsId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Get_Notice_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_newsId:newsId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Get_News_ByCheckerWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Get_News_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Get_News_ByCompanyWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Get_News_ByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Get_Notice_ByDepartmentWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Get_Notice_ByDepartment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Set_News_CheckWithnewsId:(NSString*)newsId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Set_News_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_newsId:newsId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Newss_Get_News_ByAllWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Newss/Get_News_ByAll.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)LiaisonBooks_Add_LiaisonBookWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId departId:(NSString*)departId objectCompanyId:(NSString*)objectCompanyId objectDepartId:(NSString*)objectDepartId objecter:(NSString*)objecter liaisonBookName:(NSString*)liaisonBookName liaisonBookTheme:(NSString*)liaisonBookTheme liaisonBookContent:(NSString*)liaisonBookContent timeLimit:(NSString*)timeLimit isReply:(NSString*)isReply isLeader:(NSString*)isLeader And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Add_LiaisonBook.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_departId:departId,
                                 Z_objectCompanyId:objectCompanyId,
                                 Z_objectDepartId:objectDepartId,
                                 Z_objecter:objecter,
                                 Z_liaisonBookName:liaisonBookName,
                                 Z_liaisonBookTheme:liaisonBookTheme,
                                 Z_liaisonBookContent:liaisonBookContent,
                                 Z_timeLimit:timeLimit,
                                 Z_isReply:isReply,
                                 Z_isleader:isLeader
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)LiaisonBooks_Get_LiaisonBook_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Get_LiaisonBook_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)LiaisonBooks_Get_LiaisonBook_ByIdWithId:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Get_LiaisonBook_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)LiaisonBooks_Get_LiaisonBook_ByCheckerWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Get_LiaisonBook_ByChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_companyId:companyId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)LiaisonBooks_Set_LiaisonBook_CheckWithliaisonBookId:(NSString*)liaisonBookId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Set_LiaisonBook_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_liaisonBookId:liaisonBookId,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)LiaisonBooks_Get_LiaisonBook_ByObjecterWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Get_LiaisonBook_ByObjecter.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)LiaisonBooks_Get_Usre_BySearchWithpara:(NSString*)para And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@LiaisonBooks/Get_Usre_BySearch.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_para:para
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Get_TopAdminWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Get_TopAdmin.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Set_TopLeadersWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId  topLeader:(NSString*)topLeader And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Set_TopLeaders.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_topLeader:topLeader
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Add_SickleavesWithuserGuid:(NSString*)userGuid  choseDate:(NSString*)choseDate  ids:(NSString*)ids reason:(NSString*)reason witness:(NSString*)witness imgarr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Add_Sickleaves1.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_choseDate:choseDate,
                                 Z_ids:ids,
                                 Z_reason:reason,
                                 Z_witness:witness
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imgArr.count; i++) {
            NSData *tdata =UIImageJPEGRepresentation(imgArr[i], 0.1);
            [formData appendPartWithFileData:tdata name:@"file" fileName:@"ios_file" mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
   

}
+(void)Sickleaves_Get_SickLeaveByUserWithuserGuid:(NSString*)userGuid  page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_SickLeaveByUser.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Get_SickleaveByIdWithsickLeaveId:(NSString*)sickLeaveId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_SickleaveById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_sickLeaveId:sickLeaveId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Sickleaves_Get_SickleaveByLeaderWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_SickleaveByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Set_SickleaveWithuserGuid:(NSString*)userGuid sickleaveId:(NSString*)sickleaveId  message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Set_Sickleave.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_sickleaveId:sickleaveId,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Get_Sickleave_CheckWithsickleaveId:(NSString*)sickleaveId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_Sickleave_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_sickleaveId:sickleaveId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Get_Sickleave_ByHRWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_Sickleave_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Set_Sickleave_ByHRWithsickleaveId:(NSString*)sickleaveId userGuid:(NSString*)userGuid  message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Set_Sickleave_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_sickleaveId:sickleaveId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Add_MissClockWithuserGuid:(NSString*)userGuid choseDate:(NSString*)choseDate times:(NSString*)times reason:(NSString*)reason witness:(NSString*)witness imgArr:(NSArray*)imgarr And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Add_MissClock.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_choseDate:choseDate,
                                 Z_times:times,
                                 Z_reason:reason,
                                 Z_witness:witness
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imgarr.count; i++) {
            NSData *data =UIImageJPEGRepresentation(imgarr[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_file" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
    
    

}

+(void)Sickleaves_Get_MissClock_ByCreaterWithuserGuid:(NSString*)userGuid page:(NSString*)page  type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_MissClock_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Get_MissClock_ByLeaderWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_MissClock_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Set_MissClock_ByLeaderWithmissClockId:(NSString*)missClockId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Set_MissClock_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_missClockId:missClockId,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Get_MissClock_ByIdWithmissClockId:(NSString*)missClockId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_MissClock_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_missClockId:missClockId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Get_MissClock_CheckWithmissClockId:(NSString*)missClockId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_MissClock_Check.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_missClockId:missClockId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Sickleaves_Get_MissClock_ByHRWithuserGuid:(NSString*)userGuid page:(NSString*)page  type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Get_MissClock_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Sickleaves_Set_MissClock_ByHRWithmissClockId:(NSString*)missClockId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Sickleaves/Set_MissClock_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_missClockId:missClockId,
                                 Z_message:message,
                                 Z_type:type
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)ComImage_Add_ComImageWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId url:(NSString*)url title:(NSString*)title sort:(NSString*)sort img:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ComImage/Add_ComImage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_url:url,
                                 Z_title:title,
                                 Z_sort:sort
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data =UIImageJPEGRepresentation(img, 0.1);
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_file.jpg" mimeType:@"image/jpeg"];
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          block(@{@"status":@"220",@"error":error});
    }];
    
   

}
+(void)ComImage_Get_ComImageWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ComImage/Get_ComImage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)ComImage_Update_ComImageWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId url:(NSString*)url title:(NSString*)title sort:(NSString*)sort imageId:(NSString*)imageId img:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ComImage/Update_ComImage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_url:url,
                                 Z_title:title,
                                 Z_sort:sort,
                                 Z_imageId:imageId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (!img) {
            NSData *data =UIImageJPEGRepresentation(img, 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_file.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       block(@{@"status":@"220",@"error":error});
    }];
    

}

+(void)ComImage_Delete_ComImageWithuserGuid:(NSString*)userGuid imageId:(NSString*)imageId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ComImage/Delete_ComImage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_imageId:imageId,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)ComImage_Update_ImageSortWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId  para:(NSString*)para And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@ComImage/Update_ImageSort.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_companyId:companyId,
                                 Z_para:para
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Update_UserSignatureWithuserGuid:(NSString*)userGuid  signature:(NSString*)signature And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Update_UserSignature.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_signature:signature
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)memo_AddMemoWithuserGuid:(NSString*)userGuid eventName:(NSString*)eventName startDate:(NSString*)startDate endDate:(NSString*)endDate startTime:(NSString*)startTime endTime:(NSString*)endTime memoInfo:(NSString*)memoInfo eventType:(NSString*)eventType
                   timeToRemind:(NSString*)timeToRemind place:(NSString*)place And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@memo/AddMemo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_eventName:eventName,
                                 Z_startDate:startDate,
                                 Z_endDate:endDate,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_memoInfo:memoInfo,
                                 Z_eventType:eventType,
                                 Z_timeToRemind:timeToRemind,
                                 Z_place:place
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)memo_SeeMemouserGuid:(NSString*)userGuid seeDate:(NSString*)seeDate And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@memo/SeeMemo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_seeDate:seeDate
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)memo_DeleteMemoWithmemoid:(NSString*)memoid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@memo/DeleteMemo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_memoid:memoid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)memo_SeeTheMonthMemoWithuserGuid:(NSString*)userGuid seeDate:(NSString*)seeDate And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@memo/SeeTheMonthMemo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_seeDate:seeDate
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)memo_UpdateMemoWithmemoid:(NSString*)memoid eventName:(NSString*)eventName startDate:(NSString*)startDate endDate:(NSString*)endDate startTime:(NSString*)startTime endTime:(NSString*)endTime memoInfo:(NSString*)memoInfo eventType:(NSString*)eventType timeToRemind:(NSString*)timeToRemind place:(NSString*)place userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@memo/UpdateMemo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_memoid:memoid,
                                 Z_eventName:eventName,
                                 Z_startDate:startDate,
                                 Z_endDate:endDate,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_memoInfo:memoInfo,
                                 Z_eventType:eventType,
                                 Z_timeToRemind:timeToRemind,
                                 Z_place:place
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Get_Staff_BySearchWithcompanyId:(NSString*)companyId  departmentId:(NSString*)departmentId joinStartTime:(NSString*)joinStartTime joinEndTime:(NSString*)joinEndTime userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Get_Staff_BySearch.ashx",HTTP_HEAD];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:@{Z_companyId:companyId,Z_userGuid:userGuid}];
    if (![departmentId isEqualToString:@"请选择"]) {
        [parameters setObject:departmentId forKey:Z_departmentId];
    }
    if(![joinStartTime isEqualToString:@"请选择"])
    {
        [parameters setObject:joinStartTime forKey:Z_joinStartTime];
    }
    if (![joinEndTime isEqualToString:@"请选择"]) {
        [parameters setObject:joinEndTime forKey:Z_joinEndTime];
    }
    
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)jsms_JSendMessagesWithtel:(NSString*)tel And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@jsms/JSendMessages.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_tel:tel
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)jsms_ValidcodeWithmsgid:(NSString*)msgid code:(NSString*)code And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@jsms/Validcode.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_code:code,
                                 Z_msgid:msgid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)jsms_JSingleMessageWithtel:(NSString*)tel text:(NSString*)text tempid:(NSString*)tempid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@jsms/JSingleMessage.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_tel:tel,
                                 Z_text:text,
                                 Z_tempid:tempid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)jsms_JSendBatchMessagesWithrecipients:(NSString*)recipients tempid:(NSString*)tempid text:(NSString*)text And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@jsms/JSendBatchMessages.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_tempid:tempid,
                                 Z_recipients:recipients,
                                 Z_text:text
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)userashx_Add_workExperienceWithuserGuid:(NSString*)userGuid startTime:(NSString*)startTime endTime:(NSString*)endTime company:(NSString*)company induCategoryCode:(NSString*)induCategoryCode induCategoryName:(NSString*)induCategoryName enterpriseNature:(NSString*)enterpriseNature enterpriseScale:(NSString*)enterpriseScale monthlySalary:(NSString*)monthlySalary  department:(NSString*)department  post:(NSString*)post jobDescri:(NSString*)jobDescri isOvert:(NSString*)isOvert And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Add_workExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_company:company,
                                 Z_induCategoryCode:induCategoryCode,
                                 Z_induCategoryName:induCategoryName,
                                 Z_enterpriseNature:enterpriseNature,
                                 Z_enterpriseScale:enterpriseScale,
                                 Z_monthlySalary:monthlySalary,
                                 Z_department:department,
                                 Z_post:post,
                                 Z_jobDescri:jobDescri,
                                 Z_isOvert:isOvert
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Update_workExperienceWithuserGuid:(NSString*)userGuid workepid:(NSString*)workepid  startTime:(NSString*)startTime  endTime:(NSString*)endTime company:(NSString*)company induCategoryCode:(NSString*)induCategoryCode induCategoryName:(NSString*)induCategoryName  enterpriseNature:(NSString*)enterpriseNature enterpriseScale:(NSString*)enterpriseScale monthlySalary:(NSString*)monthlySalary  department:(NSString*)department  post:(NSString*)post  jobDescri:(NSString*)jobDescri And:(void(^)(NSDictionary *dic))block{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_workExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_workepid:workepid,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_company:company,
                                 Z_induCategoryCode:induCategoryCode,
                                 Z_induCategoryName:induCategoryName,
                                 Z_enterpriseNature:enterpriseNature,
                                 Z_enterpriseScale:enterpriseScale,
                                 Z_monthlySalary:monthlySalary,
                                 Z_department:department,
                                 Z_post:post,
                                 Z_jobDescri:jobDescri
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_RetrievalPwdWithtel:(NSString*)tel  code:(NSString*)code msgid:(NSString*)msgid  password:(NSString*)password  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/RetrievalPwd.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_tel:tel,
                                 Z_code:code,
                                 Z_msgid:msgid,
                                 Z_password:password
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Get_workExperienceWithuserGuid:(NSString*)userGuid  weuserGuid:(NSString*)weuserGuid  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Get_workExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_weuserGuid:weuserGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Update_weovertWithuserGuid:(NSString*)userGuid workepid:(NSString*)workepid isOvert:(NSString*)isOvert And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_weovert.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_workepid:workepid,
                                 Z_isOvert:isOvert
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Del_workExperienceWithuserGuid:(NSString*)userGuid workepid:(NSString*)workepid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Del_workExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_workepid:workepid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Add_projectExperienceWithuserGuid:(NSString*)userGuid  ownedCompany:(NSString*)ownedCompany projectName:(NSString*)projectName  startTime:(NSString*)startTime  endTime:(NSString*)endTime  duty:(NSString*)duty projectDescription:(NSString*)projectDescription  projectURL:(NSString*)projectURL  isOvert:(NSString*)isOvert And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Add_projectExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_ownedCompany:ownedCompany,
                                 Z_projectName:projectName,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_duty:duty,
                                 Z_projectDescription:projectDescription,
                                 Z_projectURL:projectURL,
                                 Z_isOvert:isOvert
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Update_projectExperienceWithuserGuid:(NSString*)userGuid projectepid:(NSString*)projectepid  ownedCompany:(NSString*)ownedCompany  projectName:(NSString*)projectName startTime:(NSString*)startTime endTime:(NSString*)endTime  duty:(NSString*)duty  projectDescription:(NSString*)projectDescription projectURL:(NSString*)projectURL And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_projectExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_projectepid:projectepid,
                                 Z_ownedCompany:ownedCompany,
                                 Z_projectName:projectName,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_duty:duty,
                                 Z_projectDescription:projectDescription,
                                 Z_projectURL:projectURL
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Get_projectExperienceWithuserGuid:(NSString*)userGuid  peuserGuid:(NSString*)peuserGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Get_projectExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_peuserGuid:peuserGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Update_peovertWithuserGuid:(NSString*)userGuid  projectepid:(NSString*)projectepid  isOvert:(NSString*)isOvert  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_peovert.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_projectepid:projectepid,
                                 Z_isOvert:isOvert
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Del_projectExperienceWithuserGuid:(NSString*)userGuid  projectepid:(NSString*)projectepid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Del_projectExperience.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_projectepid:projectepid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_Update_EQDCodeWithuserGuid:(NSString*)userGuid  eqdCodeNew:(NSString*)eqdCodeNew And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/Update_EQDCode.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_eqdCodeNew:eqdCodeNew
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)feedback_User_addfbWithtitle:(NSString*)title  type:(NSString*)type  contactway:(NSString*)contactway fbcontent:(NSString*)fbcontent  userGuid:(NSString*)userGuid imgArr:(NSArray*)imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@feedback/User_addfb.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_title:title,
                                 Z_type:type,
                                 Z_contactway:contactway,
                                 Z_fbcontent:fbcontent,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if(imgs !=nil)
        {
        for(int i=0; i<imgs.count;i++)
        {
            UIImage *timg = imgs[i];
            NSData *tdata = UIImageJPEGRepresentation(timg, 0.1);
          [formData appendPartWithFileData:tdata name:@"file" fileName:@"ios_name.jpg" mimeType:@"image/jpeg"];
            
        }
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          block(@{@"status":@"220",@"error":error});
    }];
    
    
   

}

+(void)feedback_Getfb_userWithuserGuid:(NSString*)userGuid  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@feedback/Getfb_user.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Create_customerWithowner:(NSString*)owner  comid:(NSString*)comid cusName:(NSString*)cusName cusType:(NSString*)cusType salesTerritory:(NSString*)salesTerritory  address:(NSString*)address latAndLong:(NSString*)latAndLong cusCall:(NSString*)cusCall url:(NSString*)url remark:(NSString*)remark imgArr:(NSArray*)imgArr salesTerritoryCode:(NSString*)salesTerritoryCode And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Create_customer.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_comid:comid,
                                 Z_cusName:cusName,
                                 Z_cusType:cusType,
                                 Z_salesTerritory:salesTerritory,
                                 Z_address:address,
                                 Z_latAndLong:latAndLong,
                                 Z_cusCall:cusCall,
                                 Z_url:url,
                                 Z_remark:remark,
                                 Z_salesTerritoryCode:salesTerritoryCode
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imgArr.count; i++) {
            NSData *data =UIImageJPEGRepresentation(imgArr[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_img" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          block(@{@"status":@"220",@"error":error});
    }];
   

}

+(void)crmModule_Update_customerWithowner:(NSString*)owner  cusid:(NSString*)cusid data:(NSString*)data  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Update_customer.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusid:cusid,
                                 Z_data:data
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Owner_getcuslistWithowner:(NSString*)owner page:(NSString*)page  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Owner_getcuslist.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Owner_getcusWithowner:(NSString*)owner cusid:(NSString*)cusid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Owner_getcus.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusid:cusid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Del_customerWithowner:(NSString*)owner  cusid:(NSString*)cusid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Del_customer.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusid:cusid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Create_cuscontactsWithname:(NSString*)name dep:(NSString*)dep post:(NSString*)post cellphone:(NSString*)cellphone conqq:(NSString*)conqq conwx:(NSString*)conwx email:(NSString*)email remark:(NSString*)remark cusid:(NSString*)cusid  owner:(NSString*)owner  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Create_cuscontacts.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_NAME:name,
                                 Z_dep:dep,
                                 Z_post:post,
                                 Z_cellphone:cellphone,
                                 Z_conqq:conqq,
                                 Z_conwx:conwx,
                                 Z_email:email,
                                 Z_remark:remark,
                                 Z_cusid:cusid,
                                 Z_owner:owner
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Update_cuscontactsWithowner:(NSString*)owner  contactsid:(NSString*)contactsid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Update_cuscontacts.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_contactsid:contactsid,
                                 Z_data:data
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)crmModule_Get_cuscontactslistWithgetpeople:(NSString*)getpeople  owner:(NSString*)owner  comid:(NSString*)comid cusid:(NSString*)cusid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Get_cuscontactslist.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_comid:comid,
                                 Z_cusid:cusid,
                                 Z_page:page,
                                 Z_getpeople:getpeople
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Get_cuscontactsWithowner:(NSString*)owner  contactsid:(NSString*)contactsid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Get_cuscontacts.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_contactsid:contactsid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Del_cuscontactsWithowner:(NSString*)owner  contactsid:(NSString*)contactsid  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Del_cuscontacts.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_contactsid:contactsid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)crmModule_Create_saleschanceWithowner:(NSString*)owner comid:(NSString*)comid  chanceName:(NSString*)chanceName chanceClassify:(NSString*)chanceClassify cusid:(NSString*)cusid contacts:(NSString*)contacts interestproducts:(NSString*)interestproducts  createDate:(NSString*)createDate  exdateofcompletion:(NSString*)exdateofcompletion  productsalesmoney:(NSString*)productsalesmoney expectmoney:(NSString*)expectmoney  remark:(NSString*)remark remindTime:(NSString*)remindTime And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Create_saleschance.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_comid:comid,
                                 Z_chanceName:chanceName,
                                 Z_chanceClassify:chanceClassify,
                                 Z_cusid:cusid,
                                 Z_contacts:contacts,
                                 Z_interestproducts:interestproducts,
                                 Z_createDate:createDate,
                                 Z_exdateofcompletion:exdateofcompletion,
                                 Z_productsalesmoney:productsalesmoney,
                                 Z_expectmoney:expectmoney,
                                 Z_remark:remark,
                                 Z_remindTime:remindTime
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Update_saleschanceWithowner:(NSString*)owner  saleschanceid:(NSString*)saleschanceid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Update_saleschance.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_data:data,
                                 Z_saleschanceid:saleschanceid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)crmModule_Del_saleschanceWithowner:(NSString*)owner  saleschanceid:(NSString*)saleschanceid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Del_saleschance.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_saleschanceid:saleschanceid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Get_saleschancelistWithowner:(NSString*)owner  cusid:(NSString*)cusid  page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Get_saleschancelist.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusid:cusid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Add_revisitRecordWithowner:(NSString*)owner  comid:(NSString*)comid  revisitTitle:(NSString*)revisitTitle cusid:(NSString*)cusid  cusName:(NSString*)cusName  contactsid:(NSString*)contactsid  contactsName:(NSString*)contactsName  contactsPhone:(NSString*)contactsPhone  revisitDate:(NSString*)revisitDate  revisitType:(NSString*)revisitType  revisitcontent:(NSString*)revisitcontent  remindTime:(NSString*)remindTime imgArr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Add_revisitRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_comid:comid,
                                 Z_revisitTitle:revisitTitle,
                                 Z_cusid:cusid,
                                 Z_cusName:cusName,
                                 Z_contactsid:contactsid,
                                 Z_contactsName:contactsName,
                                 Z_contactsPhone:contactsPhone,
                                 Z_revisitDate:revisitDate,
                                 Z_revisitType:revisitType,
                                 Z_revisitcontent:revisitcontent,
                                 Z_remindTime:remindTime
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imgArr) {
            for (int i=0; i<imgArr.count; i++) {
                NSData *data = UIImageJPEGRepresentation(imgArr[i], 0.1);
                [formData appendPartWithFileData:data name:@"file" fileName:@"ios_file" mimeType:@"image/jpeg"];
            }
        }
        
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          block(@{@"status":@"220",@"error":error});
    }];
    

}
+(void)crmModule_Get_revisitRecordWithowner:(NSString*)owner  cusid:(NSString*)cusid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Get_revisitRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusid:cusid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Update_revisitRecordWithowner:(NSString*)owner  revisitRecordid:(NSString*)revisitRecordid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Update_revisitRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_revisitRecordid:revisitRecordid,
                                 Z_data:data
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Del_revisitRecordWithowner:(NSString*)owner  revisitRecordid:(NSString*)revisitRecordid  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Del_revisitRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_revisitRecordid:revisitRecordid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)crmModule_Add_cusfbRecordWithowner:(NSString*)owner comid:(NSString*)comid  fbtitle:(NSString*)fbtitle cusid:(NSString*)cusid  fbcontent:(NSString*)fbcontent  fbtype:(NSString*)fbtype  addr:(NSString*)addr  fberid:(NSString*)fberid fberName:(NSString*)fberName  fberPhone:(NSString*)fberPhone  fbTime:(NSString*)fbTime  remindTime:(NSString*)remindTime imgArr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Add_cusfbRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_comid:comid,
                                 Z_fbtitle:fbtitle,
                                 Z_cusid:cusid,
                                 Z_fbcontent:fbcontent,
                                 Z_fbtype:fbtype,
                                 Z_addr:addr,
                                 Z_fberid:fberid,
                                 Z_fberName:fberName,
                                 Z_fberPhone:fberPhone,
                                 Z_fbTime:fbTime,
                                 Z_remindTime:remindTime
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imgArr.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imgArr[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_img" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
 

}

+(void)crmModule_Get_cusfbRecordWithowner:(NSString*)owner  cusid:(NSString*)cusid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Get_cusfbRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusid:cusid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Update_cusfbRecordWithowner:(NSString*)owner  cusfbRecordid:(NSString*)cusfbRecordid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Update_cusfbRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_data:data,
                                 Z_cusfbRecordid:cusfbRecordid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)crmModule_Del_cusfbRecordWithowner:(NSString*)owner  cusfbRecordid:(NSString*)cusfbRecordid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Del_cusfbRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_cusfbRecordid:cusfbRecordid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Search_customerinfoWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Search_customerinfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_param:param
                                 };

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Search_cuscontactsInfoWithparam:(NSString*)param owner:(NSString*)owner And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Search_cuscontactsInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_param:param,
                                 Z_owner:owner
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Search_saleschanceWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Search_saleschance.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_param:param
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Search_revisitRecordWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Search_revisitRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_param:param
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)crmModule_Search_cusfbRecordWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Search_cusfbRecord.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_param:param
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)crmModule_Get_revisitRecordInfoWithowner:(NSString*)owner recordId:(NSString*)recordId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@crmModule/Get_revisitRecordInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_recordId:recordId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)FriendCircles_Add_FriendCircleWithuserGuid:(NSString*)userGuid message:(NSString*)message  name:(NSString*)name location:(NSString*)location  imgArr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Add_FriendCircle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_NAME:name,
                                 Z_location:location
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (imgArr!=nil) {
            for (int i=0; i<imgArr.count; i++) {
                NSData *tdata =UIImageJPEGRepresentation(imgArr[i], 0.1);
                [formData appendPartWithFileData:tdata name:@"file" fileName:@"ios_img.jpg" mimeType:@"image/jpeg"];
            }
        }
        
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
    
    

}

+(void)FriendCircles_Get_FriendCircle_ByCreaterWithuserGuid:(NSString*)userGuid  ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Get_FriendCircle_ByCreater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)FriendCircles_Add_FriendCircle_CommentWithuserGuid:(NSString*)userGuid  message:(NSString*)message friendCircleId:(NSString*)friendCircleId  parentId:(NSString*)parentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Add_FriendCircle_Comment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_friendCircleId:friendCircleId,
                                 Z_parentId:parentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)FriendCircles_Add_FriendCircle_ZanWithuserGuid:(NSString*)userGuid friendCircleId:(NSString*)friendCircleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Add_FriendCircle_Zan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendCircleId:friendCircleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Delete_FriendCircle_CommentWithuserGuid:(NSString*)userGuid  commentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Delete_FriendCircle_Comment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_commentId:commentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)FriendCircles_Get_FriendCircle_ByIdWithfriendCircleId:(NSString*)friendCircleId  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Get_FriendCircle_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_friendCircleId:friendCircleId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];


}
+(void)FriendCircles_Get_Comment_ByFriendCircleIdWithfriendCircleId:(NSString*)friendCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Get_Comment_ByFriendCircleId.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_friendCircleId:friendCircleId,
                                 Z_id:ID
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Get_Comment_ByIdWithcommentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Get_Comment_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_commentId:commentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Get_FriendCircle_ZanWithfriendCircleId:(NSString*)friendCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Get_FriendCircle_Zan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_id:ID,
                                 Z_friendCircleId:friendCircleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Delete_FriendCircleWithfriendCircleId:(NSString*)friendCircleId  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Delete_FriendCircle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendCircleId:friendCircleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Set_NotAllowToSeeWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Set_NotAllowToSee.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendGuid:friendGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Set_NotLookWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Set_NotLook.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_friendGuid:friendGuid,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)FriendCircles_Set_Cancle_NotAllowToSeeWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Set_Cancle_NotAllowToSee.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendGuid:friendGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)FriendCircles_Set_Cancle_NotLookWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Set_Cancle_NotLook.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendGuid:friendGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)FriendCircles_Get_NotLook_PowerWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@FriendCircles/Get_NotLook_Power.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_friendGuid:friendGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Add_collectionWithowner:(NSString*)owner imgArr:(NSArray*)imgArr tel:(NSString*)tel sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_type:@"1",
                                 Z_tel:tel,
                                 Z_sourceOwner:sourceOwner,
                                 Z_source:source
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager  POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i =0; i<imgArr.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imgArr[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_sc.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];
    
   

}

+(void)Collection_Add_collectionWithowner:(NSString*)owner title:(NSString*)title ccontent:(NSString*)ccontent tel:(NSString*)tel sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_title:title,
                                 Z_ccontent:ccontent,
                                 Z_type:@"2",
                                 Z_tel:tel,
                                 Z_sourceOwner:sourceOwner,
                                 Z_source:source
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Add_collectionWithowner:(NSString*)owner type:(NSString*)type  title:(NSString*)title ccontent:(NSString*)ccontent imgArr:(NSArray*)imgArr tel:(NSString*)tel  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_type:type,
                                 Z_title:title,
                                 Z_ccontent:ccontent,
                                 Z_tel:tel
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imgArr.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imgArr[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_sc.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
    

}

+(void)Collection_Add_collectionWithowner:(NSString*)owner  data:(NSData*)data tel:(NSString*)tel ccontent:(NSString*)ccontent sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_type:@"5",
                                 Z_tel:tel,
                                 Z_ccontent:ccontent,
                                 Z_sourceOwner:sourceOwner,
                                 Z_source:source
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_yuyin.mp3" mimeType:@"amr/mp3/wmr"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"==进度表==%@",uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
   

}
+(void)Collection_Add_collectionWithowner:(NSString*)owner  position:(NSString*)position ccontent:(NSString*)ccontent sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_position:position,
                                 Z_ccontent:ccontent,
                                 Z_type:@"6",
                                 Z_sourceOwner:sourceOwner,
                                 Z_source:source
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Collection_Add_collectionWithowner:(NSString*)owner  title:(NSString*)title url:(NSString*)url source:(NSString*)source  sourceOwner:(NSString*)sourceOwner And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_title:title,
                                 Z_url:url,
                                 Z_source:source,
                                 Z_sourceOwner:sourceOwner,
                                 Z_type:@"7"
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Add_collectionWithowner:(NSString*)owner url:(NSString*)url source:(NSString*)source  sourceOwner:(NSString*)sourceOwner And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_url:url,
                                 Z_source:source,
                                 Z_sourceOwner:sourceOwner,
                                 Z_type:@"8"
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Add_collectionWithowner:(NSString*)owner  title:(NSString*)title url:(NSString*)url source:(NSString*)source  sourceOwner:(NSString*)sourceOwner ccontent:(NSString*)ccontent And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_title:title,
                                 Z_url:url,
                                 Z_source:source,
                                 Z_sourceOwner:sourceOwner,
                                 Z_ccontent:ccontent,
                                 Z_type:@"9"
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Add_collectionGroupWithowner:(NSString*)owner  name:(NSString*)name And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Add_collectionGroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_NAME:name
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Get_collectionGroupsWithowner:(NSString*)owner And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Get_collectionGroups.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Update_collectionGroupWithowner:(NSString*)owner groupid:(NSString*)groupid name:(NSString*)name And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Update_collectionGroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_NAME:name,
                                 Z_groupid:groupid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Collection_Del_collectionGroupWithowner:(NSString*)owner groupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Del_collectionGroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_groupid:groupid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Get_collectionsWithowner:(NSString*)owner  group:(NSString*)group page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Get_collections.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_page:page,
                                 Z_group:group
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Collection_Del_collectionsWithowner:(NSString*)owner  collections:(NSString*)collections And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Del_collections.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_collections:collections
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Collection_Move_collectionGroupWithowner:(NSString*)owner  collections:(NSString*)collections groupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Move_collectionGroup.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_collections:collections,
                                 Z_groupid:groupid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Update_collectionWithowner:(NSString*)owner collid:(NSString*)collid type:(NSString*)type  title:(NSString*)title ccontent:(NSString*)ccontent And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Update_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_collid:collid,
                                 Z_type:type,
                                 Z_title:title,
                                 Z_ccontent:ccontent
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Collection_Search_collectionWithowner:(NSString*)owner  ccontent:(NSString*)ccontent  type:(NSString*)type  page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Collection/Search_collection.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_owner:owner,
                                 Z_ccontent:ccontent,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_MyQuitInfoWithcompanyId:(NSString*)companyId  userGuid:(NSString*)userGuid  type:(NSString*)type  page:(NSString*)page  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_MyQuitInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)User_GetQuitRecord_ListWithcompanyId:(NSString*)companyId  userGuid:(NSString*)userGuid type:(NSString*)type  page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@User_GetQuitRecord_List.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Quit_Get_Quit_ByHRWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Quit/Get_Quit_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Quit_Set_Quit_ByLeaderWithquitId:(NSString*)quitId  userGuid:(NSString*)userGuid message:(NSString*)message  type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Quit/Set_Quit_ByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_quitId:quitId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Quit_Set_Quit_ByHRWithquitId:(NSString*)quitId  userGuid:(NSString*)userGuid message:(NSString*)message  type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Quit/Set_Quit_ByHR.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_quitId:quitId,
                                 Z_userGuid:userGuid,
                                 Z_message:message,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Add_QuitCheckerWithcompanyId:(NSString*)companyId  userGUid:(NSString*)userGUid  cheker:(NSString*)cheker  departmentIds:(NSString*)departmentIds And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Add_QuitChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGUid:userGUid,
                                 Z_cheker:cheker,
                                 Z_departmentIds:departmentIds
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Get_QuitCheckerWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_QuitChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)SetUp_Update_QuitDpartmetnsWithquitchekcId:(NSString*)quitchekcId userGuid:(NSString*)userGuid departmentIds:(NSString*)departmentIds companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_QuitDpartmetns.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_quitchekcId:quitchekcId,
                                 Z_userGuid:userGuid,
                                 Z_departmentIds:departmentIds,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Update_QuitUserWithquitchekcId:(NSString*)quitchekcId userGuid:(NSString*)userGuid checker:(NSString*)checker  companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Update_QuitUser.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_quitchekcId:quitchekcId,
                                 Z_userGuid:userGuid,
                                 Z_checker:checker,
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Delete_QuitCheckerWithcompanyId:(NSString*)companyId userGUid:(NSString*)userGUid quitchekcId:(NSString*)quitchekcId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Delete_QuitChecker.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGUid:userGUid,
                                 Z_quitchekcId:quitchekcId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_ResetCount_MsgCodeWithuserGuid:(NSString*)userGuid code:(NSString*)code And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/ResetCount_MsgCode.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_code:code
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)userashx_GetCount_MsgCodeWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@userashx/GetCount_MsgCode.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Get_Department_ByPowerWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_Department_ByPower.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Set_Admin_ByCompanyWithcompanyId:(NSString*)companyId  userGuid:(NSString*)userGuid  objecter:(NSString*)objecter And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Set_Admin_ByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId,
                                 Z_userGuid:userGuid,
                                 Z_objecter:objecter
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Extended_Get_VersionInfoWithtype:(NSString*)type  version:(NSString*)version And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Extended/Get_VersionInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_type:type,
                                 Z_version:version
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Extended_Get_adImageAnd:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Extended/Get_adImage.ashx",HTTP_HEAD];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)SetUp_Get_Company_AdminWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@SetUp/Get_Company_Admin.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyId:companyId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Get_post_XYrenshuWithpostid:(NSString*)postid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Get_post_XYrenshu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_postid:postid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Get_post_DLZrenshuWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid  postid:(NSString*)postid nday:(NSString*)nday And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Get_post_DLZrenshu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_postid:postid,
                                 Z_nday:nday
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)manPowerNeed_Add_mpnWithuserGuid:(NSString*)userGuid  depid:(NSString*)depid postid:(NSString*)postid XYrenshu:(NSString*)XYrenshu DLZrenshu:(NSString*)DLZrenshu recruitRenShu:(NSString*)recruitRenShu recruitReason:(NSString*)recruitReason demandAtWorkTime:(NSString*)demandAtWorkTime  remark:(NSString*)remark recruitType:(NSString*)recruitType comid:(NSString*)comid createrName:(NSString*)createrName And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Add_mpn.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_depid:depid,
                                 Z_postid:postid,
                                 Z_XYrenshu:XYrenshu,
                                 Z_DLZrenshu:DLZrenshu,
                                 Z_recruitRenShu:recruitRenShu,
                                 Z_recruitReason:recruitReason,
                                 Z_demandAtWorkTime:demandAtWorkTime,
                                 Z_remark:remark,
                                 Z_recruitType:recruitType,
                                 Z_comid:comid,
                                 Z_createrName:createrName
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)manPowerNeed_Check_mpnWithuserGuid:(NSString*)userGuid mpnId:(NSString*)mpnId isapproved:(NSString*)isapproved remark:(NSString*)remark And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Check_mpn.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_mpnId:mpnId,
                                 Z_isapproved:isapproved,
                                 Z_remark:remark
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)manPowerNeed_Get_uncheckmpnl_admWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Get_uncheckmpnl_adm.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)manPowerNeed_Get_checked_mpnl_admWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Get_checked_mpnl_adm.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)manPowerNeed_Get_mpns_createrWithuserGuid:(NSString*)userGuid status:(NSString*)status page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Get_mpns_creater.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_status:status,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)manPowerNeed_Get_mpn_detailInfoWithuserGuid:(NSString*)userGuid mpnId:(NSString*)mpnId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Get_mpn_detailInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_mpnId:mpnId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)manPowerNeed_Close_mpnWithuserGuid:(NSString*)userGuid mpnId:(NSString*)mpnId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@manPowerNeed/Close_mpn.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_mpnId:mpnId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Set_vehicleAdminWithuserGuid:(NSString*)userGuid comid:(NSString*)comid adminGuid:(NSString*)adminGuid  adminName:(NSString*)adminName type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Set_vehicleAdmin.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_adminGuid:adminGuid,
                                 Z_adminName:adminName,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Create_postdetailinfoWithcompanyid:(NSString*)companyid postid:(NSString*)postid postName:(NSString*)postName depName:(NSString*)depName jobNature:(NSString*)jobNature salaryRange:(NSString*)salaryRange workdesc:(NSString*)workdesc educationcla:(NSString*)educationcla workexpecla:(NSString*)workexpecla agecla:(NSString*)agecla sexcla:(NSString*)sexcla pfskills:(NSString*)pfskills postgenre:(NSString*)postgenre creater:(NSString*)creater numOfStaff:(NSString*)numOfStaff And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Create_postdetailinfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_companyid:companyid,
                                 Z_postid:postid,
                                 Z_postName:postName,
                                 Z_depName:depName,
                                 Z_jobNature:jobNature,
                                 Z_salaryRange:salaryRange,
                                 Z_workdesc:workdesc,
                                 Z_educationcla:educationcla,
                                 Z_workexpecla:workexpecla,
                                 Z_agecla:agecla,
                                 Z_sexcla:sexcla,
                                 Z_pfskills:pfskills,
                                 Z_postgenre:postgenre,
                                 Z_creater:creater,
                                 Z_BZrenshu:numOfStaff
                                 };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Update_postdetailinfoWithuserGuid:(NSString*)userGuid recordid:(NSString*)recordid data:(NSString*)data And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Update_postdetailinfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_recordid:recordid,
                                 Z_data:data
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Del_postdetailinfoWithuserGuid:(NSString*)userGuid recordid:(NSString*)recordid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Del_postdetailinfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_recordid:recordid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Adminget_postdetailinfoWithpostid:(NSString*)postid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Adminget_postdetailinfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_postid:postid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Get_postRenShu_AllTypeWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid postid:(NSString*)postid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Get_postRenShu_AllType.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_postid:postid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Add_newVehicleInfoWithcomid:(NSString*)comid userGuid:(NSString*)userGuid plateNumber:(NSString*)plateNumber VIN:(NSString*)VIN engineCode:(NSString*)engineCode vehicleType:(NSString*)vehicleType color:(NSString*)color seats:(NSString*)seats purchaseDate:(NSString*)purchaseDate annInspectDate:(NSString*)annInspectDate insuranceEndDate:(NSString*)insuranceEndDate  purchasePrice:(NSString*)purchasePrice remark:(NSString*)remark arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Add_newVehicleInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_comid:comid,
                                 Z_userGuid:userGuid,
                                 Z_plateNumber:plateNumber,
                                 Z_VIN:VIN,
                                 Z_engineCode:engineCode,
                                 Z_vehicleType:vehicleType,
                                 Z_color:color,
                                 Z_seats:seats,
                                 Z_purchaseDate:purchaseDate,
                                 Z_annInspectDate:annInspectDate,
                                 Z_insuranceEndDate:insuranceEndDate,
                                 Z_purchasePrice:purchasePrice,
                                 Z_remark:remark
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<arr_imgs.count; i++) {
            NSData  *data = UIImageJPEGRepresentation(arr_imgs[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
   

}
+(void)Com_Vehicle_Get_vehicleListWithuserGuid:(NSString*)userGuid comid:(NSString*)comid  page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleList.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Update_vehicleInfoWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId data:(NSString*)data And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Update_vehicleInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_vehicleId:vehicleId,
                                 Z_data:data
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Del_vehicleInfoWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Del_vehicleInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Get_vehicleDetailInfoWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleDetailInfo.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Get_vehicleApplyTimesWithvehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleApplyTimes.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_GetAvaVehiclesByTimeWithcomid:(NSString*)comid startTime:(NSString*)startTime endTime:(NSString*)endTime And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/GetAvaVehiclesByTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_comid:comid,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Add_vehicleApplyWithcomid:(NSString*)comid vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber applyer:(NSString*)applyer applyerName:(NSString*)applyerName applyerDepId:(NSString*)applyerDepId applyerDepName:(NSString*)applyerDepName startTime:(NSString*)startTime endTime:(NSString*)endTime origin:(NSString*)origin destination:(NSString*)destination theDriverName:(NSString*)theDriverName personCount:(NSString*)personCount  theReason:(NSString*)theReason theCustomer:(NSString*)theCustomer theProject:(NSString*)theProject And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Add_vehicleApply.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_comid:comid,
                                 Z_vehicleId:vehicleId,
                                 Z_plateNumber:plateNumber,
                                 Z_applyer:applyer,
                                 Z_applyerName:applyerName,
                                 Z_applyerDepId:applyerDepId,
                                 Z_applyerDepName:applyerDepName,
                                 Z_startTime:startTime,
                                 Z_endTime:endTime,
                                 Z_origin:origin,
                                 Z_destination:destination,
                                 Z_theDriverName:theDriverName,
                                 Z_personCount:personCount,
                                 Z_theReason:theReason,
                                 Z_theCustomer:theCustomer,
                                 Z_theProject:theProject
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Check_vehicleApplyWithuserGuid:(NSString*)userGuid applyId:(NSString*)applyId option:(NSString*)option And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Check_vehicleApply.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_applyId:applyId,
                                 Z_option:option
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_GiveBack_vehicleWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId givebackTime:(NSString*)givebackTime startingMileage:(NSString*)startingMileage endingMileage:(NSString*)endingMileage fuelBills:(NSString*)fuelBills roadToll:(NSString*)roadToll sendee:(NSString*)sendee And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/GiveBack_vehicle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_vehicleId:vehicleId,
                                 Z_givebackTime:givebackTime,
                                 Z_startingMileage:startingMileage,
                                 Z_endingMileage:endingMileage,
                                 Z_fuelBills:fuelBills,
                                 Z_roadToll:roadToll,
                                 Z_sendee:sendee
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Add_repairedRecordVWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber type:(NSString*)type agent:(NSString*)agent when:(NSString*)when cost:(NSString*)cost where:(NSString*)where remark:(NSString*)remark arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Add_repairedRecordV.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_createrName:createrName,
                                 Z_vehicleId:vehicleId,
                                 Z_plateNumber:plateNumber,
                                 Z_type:type,
                                 Z_agent:agent,
                                 Z_when:when,
                                 Z_cost:cost,
                                 Z_where:where,
                                 Z_remark:remark
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<arr_imgs.count; i++) {
            NSData *data = UIImageJPEGRepresentation(arr_imgs[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          block(@{@"status":@"220",@"error":error});
    }];
    
    

}

+(void)Com_Vehicle_Get_vehicleRepairVWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleRepairV.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page,
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Add_vehiclelllegalWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber personLiableName:(NSString*)personLiableName theFine:(NSString*)theFine theDate:(NSString*)theDate theReason:(NSString*)theReason  isdone:(NSString*)isdone arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Add_vehiclelllegal.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_createrName:createrName,Z_vehicleId:vehicleId,
                                 Z_plateNumber:plateNumber,
                                 Z_personLiableName:personLiableName,
                                 Z_theFine:theFine,
                                 Z_theDate:theDate,
                                 Z_theReason:theReason,
                                 Z_isdone:isdone
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<arr_imgs.count; i++) {
            NSData *data =UIImageJPEGRepresentation(arr_imgs[i], 0.1);
        [formData appendPartWithFileData:data name:@"file" fileName:@"ios_.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
   

}

+(void)Com_Vehicle_Get_vehiclelllegalWithuserGuid:(NSString*)userGuid comid:(NSString*)comid  page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehiclelllegal.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page,
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Add_vehicleAccidentWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber personLiableName:(NSString*)personLiableName theTime:(NSString*)theTime thePlace:(NSString*)thePlace dutyRatio:(NSString*)dutyRatio cost:(NSString*)cost remark:(NSString*)remark arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Add_vehicleAccident.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_createrName:createrName,
                                 Z_vehicleId:vehicleId,
                                 Z_plateNumber:plateNumber,
                                 Z_personLiableName:personLiableName,
                                 Z_theTime:theTime,
                                 Z_thePlace:thePlace,
                                 Z_dutyRatio:dutyRatio,
                                 Z_cost:cost,
                                 Z_remark:remark
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<arr_imgs.count; i++) {
            NSData *data = UIImageJPEGRepresentation(arr_imgs[i], 0.1);
            [formData appendPartWithFileData:data name:@"file" fileName:@"ios_.jpg" mimeType:@"image/jpeg"];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    
    

}

+(void)Com_Vehicle_Get_vehicleAccidentWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleAccident.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page,
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Add_vehicleInsuranceWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber InsuranceCompany:(NSString*)InsuranceCompany InsuranceType:(NSString*)InsuranceType money:(NSString*)money theDate:(NSString*)theDate mileageThen:(NSString*)mileageThen agent:(NSString*)agent remark:(NSString*)remark And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Add_vehicleInsurance.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_createrName:createrName,
                                 Z_vehicleId:vehicleId,
                                 Z_plateNumber:plateNumber,
                                 Z_InsuranceCompany:InsuranceCompany,
                                 Z_InsuranceType:InsuranceType,
                                 Z_money:money,
                                 Z_theDate:theDate,
                                 Z_mileageThen:mileageThen,
                                 Z_agent:agent,
                                 Z_remark:remark
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Get_vehicleInsuranceWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleInsurance.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_page:page,
                                 Z_vehicleId:vehicleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Get_vehicleCListByLeaderWithuserGuid:(NSString*)userGuid comid:(NSString*)comid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleCListByLeader.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Get_vehicleCListByVAdminWithuserGuid:(NSString*)userGuid comid:(NSString*)comid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleCListByVAdmin.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Get_VApplyList_applientWithuserGuid:(NSString*)userGuid comid:(NSString*)comid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_VApplyList_applient.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_type:type,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Get_vehiApplyDetailWithuserGuid:(NSString*)userGuid comid:(NSString*)comid applicationId:(NSString*)applicationId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehiApplyDetail.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_applicationId:applicationId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Com_Vehicle_Get_vehicleUsedListWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleUsedList.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_vehicleId:vehicleId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Com_Vehicle_Get_vehicleUsedDetailWithuserGuid:(NSString*)userGuid comid:(NSString*)comid recordId:(NSString*)recordId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Com/Vehicle/Get_vehicleUsedDetail.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_comid:comid,
                                 Z_recordId:recordId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_ArticleWithmenuId:(NSString*)menuId userGuid:(NSString*)userGuid title:(NSString*)title content:(NSString*)content homeImage:(NSString*)homeImage label:(NSString*)label source:(NSString*)source companyId:(NSString*)companyId textContent:(NSString*)textContent  And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_menuId:menuId,
                                 Z_title:title,
                                 Z_content:content,
                                 Z_homeImage:homeImage,
                                 Z_label:label,
                                 Z_source:source,
                                 Z_companyId:companyId,
                                 Z_textContent:textContent
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_ArticleMenuWIthuserGuid:(NSString*)userGuid menuName:(NSString*)menuName And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_ArticleMenu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_menuName:menuName
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Get_ArticleMenuWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_ArticleMenu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Update_ArticleMenuWithuserGuid:(NSString*)userGuid articleMenuId:(NSString*)articleMenuId articleMenuName:(NSString*)articleMenuName And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Update_ArticleMenu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleMenuId:articleMenuId,
                                 Z_articleMenuName:articleMenuName
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Delete_ArticleMenuWithuserGuid:(NSString*)userGuid articleMenuId:(NSString*)articleMenuId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Delete_ArticleMenu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleMenuId:articleMenuId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_RecycleWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_Recycle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Delete_ArticleRecycleWithuserGuid:(NSString*)userGuid  articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Delete_ArticleRecycle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Article_RecoveryWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Article_Recovery.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_Article_DraftWithuserGuid:(NSString*)userGuid title:(NSString*)title content:(NSString*)content menuId:(NSString*)menuId textContent:(NSString*)textContent And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article_Draft.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_title:title,
                                 Z_content:content,
                                 Z_menuId:menuId,
                                 Z_textContent:textContent
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_ByMenuWithuserGuid:(NSString*)userGuid menuId:(NSString*)menuId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ByMenu.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_menuId:menuId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Delete_ArticleWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Delete_Article.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Update_ArticleWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId articleTitle:(NSString*)articleTitle articleContent:(NSString*)articleContent textContent:(NSString*)textContent And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Update_Article.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId,
                                 Z_articleTitle:articleTitle,
                                 Z_articleContent:articleContent,
                                 Z_textContent:textContent
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Add_Article_ByDraftWithmenuId:(NSString*)menuId userGuid:(NSString*)userGuid title:(NSString*)title content:(NSString*)content homeImage:(NSString*)homeImage label:(NSString*)label source:(NSString*)source companyId:(NSString*)companyId textContent:(NSString*)textContent draftId:(NSString*)draftId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article_ByDraft.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_menuId:menuId,
                                 Z_userGuid:userGuid,
                                 Z_title:title,
                                 Z_content:content,
                                 Z_homeImage:homeImage,
                                 Z_label:label,
                                 Z_source:source,
                                 Z_companyId:companyId,
                                 Z_textContent:textContent,
                                 Z_draftId:draftId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_BySearchWithpara:(NSString*)para  page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_BySearch.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_page:page,
                                 Z_para:para,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_ArtcielCommentWithuserGuid:(NSString*)userGuid  articleId:(NSString*)articleId parentid:(NSString*)parentid content:(NSString*)content parentUserGuid:(NSString*)parentUserGuid firstCommentId:(NSString*)firstCommentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_ArtcielComment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId,
                                 Z_parentid:parentid,
                                 Z_content:content,
                                 Z_parentUserGuid:parentUserGuid,
                                 Z_firstCommentId:firstCommentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_ArticleCommentWitharticleId:(NSString*)articleId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_ArticleComment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_articleId:articleId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Delete_ArticleCommentWithuserGuid:(NSString*)userGuid articleCommentId:(NSString*)articleCommentId articleId:(NSString*)articleId type:(NSString*)type And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Delete_ArticleComment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleCommentId:articleCommentId,
                                 Z_articleId:articleId,
                                 Z_type:type
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_ArticleComment_ZanWithuserGuid:(NSString*)userGuid articleCommentId:(NSString*)articleCommentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_ArticleComment_Zan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleCommentId:articleCommentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_ByIdWitharticleId:(NSString*)articleId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ById.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_articleId:articleId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_CommitImageWithimg:(UIImage*)img And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/CommitImage.ashx",HTTP_HEAD];
//    NSDictionary *pra = @{};
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *tdata = UIImageJPEGRepresentation(img, 0.1);
        [formData appendPartWithFileData:tdata name:@"image" fileName:@"ios_.jpg" mimeType:@"image/jpeg"];
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         block(@{@"status":@"220",@"error":error});
    }];
    

}

+(void)Articles_Get_ArticleWithpage:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Set_Article_BoutiqueWithuserGuid:(NSString*)userGuid  articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Set_Article_Boutique.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Get_Article_ByBoutiqueWithpage:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ByBoutique.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Get_ArticleByCompanyWithpage:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_ArticleByCompany.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_Article_AttentionWithuserGuid:(NSString*)userGuid attention:(NSString*)attention And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article_Attention.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_attention:attention
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Cancle_ArticleAttentionWithuserGuid:(NSString*)userGuid  author:(NSString*)author And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Cancle_ArticleAttention.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_author:author
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_AttentionWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_Attention.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_MyFansWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_MyFans.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_ByAttentionWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ByAttention.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_ByTimeWithpage:(NSString*)page time:(NSString*)time And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ByTime.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_page:page,
                                 Z_time:time
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_ByLableWithlable:(NSString*)lable page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ByLable.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_label:lable,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_Article_ZanWitharticleId:(NSString*)articleId  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article_Zan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_articleId:articleId,
                                 Z_userGuid:userGuid
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_Article_ByZanWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_Article_ByZan.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_Article_ReportWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId reason:(NSString*)reason reportType:(NSString*)reportType And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article_Report.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId,
                                 Z_reason:reason,
                                 Z_reportType:reportType
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
+(void)Articles_Get_ChildCommentWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId firstCommentId:(NSString*)firstCommentId page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_ChildComment.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId,
                                 Z_firstCommentId:firstCommentId,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_ArticleCommentsWithuserGuid:(NSString*)userGuid articleCommentId:(NSString*)articleCommentId And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_ArticleComments.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleCommentId:articleCommentId
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Get_MyArticleWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Get_MyArticle.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_page:page
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}

+(void)Articles_Add_Article_Comment_ReportWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId articleCommentId:(NSString*)articleCommentId reason:(NSString*)reason reportType:(NSString*)reportType And:(void(^)(NSDictionary *dic))block
{
    NSString *urlString = [NSString stringWithFormat:@"%@Articles/Add_Article_Comment_Report.ashx",HTTP_HEAD];
    NSDictionary *parameters = @{
                                 Z_userGuid:userGuid,
                                 Z_articleId:articleId,
                                 Z_articleCommentId:articleCommentId,
                                 Z_reason:reason,
                                 Z_reportType:reportType
                                 };
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic1 =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        block(dic1);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(@{@"status":@"220",@"error":error});
    }];

}
@end
