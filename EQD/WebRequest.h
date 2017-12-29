//
//  WebRequest.h
//  EQD
//
//  Created by 梁新帅 on 2017/3/18.
//  Copyright © 2017年 FitBoy. All rights reserved.
//  tableV的  滚动禁止 

#define  adjustsScrollViewInsets_NO(scrollView,vc)\
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
if ([UIScrollView instancesRespondToSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:")]) {\
[scrollView   performSelector:NSSelectorFromString(@"setContentInsetAdjustmentBehavior:") withObject:@(2)];\
} else {\
vc.automaticallyAdjustsScrollViewInsets = NO;\
}\
_Pragma("clang diagnostic pop") \
} while (0)
#define DEVICE_TABBAR_Height CGRectGetMaxY(self.navigationController.navigationBar.frame)
#define DEVICE_HEIGHT  [UIScreen mainScreen].bounds.size.height
#define DEVICE_WIDTH   [UIScreen mainScreen].bounds.size.width
#define USERDEFAULTS  [NSUserDefaults standardUserDefaults]
#define Y_ManagerId @"Y_ManagerId"
#define Y_ManagerName @"Y_ManagerName"
#define EQDCOLOR   [UIColor colorWithRed:0 green:116/255.0 blue:250/255.0 alpha:1]
#define APPKEY_RongCloud  @"tdrvipkstf095"
#define APPKEY_SMS  @"17e1ba8f63685"
#define SECRET_SMS  @"2a81e3d4a8c200d3bfb25a6aa0bb8748"
#define AMAP_KEY @"e78b213b09f4d884a5483d0e9613d2d1"
#define Y_first_Start @"first_Start"
#define Y_type @"Y_type"
#define YQDCOLOR   [UIColor colorWithRed:0 green:157/255.0 blue:237/255.0 alpha:1]
#define Y_USERINFO @"userInfo"
#define RC_TOKEN @"token"
#define Z_U1 @"u1"
#define Z_U2 @"u2"
#define Z_password @"password"
#define Z_TEMP @"temp"
#define Z_TEMAIL  @"temail"
#define Z_ANAME  @"aname"
#define Z_APASS  @"apass"
#define Z_RAN @"ran"
#define Y_STATUS @"status"
#define Y_MSG @"msg"
#define  Y_AMAP_address @"AMAP_address"
#define Y_AMAP_cityProvince  @"Y_AMAP_cityProvince"
#define Y_AMAP_coordation @"AMAP_coordation"
#define Y_MIMA @"Ymima"
#define Y_zhanghao @"Yzhanghao"
#define Y_ITEMS @"items"
#define Z_USERID @"userid"
#define Z_userId @"userId"
#define Z_commentId @"commentId"
#define Z_userid @"userid"
#define Z_FRIENDID @"friendid"
#define Z_addcontent @"addcontent"
#define Z_content @"content"
#define Z_homeImage @"homeImage"
#define Z_label @"label"
#define Z_IPHOTO @"iphoto"
#define Z_IDNUM @"idnum"
#define Z_photoexplain @"photoexplain"
#define Z_num @"num"
#define Z_CID @"cid"
#define Z_id @"id"
#define Z_Id @"Id"
#define Z_checkend @"checkend"
#define Z_checkexplain @"checkexplain"
#define Z_tname @"tname"
#define Z_tparent @"tparent"
#define Z_tdutyname @"tdutyname"
#define Z_tdutynum @"tdutynum"
#define Z_sickLeaveId @"sickLeaveId"
#define Z_tassisname @"tassisname"
#define Z_tassisnum @"tassisnum"
#define Z_tinforname @"tinforname"
#define Z_tinfonum @"tinfonum"
#define Z_tbegintimes @"tbegintimes"
#define Z_tendtimes @"tendtimes"
#define Z_tcheckstandard @"tcheckstandard"
#define Z_tduty @"tduty"
#define Z_tcreateman @"tcreateman"
#define Z_tcomid @"tcomid"
#define Z_status @"status"
#define Z_bossid @"bossid"
#define Z_csec @"csec"
#define Z_cpost @"cpost"
#define Z_SEX @"sex"
#define Z_age @"age"
#define Z_heigh @"heigh"
#define Z_weigh @"weigh"
#define Z_blood @"blood"
#define Z_czodia @"czodia"
#define Z_belief @"belief"
#define Z_politicstate @"politicstate"
#define Z_interest @"interest"
#define Z_padress @"padress"
#define Z_marry @"marry"
#define Z_contactname @"contactname"
#define Z_scontact @"scontact"
#define Z_scontactrelat @"scontactrelat"
#define Z_qq @"qq"
#define Z_wchat @"wchat"
#define Z_careertype @"careertype"
#define Z_careername @"careername"
#define Z_postname @"postname"
#define Z_postnum @"postnum"
#define Z_grad @"grad"
#define Z_edu @"edu"
#define Z_pskill @"pskill"
#define Z_foreignclass @"foreignclass"
#define Z_socialsecuritynum @"socialsecuritynum"
#define Z_date @"date"
#define Z_rdate @"rdate"
#define Z_NATION @"nation"
#define Z_houseadress @"houseadress"
#define Z_housetype @"housetype"
#define Z_mail @"mail"
#define Z_BRITH @"birth"
#define Z_PNATIVE @"pnative"
#define Z_EMAIL @"email"
#define Z_UNAME @"uname"
#define Z_NAME @"name"
#define Z_groupid @"groupid"
#define Z_dep @"dep"
#define Z_location @"location"
#define Z_portraitUri @"portraitUri"
#define Z_UID @"uid"
#define Z_account @"account"
#define Z_userGuid @"userGuid"
#define Z_author @"author"
#define Z_attentionId @"attentionId"
#define Z_attention @"attention"
#define Z_articleCommentId  @"articleCommentId"
#define Z_articleId @"articleId"
#define Z_parentid @"parentid"
#define Z_content @"content"
#define Z_parentUserGuid @"parentUserGuid"
#define Z_firstCommentId @"firstCommentId"
#define Z_articleTitle @"articleTitle"
#define Z_articleContent @"articleContent"
#define Z_articleMenuId @"articleMenuId"
#define Z_articleMenuName @"articleMenuName"
#define Z_menuName @"menuName"
#define Z_menuId @"menuId"
#define Z_title @"title"
#define Z_province @"province"
#define Z_city @"city"
#define Z_area @"area"
#define Z_plateNumber @"plateNumber"
#define Z_InsuranceCompany @"InsuranceCompany"
#define Z_InsuranceType @"InsuranceType"
#define Z_money @"money"
#define Z_personLiableName @"personLiableName"
#define Z_theTime @"theTime"
#define Z_thePlace @"thePlace"
#define Z_dutyRatio @"dutyRatio"
#define Z_theFine @"theFine"
#define Z_theDate @"theDate"
#define Z_mileageThen @"mileageThen"
#define Z_applyer @"applyer"
#define Z_applyId @"applyId"
#define Z_option @"option"
#define Z_applyerName @"applyerName"
#define Z_applyerDepId @"applyerDepId"
#define Z_applyerDepName @"applyerDepName"
#define Z_VIN @"VIN"
#define Z_engineCode @"engineCode"
#define Z_vehicleType @"vehicleType"
#define Z_color @"color"
#define Z_seats @"seats"
#define Z_purchaseDate @"purchaseDate"
#define Z_annInspectDate @"annInspectDate"
#define Z_insuranceEndDate @"insuranceEndDate"
#define Z_purchasePrice @"purchasePrice"
#define Z_remark @"remark"
#define Z_mpnId @"mpnId"
#define Z_isapproved @"isapproved"
#define Z_depid @"depid"
#define Z_userGUid @"userGUid"
#define Z_eqdCodeNew @"eqdCodeNew"
#define Z_peuserGuid @"peuserGuid"
#define Z_projectepid @"projectepid"
#define Z_ownedCompany @"ownedCompany"
#define Z_projectName @"projectName"
#define Z_workepid @"workepid"
#define Z_weuserGuid @"weuserGuid"
#define Z_workepid @"workepid"
#define Z_seeDate @"seeDate"
#define Z_eventName @"eventName"
#define Z_signature @"signature"
#define Z_missClockId @"missClockId"
#define Z_memoid @"memoid"
#define Z_sickleaveId @"sickleaveId"
#define Z_choseDate @"choseDate"
#define Z_ids @"ids"
#define Z_reason @"reason"
#define Z_reportType @"reportType"
#define Z_witness @"witness"
#define Z_liaisonBookId @"liaisonBookId"
#define Z_createDepartId @"createDepartId"
#define Z_minTime @"minTime"
#define Z_maxTime @"maxTime"
#define Z_Month @"Month"
#define Z_offId @"offId"
#define Z_changeShiftId @"changeShiftId"
#define Z_changeShiftReason @"changeShiftReason"
#define Z_ruleName @"ruleName"
#define Z_ruleDescribe @"ruleDescribe"
#define Z_approver @"approver"
#define Z_taskId @"taskId"
#define Z_TaskName @"TaskName"
#define Z_ParentTaskId @"ParentTaskId"
#define Z_recipient @"recipient"
#define Z_assist @"assist"
#define Z_notify @"notify"
#define Z_startTime @"startTime"
#define Z_startDate @"startDate"
#define Z_endDate @"endDate"
#define Z_para @"para"
#define Z_endTime @"endTime"
#define Z_origin @"origin"
#define Z_destination @"destination"
#define Z_theDriverName @"theDriverName"
#define Z_personCount @"personCount"
#define Z_theReason @"theReason"
#define Z_isdone @"isdone"
#define Z_theCustomer @"theCustomer"
#define Z_theProject @"theProject"
#define Z_memoInfo @"memoInfo"
#define Z_eventType @"eventType"
#define Z_timeToRemind @"timeToRemind"
#define Z_checkStandard @"checkStandard"
#define Z_checker @"checker"
#define Z_cheker @"cheker"
#define Z_checkTime @"checkTime"
#define Z_duty @"duty"
#define Z_projectDescription @"projectDescription"
#define Z_projectURL @"projectURL"
#define Z_newsCycle @"newsCycle"
#define Z_isAdmin @"isAdmin"
#define Z_noticeCycle @"noticeCycle"
#define Z_noticeId @"noticeId"
#define Z_loginLocation @"loginLocation"
#define Z_upname @"upname"
#define Z_step @"step"
#define Z_joinTime @"joinTime"
#define Z_joinStartTime @"joinStartTime"
#define Z_joinEndTime @"joinEndTime"
#define Z_quitReason @"quitReason"
#define Z_quitTime @"quitTime"
#define Z_quitId @"quitId"
#define Z_quitchekcId @"quitchekcId"
#define Z_message @"message"
#define Z_friendCircleId @"friendCircleId"
#define Z_workCircleId @"workCircleId"
#define Z_quitType @"quitType"
#define Z_joinNumber @"joinNumber"
#define Z_oldPassword @"oldPassword"
#define Z_newPassword @"newPassword"
#define Z_desc @"desc"
#define Z_describe @"describe"
#define Z_isleader @"isleader"
#define Z_para @"para"
#define Z_user @"user"
#define Z_owner @"owner"
#define Z_collid @"collid"
#define Z_collections @"collections"
#define Z_position @"position"
#define Z_recordId @"recordId"
#define Z_recordid @"recordid"
#define Z_revisitRecordid @"revisitRecordid"
#define Z_contactsid @"contactsid"
#define Z_contactsName @"contactsName"
#define Z_contactsPhone @"contactsPhone"
#define Z_revisitDate @"revisitDate"
#define Z_revisitType @"revisitType"
#define Z_revisitcontent @"revisitcontent"
#define Z_cusid @"cusid"
#define Z_contacts @"contacts"
#define Z_interestproducts @"interestproducts"
#define Z_createDate @"createDate"
#define Z_exdateofcompletion @"exdateofcompletion"
#define Z_productsalesmoney @"productsalesmoney"
#define Z_expectmoney @"expectmoney"
#define Z_data @"data"
#define Z_cusfbRecordid @"cusfbRecordid"
#define Z_saleschanceid @"saleschanceid"
#define Z_labelid @"labelid"
#define Z_labelfriends @"labelfriends"
#define Z_addmembers @"addmembers"
#define Z_labelName @"labelName"
#define Z_labelfriends @"labelfriends"
#define Z_entryId @"entryId"
#define Z_userPhone @"userPhone"
#define Z_username @"username"
#define Z_ptel @"ptel"
#define Z_friendGuid @"friendGuid"
#define Z_type @"type"
#define Z_pass @"pass"
#define Z_major @"major"
#define Z_PERSONID @"personid"
#define Z_POSTNAME @"postname"
#define Z_PPARENT @"pparent"
#define Z_PDESCRIB @"pdescrib"
#define Z_COMENAME @"comname"
#define Z_codecertifi @"codecertifi"
#define Z_buslicense @"buslicense"
#define Z_productcertifi @"productcertifi"
#define Z_maincustomer @"maincustomer"
#define Z_registered @"registered"
#define Z_busScope @"busScope"
#define Z_busSetdate @"busSetdate"
#define Z_busterm @"busterm"
#define Z_mainbus @"mainbus"
#define Z_mainbusadress @"mainbusadress"
#define Z_staffnum @"staffnum"
#define Z_comId @"comId"
#define Z_comid @"comid"
#define Z_applicationId @"applicationId"
#define Z_vehicleId @"vehicleId"
#define Z_givebackTime @"givebackTime"
#define Z_startingMileage @"startingMileage"
#define Z_endingMileage @"endingMileage"
#define Z_fuelBills @"fuelBills"
#define Z_roadToll @"roadToll"
#define Z_sendee @"sendee"
#define Z_adminGuid @"adminGuid"
#define Z_adminName @"adminName"
#define Z_fbtitle @"fbtitle"
#define Z_revisitTitle @"revisitTitle"
#define Z_chanceName @"chanceName"
#define Z_chanceClassify @"chanceClassify"
#define Z_cusName @"cusName"
#define Z_cusType @"cusType"
#define Y_TextFont [UIFont systemFontOfSize:17.f]
#define Z_salesTerritory @"salesTerritory"
#define Z_simpleName @"simpleName"
#define Z_companyId @"companyId"
#define Z_textContent @"textContent"
#define Z_draftId @"draftId"
#define Z_url @"url"
#define Z_source @"source"
#define Z_sourceOwner @"sourceOwner"
#define Z_remark @"remark"
#define Z_recruitType @"recruitType"
#define Z_salesTerritoryCode @"salesTerritoryCode"
#define Z_remindTime @"remindTime"
#define Z_title @"title"
#define Z_ccontent @"ccontent"
#define Z_sort @"sort"
#define Z_imageId @"imageId"
#define Z_imageId @"imageId"
#define Z_date @"date"
#define Z_topLeader @"topLeader"
#define Z_newsId @"newsId"
#define Z_param @"param"
#define Z_newsName @"newsName"
#define Z_noticeName @"noticeName"
#define Z_objectType @"objectType"
#define Z_objectDepartId @"objectDepartId"
#define Z_newsTheme @"newsTheme"
#define Z_newsContent @"newsContent"
#define Z_noticeTheme @"noticeTheme"
#define Z_noticeContent @"noticeContent"
#define Z_approvalLevel @"approvalLevel"
#define Z_approval @"approval"
#define Z_signatory @"signatory"
#define Z_signDepartId @"signDepartId"
#define Z_signPostId @"signPostId"
#define Z_signEntryTime @"signEntryTime"
#define Z_contractType @"contractType"
#define Z_contractNature @"contractNature"
#define Z_signedNumber @"signedNumber"
#define Z_lastReason @"lastReason"
#define Z_contractForm @"contractForm"
#define Z_contractStartTime @"contractStartTime"
#define Z_contractEndTime @"contractEndTime"
#define Z_probation @"probation"
#define Z_bank @"bank"
#define Z_ProbationSalary @"ProbationSalary"
#define Z_clockTime @"clockTime"
#define Z_place @"place"
#define Z_MAC @"MAC"
#define Z_WIFIName @"WIFIName"
#define Z_phoneUUID @"phoneUUID"
#define Z_phoneType @"phoneType"
#define Z_coordinate @"coordinate"
#define Z_clockId @"clockId"
#define Z_startOverTime @"startOverTime"
#define Z_endOverTime @"endOverTime"
#define Z_times @"times"
#define Z_time @"time"
#define Z_overTimeReason @"overTimeReason"
#define Z_overTimeType @"overTimeType"
#define Z_overTimeId @"overTimeId"
#define Z_planStartTime @"planStartTime"
#define Z_planEndTime @"planEndTime"
#define Z_offStartTime @"offStartTime"
#define Z_offEndTime @"offEndTime"
#define Z_offTimes @"offTimes"
#define Z_changeShiftId @"changeShiftId"
#define Z_travelStartTime @"travelStartTime"
#define Z_travelEndTime @"travelEndTime"
#define Z_travelTimes @"travelTimes"
#define Z_travelId @"travelId"
#define Z_travelReason @"travelReason"
#define Z_travelAddress @"travelAddress"
#define Z_mapAddress @"mapAddress"
#define Z_shiftName @"shiftName"
#define Z_startTime1 @"startTime1"
#define Z_endTime1 @"endTime1"
#define Z_startTime2 @"startTime2"
#define Z_endTime2 @"endTime2"
#define Z_startTime3 @"startTime3"
#define Z_endTime3 @"endTime3"
#define Z_startTime4 @"startTime4"
#define Z_endTime4 @"endTime4"
#define Z_ruleShiftId @"ruleShiftId"
#define Z_objecter @"objecter"
#define Z_liaisonBookName @"liaisonBookName"
#define Z_liaisonBookTheme @"liaisonBookTheme"
#define Z_liaisonBookContent @"liaisonBookContent"
#define Z_timeLimit @"timeLimit"
#define Z_isReply @"isReply"
#define Z_shiftId @"shiftId"
#define Z_weeks @"weeks"
#define Z_holidays @"holidays"
#define Z_leadvStartTime @"leadvStartTime"
#define Z_leaveEndTime @"leaveEndTime"
#define Z_leaveTime @"leaveTime"
#define Z_leaveType @"leaveType"
#define Z_leaveTypeId @"leaveTypeId"
#define Z_leaveReason @"leaveReason"
#define Z_page @"page"
#define Z_group @"group"
#define Z_FB_message_received @"FB_message_received"
#define Z_getpeople @"getpeople"
#define Z_company @"company"
#define Z_companyid @"companyid"
#define Z_induCategoryCode @"induCategoryCode"
#define Z_induCategoryName @"induCategoryName"
#define Z_enterpriseNature @"enterpriseNature"
#define Z_enterpriseScale @"enterpriseScale"
#define Z_monthlySalary @"monthlySalary"
#define Z_phones @"phones"
#define Z_postId @"postId"
#define Z_postid @"postid"
#define Z_postName @"postName"
#define Z_depName @"depName"
#define Z_jobNature @"jobNature"
#define Z_salaryRange @"salaryRange"
#define Z_workdesc @"workdesc"
#define Z_educationcla @"educationcla"
#define Z_workexpecla @"workexpecla"
#define Z_agecla @"agecla"
#define Z_sexcla @"sexcla"
#define Z_pfskills @"pfskills"
#define Z_postgenre @"postgenre"
#define Z_creater @"creater"
#define Z_createrName @"createrName"
#define Z_BZrenshu @"BZrenshu"
#define Z_XYrenshu @"XYrenshu"
#define Z_DLZrenshu @"DLZrenshu"
#define Z_recruitRenShu @"recruitRenShu"
#define Z_recruitReason @"recruitReason"
#define Z_demandAtWorkTime @"demandAtWorkTime"
#define Z_nday @"nday"
#define Z_departId @"departId"
#define Z_objectCompanyId @"objectCompanyId"
#define Z_taskDesc @"taskDesc"
#define Z_department @"department"
#define Z_departmentId @"departmentId"
#define Z_departmentIds @"departmentIds"
#define Z_parentId @"parentId"
#define Z_ParentId @"ParentId"
#define Z_com @"com"
#define Z_sec @"sec"
#define Z_people @"people"
#define Z_post @"post"
#define Z_cellphone @"cellphone"
#define Z_conqq @"conqq"
#define Z_conwx @"conwx"
#define Z_jobDescri @"jobDescri"
#define Z_isOvert @"isOvert"
#define Z_tel @"tel"
#define Z_text @"text"
#define Z_tempid @"tempid"
#define Z_recipients @"recipients"
#define Z_code @"code"
#define Z_msgid @"msgid"
#define Z_entel @"entel"
#define Z_ensec @"ensec"
#define Z_enpost @"enpost"
#define Z_enpostnum @"enpostnum"
#define Z_PID @"pid"
#define  Z_dutyman @"dutyman"
#define Z_dutyIDnum @"dutyIDnum"
#define Z_dutytel @"dutytel"
#define Z_type @"type"
#define Z_agent @"agent"
#define Z_when @"when"
#define Z_cost @"cost"
#define Z_where @"where"
#define Z_version @"version"
#define Z_bankCard @"bankCard"
#define Z_openBank @"openBank"
#define Z_leaveId @"leaveId"
#define Z_hangye @"hangye"
#define Z_address @"address"
#define Z_latAndLong @"latAndLong"
#define Z_cusCall @"cusCall"
#define Z_contact @"contact"
#define Z_contactway @"contactway"
#define Z_fbcontent @"fbcontent"
#define Z_fbtype @"fbtype"
#define Z_addr @"addr"
#define Z_fberid @"fberid"
#define Z_fberName @"fberName"
#define Z_fberPhone @"fberPhone"
#define Z_fbTime @"fbTime"
#define Z_contractId @"contractId"
#define Z_email @"email"
#define Z_quhao @"quhao"
#define Z_hangyehao @"hangyehao"
#define Z_GROUPID @"groupid"
#define Z_Groupid @"Groupid"
#define Z_GroupName @"GroupName"
#define Z_SYM @"sym"
#define Z_GROUPNAME @"groupname"
#define Z_GroupMembers @"GroupMembers"
#define Z_GROUPPHOTO @"groupphoto"
#define Z_RES @"res"
#define HTTP_HEAD @"https://www.eqid.top:8009/"
#define HTTP_PATH @"https://www.eqid.top:8009"
#define Y_com_user  @"Y_com_user"
#import <Foundation/Foundation.h>
#import "MBFadeAlertView.h"
#import "FBLoadingEffectView.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <CommonCrypto/CommonDigest.h>
#import "FBScanViewController.h"
#import "UserModel.h"
#import "ComModel.h"
#import <MBProgressHUD.h>
#import "Com_UserModel.h"
@interface WebRequest : NSObject
///获取登录的用户信息 *
+(UserModel*)GetUserInfo;
///更新用户的实名认证信息 *
+(BOOL)updateUserinfoWithKey:(NSString*)key value:(NSString*)value;
///判断手机号的注册易企点的情况
+(void)user_phonesWithphoneArr:(NSArray*)phoneArr companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;

///对字符串进行哈希加密*
+ (NSString *)sha1:(NSString *)inputString;
///注册  register*
+(void)user_loginWithu1:(NSString*)u1 password:(NSString*)password  And:(void(^)(NSDictionary *dic))block;
///登录 User_login1*
+(void)user_enterWithu1:(NSString*)u1 u2:(NSString*)u2  And:(void(^)(NSDictionary *dic))block;
///修改密码*
+(void)User_updatePasswordWithuserGuid:(NSString*)userGuid oldPassword:(NSString*)oldPassword  newPasswor:(NSString*)newPasswor And:(void(^)(NSDictionary *dic))block;
///通过手机号找回密码
+(void)userashx_RetrievalPwdWithtel:(NSString*)tel  code:(NSString*)code msgid:(NSString*)msgid  password:(NSString*)password  And:(void(^)(NSDictionary *dic))block;

///通过邮箱与手机号找回密码
+(void)user_backpassWithtemail:(NSString*)temail  aname:(NSString*)aname And:(void(^)(NSDictionary *dic))block;
///邮箱找回的修改密码
+(void)user_cpassWithaname:(NSString*)aname apass:(NSString*)apass ran:(NSString*)ran And:(void(^)(NSDictionary *dic))block;

// 搜索易企点号或者手机号 --
+(void)User_Friend_SeachWithuserGuid:(NSString*)userGuid account:(NSString*)account And:(void(^)(NSDictionary *dic))block;

///添加好友申请 *
+(void)User_AddFriendWithuserid:(NSString*)userid friendid:(NSString*)friendid content:(NSString*)content  And:(void(^)(NSDictionary *dic))block;
///同意或者拒绝好友  1 同意 0 拒绝 type true false*
+(void)User_Friend_OptionWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid type:(NSString*)type And:(void(^)(NSDictionary *dic))block;

///好友申请列表 *
+(void)User_AddFriend_RequestWithuid:(NSString*)uid And:(void(^)(NSDictionary *dic))block;

///删除好友 *
+(void)User_Friend_DeleteWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block;
///获取好友列表 - *
+(void)User_GetFriendListuid:(NSString*)uid And:(void(^)(NSDictionary *dic))block;

///获取融云的token *
+(void)User_RyHttpClientWithuserId:(NSString*)userId name:(NSString*)name portraitUri:(NSString*)portraitUrl And:(void(^)(NSDictionary *dic))block;
///个人实名认证 *
+(void)User_rname_authenWithiphoto:(UIImage*)iphoto idnum:(NSString*)idnum sex:(int)sex nation:(NSString*)nation brith:(NSString*)brith pnative:(NSString*)pnative email:(NSString*)email uname:(NSString*)uname name:(NSString*)name And:(void(^)(NSDictionary *dic))block;
///修改个人信息 个人档案 *
+(void)User_UpdateUserinfoWithuserGuid:(NSString*)userGuid para:(NSString*)para And:(void(^)(NSDictionary *dic))block;
///修改个人头像 *
+(void)User_Update_HeadimageWithuser:(NSString*)user userGuid:(NSString*)userGuid img:(UIImage*)img And:(void(^)(NSDictionary *dic))block;

///根据身份证图片获取 个人信息*
+(void)GetuserinfoWithimg:(UIImage *)img And:(void(^)(NSDictionary *dic))block;
///创建群组 *
+(void)User_Group_CreateWithuserid:(NSString*)userid groupid:(NSString*)groupid groupname:(NSString*)groupname GroupMembers:(NSString*)GroupMembers And:(void(^)(NSDictionary *dic))block;
///添加群成员 *
+(void)User_AddgroupWithuserGuid:(NSString*)userGuid Groupid:(NSString*)Groupid GroupName:(NSString*)GroupName And:(void(^)(NSDictionary *dic))block;
///退出群组 *
+(void)User_QuitgroupWithuserGuid:(NSString*)userGuid Groupid:(NSString*)Groupid GroupName:(NSString*)GroupName  And:(void(^)(NSDictionary *dic))block;
///解散群组 *
+(void)User_DismissgroupWithuserGuid:(NSString*)userGuid Groupid:(NSString*)Groupid And:(void(^)(NSDictionary *dic))block;
///查看群成员 *
+(void)User_GroupmemberWithgroupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block;
///修改群组信息 *
+(void)User_UpdateGroupInfoWithgroupid:(NSString*)groupid groupname:(NSString*)groupname groupphoto:(UIImage*)groupphoto And:(void(^)(NSDictionary *dic))block;
//搜索群或者查询群信息 *
+(void)Usre_SearchGroupWithgroupname:(NSString*)groupname groupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block;
///查看某个人下的群列表 *
+(void)User_GetGroupsWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;

/** 选择的 
 0：area，
 1:岗位，
 2：行业，
 3：公司经营模式
 4：公司员工规模
 5：公司体系认证
 :6：公司类型
 7：公司年营业额
 8：合同有效期
 9：合同形式
 10：文化程度
 11：社保种类
 12：合同性质
 13：工作性质
 14：民族
 15：政治面貌
 16：职业资格
 17：合同续签次数
 18：终止合同原因
 19：合同类型
 20：户口类型
 21：生肖
 22：婚配
 */
+(void)Option_AreasAndWithtype:(NSInteger)type And:(void(^)(NSArray *arr))block;

///企业注册前需要验证的手机号逻辑
+(void)User_JudgeExistWithuid:(NSString*)uid And:(void(^)(NSDictionary *dic))block;

///公司注册*
+(void)Com_loginWithcomname:(NSString*)comname comdutyman:(NSString*)comdutyman comdutyIDnum:(NSString*)comdutyIDnum comdutytel:(NSString*)comdutytel comtype:(NSString*)comtype combusi:(NSString*)combusi comadres:(NSString*)comadres comcontact:(NSString*)comcontact comemai:(NSString*)comemai uid:(NSString*)uid province:(NSString*)province city:(NSString*)city area:(NSString*)area And:(void(^)(NSDictionary *dic))block;
///获取公司的基本信息  *
+(void)Com_regiInfoWithcomId:(NSString*)comId And:(void(^)(NSDictionary *dic))block;

///获取个人档案的所有信息 *
+(void)User_StaffInfoWithuserGuid:(NSString*)userGuid password:(NSString*)password And:(void(^)(NSDictionary *dic))block;
///企业认证   *
+(void)Com_rname_authenWithimgArr:(NSArray<UIImage*>*)img codecertifinumb:(NSString*)codecertifinumb buslicensenumb:(NSString*)buslicensenumb productcertifinum:(NSString*)productcertifinum maincustomer:(NSString*)maincustomer registeredassets:(NSString*)registeredassets busscope:(NSString*)busscope bussetdate:(NSString*)bussetdate  busterm:(NSString*)busterm mainbus:(NSString*)mainbus mainbusadress:(NSString*)mainbusadress  staffnum:(NSString*)staffnum  comid:(NSString*)comid userGuid:(NSString*)userGuid user:(NSString*)user And:(void(^)(NSDictionary *dic))block;

///查询公司的所有部门  *
+(void)Com_SelectDepartmentWithCompanyId:(NSString*)CompanyId ParentId:(NSString*)ParentId And:(void(^)(NSDictionary *dic))block;
///创建部门  *
+(void)Com_CreateDepartmentWithcompanyId:(NSString*)companyId parentId:(NSString*)parentId name:(NSString*)name userGuid:(NSString*)userGuid desc:(NSString*)desc And:(void(^)(NSDictionary *dic))block;
///删除部门 *
+(void)Com_Delete_DepartWithcompanyId:(NSString*)companyId departId:(NSString*)departId And:(void(^)(NSDictionary *dic))block;
///查询部门下的职位 *
+(void)Com_SelectPostWithdepartId:(NSString*)departId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///修改部门信息*
+(void)Com_Update_DepartWithname:(NSString*)name describe:(NSString*)describe userGuid:(NSString*)userGuid ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///修改企业logo *
+(void)Com_alterLogoWithuserGuid:(NSString*)userGuid comId:(NSString*)comId img:(UIImage*)img And:(void(^)(NSDictionary *dic))block;
///创建职位 *
+(void)Com_CreatePostWithcompanyId:(NSString*)companyId departId:(NSString*)departId name:(NSString*)name type:(NSString*)type desc:(NSString*)desc isleader:(NSString*)isleader userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///修改企业简称 *
+(void)Com_alterSimpleNameWithuserGuid:(NSString*)userGuid comId:(NSString*)comId simpleName:(NSString*)simpleName And:(void(^)(NSDictionary *dic))block;
///个人实名认证 *
+(void)Com_InsertStaffInfoWithuserGuid:(NSString*)userGuid  name:(NSString*)name imagearr:(NSArray<UIImage*>*)imageArr idnum:(NSString*)idnum sex:(NSString*)sex age:(NSString*)age date:(NSString*)date rdate:(NSString*)rdate pnative:(NSString*)pnative nation:(NSString*)nation mail:(NSString*)mail housetype:(NSString*)housetype houseadress:(NSString*)houseadress ptel:(NSString*)ptel And:(void(^)(NSDictionary *dic))block;
///删除职位*
+(void)Com_Delete_PostWithpostId:(NSString*)postId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;

///修改职位信息*
+(void)Com_Update_PostWithname:(NSString*)name type:(NSString*)type desc:(NSString*)desc userGuid:(NSString*)userGuid ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;



///设置公司老板
+(void)Com_AffirmBossbossid:(NSString*)bossid cid:(NSString*)cid And:(void(^)(NSDictionary *dic))block;

///添加入驻公司的信息 status指该人的公司地位【例：主管，人事，老板】，参数见上次发送，post传其id   -1 ,1,2,3,4 表示的是权限
+(void)Com_SetPersonnelWithuid:(NSString*)uid cid:(NSString*)cid post:(NSString*)post status:(NSString*)status And:(void(^)(NSDictionary *dic))block;

///查询企业是否认证
+(void)Com_SelectAutherWithcid:(NSString*)cid And:(void(^)(NSDictionary *dic))block;
///邀请人员入驻公司*
+(void)Com_Add_NewStaffWithphones:(NSArray*)phones companyId:(NSString*)companyId company:(NSString*)company departId:(NSString*)departId department:(NSString*)department postId:(NSString*)postId post:(NSString*)post userGuid:(NSString*)userGuid user:(NSString*)user And:(void(^)(NSDictionary *dic))block;
///获取部门下的人员信息 *
+(void)Com_GetUserByDepartWithdepartId:(NSString*)departId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///用户受邀入驻企业记录 *
+(void)User_InvitationWithuser:(NSString*)user And:(void(^)(NSDictionary *dic))block;
///提交入职申请 *
+(void)User_ApplyForEntryWithuserGuid:(NSString*)userGuid user:(NSString*)user entryId:(NSString*)entryId And:(void(^)(NSDictionary *dic))block;
///删除入职申请 *
+(void)User_Delete_ApplyForEntryWithentryId:(NSString*)entryId  status:(NSString*)status And:(void(^)(NSDictionary *dic))block;

/// 查询企业下的所有岗位
+(void)User_getcompostWithcomid:(NSString*)comid  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///发布小喇叭
+(void)trumpet_Push_trumpetWithuserGuid:(NSString*)userGuid comid:(NSString*)comid content:(NSString*)content And:(void(^)(NSDictionary *dic))block;
///获取最新的小喇叭
+(void)trumpet_Get_trumpetWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid And:(void(^)(NSDictionary *dic))block;
///获取小喇叭的记录 (最多50条)
+(void)trumpet_Get_AlltrumpetWithuserGuid:(NSString*)userGuid comid:(NSString*)comid And:(void(^)(NSDictionary *dic))block;
/// 管理员待审核员工入驻列表
+(void)User_GetBeInviterWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
/// 管理员退回入职表
+(void)User_InvertRefuseWithuserGuid:(NSString*)userGuid entryId:(NSString*)entryId userPhone:(NSString*)userPhone And:(void(^)(NSDictionary *dic))block;
///管理员同意入职
+(void)User_InvertAgreeWithuserGuid:(NSString*)userGuid entryId:(NSString*)entryId userPhone:(NSString*)userPhone And:(void(^)(NSDictionary *dic))block;

/// 提交离职 *
+(void)User_QuitWithcompanyId:(NSString*)companyId  postId:(NSString*)postId departId:(NSString*)departId userGuid:(NSString*)userGuid  joinTime:(NSString*)joinTime quitReason:(NSString*)quitReason quitType:(NSString*)quitType joinNumber:(NSString*)joinNumber  quitTime:(NSString*)quitTime And:(void(^)(NSDictionary *dic))block;
///查看自己的离职申请 列表 *
+(void)User_MyQuitInfoWithcompanyId:(NSString*)companyId  userGuid:(NSString*)userGuid  type:(NSString*)type  page:(NSString*)page  And:(void(^)(NSDictionary *dic))block;
///领导查看待离职申请 *
+(void)User_GetQuitRecord_ListWithcompanyId:(NSString*)companyId  userGuid:(NSString*)userGuid type:(NSString*)type  page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///人事查看离职申请单 *
+(void)Quit_Get_Quit_ByHRWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
/// 离职单审批记录 *
+(void)User_GetQuitRecordListWithquitId:(NSString*)quitId And:(void(^)(NSDictionary *dic))block;
///领导审批 *  type =1 同意  2 拒绝
+(void)Quit_Set_Quit_ByLeaderWithquitId:(NSString*)quitId  userGuid:(NSString*)userGuid message:(NSString*)message  type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事审批   type =1  同意 2拒绝
+(void)Quit_Set_Quit_ByHRWithquitId:(NSString*)quitId  userGuid:(NSString*)userGuid message:(NSString*)message  type:(NSString*)type And:(void(^)(NSDictionary *dic))block;


///查看离职申请详情 *
+(void)User_GetQuitInfoWithquitId:(NSString*)quitId And:(void(^)(NSDictionary *dic))block;




///查看个人名片 *
+(void)Com_User_BusinessCardWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///修改昵称
+(void)userashx_Update_upnameWithuserGuid:(NSString*)userGuid upname:(NSString*)upname And:(void(^)(NSDictionary *dic))block;
///修改登陆地
+(void)Update_loginLocationWithuserGuid:(NSString*)userGuid loginLocation:(NSString*)loginLocation province:(NSString*)province city:(NSString*)city And:(void(^)(NSDictionary *dic))block;
///解绑手机号
+(void)userashx_Update_loginphonenoWithuserGuid:(NSString*)userGuid password:(NSString*)password uname:(NSString*)uname And:(void(^)(NSDictionary *dic))block;
///查看公司下的员工
+(void)Com_Com_User_ByCompanyWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///在职员工
+(void)Com_Com_StaffWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///离职员工
+(void)Com_Com_Staff_QuitWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///人员搜索同事
+(void)Com_User_Search_InfoWithcompanyId:(NSString*)companyId para:(NSString*)para And:(void(^)(NSDictionary *dic))block;
///人事可以执行的搜索
+(void)Com_User_SearchWithcompanyId:(NSString*)companyId para:(NSString*)para userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///发起任务
+(void)Add_TaskWithuserGuid:(NSString*)userGuid TaskName:(NSString*)TaskName ParentTaskId:(NSString*)ParentTaskId recipient:(NSString*)recipient assist:(NSString *)assist notify:(NSString*)notify startTime:(NSString*)startTime endTime:(NSString*)endTime checkStandard:(NSString*)checkStandard checker:(NSString*)checker checkTime:(NSString*)checkTime duty:(NSString*)duty companyId:(NSString*)companyId departId:(NSString*)departId taskDesc:(NSString*)taskDesc And:(void(^)(NSDictionary *dic))block;
///查看我的发起的任务
+(void)Get_Task_ByCreaterWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block;
///查看任务详情
+(void)Get_Task_InfoWithtaskId:(NSString*)taskId And:(void(^)(NSDictionary *dic))block;
///责任人接收任务
+(void)Set_AgreeTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message name:(NSString*)name And:(void(^)(NSDictionary *dic))block;
///责任人拒绝任务
+(void)Set_RefuseTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message name:(NSString*)name And:(void(^)(NSDictionary *dic))block;
///责任人完成任务
+(void)Set_CompleteTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message imgs:(NSArray*)imgs And:(void(^)(NSDictionary *dic))block;
///验收人验收任务
+(void)Set_CheckTaskWithtaskId:(NSString*)taskId userGuid:(NSString*)userGuid message:(NSString*)message imgs:(NSArray*)imgs And:(void(^)(NSDictionary *dic))block;
///查看负责人的任务
+(void)Get_Task_ByRecipientWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block;
///查看参与人的任务
+(void)Get_Task_ByOtherWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block;
///查看验收人的任务
+(void)Get_Task_ByCheckerWithuserGuid:(NSString*)userGuid ID:(NSString*)ID status:(NSString*)status And:(void(^)(NSDictionary *dic))block;
///查看任务验收的信息
+(void)Get_TaskCheckWithtaskId:(NSString*)taskId And:(void(^)(NSDictionary *dic))block;
///搜索企业的所有任务
+(void)Get_Task_BySearchWithcompanyId:(NSString*)companyId startDate:(NSString*)startDate endDate:(NSString*)endDate para:(NSString*)para And:(void(^)(NSDictionary *dic))block;

///发表工作圈
+(void)Add_WorkCircleWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid  message:(NSString*)message name:(NSString*)name location:(NSString*)location  imgarr:(NSArray*)imaArr And:(void(^)(NSDictionary *dic))block;
///工作圈评论
+(void)Add_WorkCircle_CommentWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid message:(NSString*)message workCircleId:(NSString*)workCircleId  parentId:(NSString*)parentId  And:(void(^)(NSDictionary *dic))block;
///工作圈点赞
+(void)Add_WorkCircle_ZanWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid  workCircleId:(NSString*)workCircleId And:(void(^)(NSDictionary *dic))block;
///查看工作圈
+(void)Get_WorkCircle_ByCompanyWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///查看工作圈的评论
+(void)Get_Comment_ByWorkCircleIdWithworkCircleId:(NSString*)workCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///删除工作圈
+(void)Delete_WorkCircleWithworkCircleId:(NSString*)workCircleId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///查看点赞的人
+(void)Get_WorkCircle_ZanWithworkCircleId:(NSString*)workCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///查看说说下的所有子评论
+(void)Get_Comment_ByIdWithcommentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block;
///删除子评论
+(void)Delete_CommentWithuserGuid:(NSString*)userGuid commentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block;
///查看单个说说的详情
+(void)Get_WorkCircle_ByIdWithworkCircleId:(NSString*)workCircleId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;

/// 请假申请
+(void)Add_LeaveWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId leadvStartTime:(NSString*)leadvStartTime leaveEndTime:(NSString*)leaveEndTime leaveTime:(NSString*)leaveTime leaveType:(NSString*)leaveType leaveReason:(NSString*)leaveReason img:(UIImage*)img And:(void(^)(NSDictionary *dic))block;
///获取自己提交的请假单申请
+(void)Get_Leave_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看请假单的审批信息
+(void)Get_Leave_CheckWithleaveId:(NSString*)leaveId And:(void(^)(NSDictionary *dic))block;
///审核人审批请假单
+(void)Set_Leave_ByLeaderWithleaveId:(NSString*)leaveId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///HR审核请假单
+(void)Set_Leave_ByHRWithleaveId:(NSString*)leaveId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看审批人的审批的请假单
+(void)Get_Leave_ByLeaderWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看HR审批的请假单
+(void)Get_Leave_ByHRWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///删除请假单
+(void)Delete_LeaveWithuserGuid:(NSString*)userGuid leaveId:(NSString*)leaveId And:(void(^)(NSDictionary *dic))block;
///请假单详情
+(void)Get_Leave_ByIdWithleaveId:(NSString*)leaveId And:(void(^)(NSDictionary *dic))block;
///获取员工的审批领导
+(void)Get_User_LeaderWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;


///新建班次规则
+(void)Add_RuleShiftWithruleName:(NSString*)ruleName  ruleDescribe:(NSString*)ruleDescribe companyId:(NSString*)companyId userGuid:(NSString*)userGuid objecter:(NSString*)objecter shiftId:(NSString*)shiftId weeks:(NSString*)weeks holidays:(NSString*)holidays And:(void(^)(NSDictionary *dic))block;
///查看排班规则
+(void)Get_RuleShiftWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///删除排班规则
+(void)Delete_RuleShiftWithuserGuid:(NSString*)userGuid shiftId:(NSString*)shiftId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///修改排班规则
+(void)Update_RuleShiftWithshiftId:(NSString*)shiftId weeks:(NSString*)weeks holidays:(NSString*)holidays userGuid:(NSString*)userGuid companyId:(NSString*)companyId ruleShiftId:(NSString*)ruleShiftId And:(void(^)(NSDictionary *dic))block;
///修改 排版班则下的人员
+(void)Update_RuleShift_UserWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId ruleShiftId:(NSString*)ruleShiftId objecter:(NSString*)objecter And:(void(^)(NSDictionary *dic))block;
///查看排班规则下的人员
+(void)Get_Rule_UserWithruleShiftId:(NSString*)ruleShiftId And:(void(^)(NSDictionary *dic))block;
///新建班次
+(void)Add_ShiftWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId shiftName:(NSString*)shiftName Arr:(NSArray*)timeArr And:(void(^)(NSDictionary *dic))block;
///查看公司下的班次
+(void)Get_Shift_ByCompanyWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///删除班次
+(void)Delete_ShiftWithuserGuid:(NSString*)userGuid shiftId:(NSString*)shiftId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///查看用户自己的排班规则
+(void)Get_User_ShiftWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///修改班次
+(void)Update_ShiftWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId shiftId:(NSString*)shiftId shiftName:(NSString*)shiftName startTime1:(NSString*)startTime1 endTime1:(NSString*)endTime1 startTime2:(NSString*)startTime2 endTime2:(NSString*)endTime2 startTime3:(NSString*)startTime3 endTime3:(NSString*)endTime3 startTime4:(NSString*)startTime4 endTime4:(NSString*)endTime4 And:(void(^)(NSDictionary *dic))block;


///创建标签
+(void)create_labelWithowner:(NSString*)owner labelName:(NSString*)labelName labelfriends:(NSString*)labelfriends And:(void(^)(NSDictionary *dic))block;
///获取个人标签列表
+(void)Get_labellistWithowner:(NSString*)owner And:(void(^)(NSDictionary *dic))block;
///查看标签
+(void)Get_labelWithowner:(NSString*)owner  labelid:(NSString*)labelid And:(void(^)(NSDictionary *dic))block;
///添加标签成员
+(void)Add_labelmembersWithowner:(NSString*)owner  labelid:(NSString*)labelid  addmembers:(NSString*)addmembers And:(void(^)(NSDictionary *dic))block;
///移除标签成员
+(void)Prune_labelmembersWithowner:(NSString*)owner labelid:(NSString*)labelid  labelfriends:(NSString*)labelfriends And:(void(^)(NSDictionary *dic))block;
///删除标签
+(void)Del_labelWithowner:(NSString*)owner labelid:(NSString*)labelid And:(void(^)(NSDictionary *dic))block;

///新建调班申请
+(void)Add_ChangeShiftWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid changeShiftId:(NSString*)changeShiftId changeShiftReason:(NSString*)changeShiftReason And:(void(^)(NSDictionary *dic))block;
///查询自己创建的调班申请
+(void)Get_ChangeShft_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///调班详情
+(void)Get_ChangeShift_ByIdWithchangeShiftId:(NSString*)changeShiftId And:(void(^)(NSDictionary *dic))block;
///审批人查看调班申请列表
+(void)Get_ChangeShift_ByCheckerWithtype:(NSString*)type userGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///领导审批调班申请单
+(void)Set_ChangeShift_ByCheckerWithchangeShiftId:(NSString*)changeShiftId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///删除调班申请单
+(void)Delete_ChangeShiftWithchangeShiftId:(NSString*)changeShiftId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;

///查看调班申请的审批记录
+(void)Get_ChangeShift_CheckWithchangeShiftId:(NSString*)changeShiftId And:(void(^)(NSDictionary *dic))block;


///查看人事审批调班申请单
+(void)Get_ChangeShift_ByHRWithtype:(NSString*)type userGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///人事审批调班申请单
+(void)Set_ChangeShift_ByHRWithchangeShiftId:(NSString*)changeShiftId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;

///新增调休申请
+(void)Add_OffWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId planStartTime:(NSString*)planStartTime planEndTime:(NSString*)planEndTime offStartTime:(NSString*)offStartTime offEndTime:(NSString*)offEndTime offTimes:(NSString*)offTimes And:(void(^)(NSDictionary *dic))block;
///查看自己的调休申请
+(void)Get_Off_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///调休的详情
+(void)Get_Off_ByIdWithoffId:(NSString*)offId And:(void(^)(NSDictionary *dic))block;
///领导查看调休申请列表
+(void)Get_Off_ByCheckerWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事查看调休申请列表
+(void)Get_Off_ByHRWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///领导审批调休申请表
+(void)Set_Off_ByCheckerWithoffId:(NSString*)offId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事审批调休申请表
+(void)Set_Off_ByHRWithoffId:(NSString*)offId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 调休的审批记录
+(void)Get_Off_CheckWithoffId:(NSString*)offId And:(void(^)(NSDictionary *dic))block;
///当月的调休申请
+(void)Get_Off_ByMonthWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;

///加班申请
+(void)OverTimes_Add_OverTimeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId startOverTime:(NSString*)startOverTime endOverTime:(NSString*)endOverTime times:(NSString*)times overTimeReason:(NSString*)overTimeReason overTimeType:(NSString*)overTimeType And:(void(^)(NSDictionary *dic))block;
///查看自己的加班申请
+(void)OverTimes_Get_OverTime_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看加班申请详情
+(void)OverTimes_Get_OverTime_ByIdWithoverTimeId:(NSString*)overTimeId And:(void(^)(NSDictionary *dic))block;
///审批人查看加班申请列表
+(void)OverTimes_Get_OverTime_ByCheckerWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事查看加班申请列表
+(void)OverTimes_Get_OverTime_ByHRWithtype:(NSString*)type userGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///领导审批加班申请单
+(void)OverTimes_Set_OverTime_ByCheckerWithoverTimeId:(NSString*)overTimeId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事审批加班申请单
+(void)OverTimes_Set_OverTime_ByHRWithoverTimeId:(NSString*)overTimeId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///获取加班申请单的审批记录
+(void)OverTimes_Get_OverTime_CheckWithoverTimeId:(NSString*)overTimeId And:(void(^)(NSDictionary *dic))block;

///获取员工当月的加班时间段
+(void)OverTimes_Get_OverTime_ByMonthWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;

///添加出差申请
+(void)travel_Add_TravelWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId travelStartTime:(NSString*)travelStartTime travelEndTime:(NSString*)travelEndTime travelTimes:(NSString*)travelTimes travelReason:(NSString*)travelReason travelAddress:(NSString*)travelAddress mapAddress:(NSString*)mapAddress And:(void(^)(NSDictionary *dic))block;
///查看我的出差申请单
+(void)travel_Get_Travel_ByCreaterWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 查看出差申请单详情
+(void)travel_Get_Travel_ByIdWithtravelId:(NSString*)travelId And:(void(^)(NSDictionary *dic))block;
///领导审批出差申请单
+(void)travel_Set_Travel_ByLeaderWithtravelId:(NSString*)travelId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事审批出差申请单
+(void)travel_Set_Travel_ByHRWithtravelId:(NSString*)travelId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 查看出差申请单审批记录
+(void)travel_Get_Travel_CheckWithuserGuidtravelId:(NSString*)travelId And:(void(^)(NSDictionary *dic))block;
///领导查看出差清单
+(void)travel_Get_Travel_ByLeaderWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///HR查看出差申请单
+(void)travel_Get_Travel_ByHRWithuserGuid:(NSString*)userGuid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

/// 打卡
+(void)Clocks_Add_ClockWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId clockTime:(NSString*)clockTime place:(NSString*)place MAC:(NSString*)MAC WIFIName:(NSString*)WIFIName phoneUUID:(NSString*)phoneUUID phoneType:(NSString*)phoneType coordinate:(NSString*)coordinate type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 当月打卡记录
+(void)Clocks_Get_Clock_ByMonthWithuserGuid:(NSString*)userGuid Month:(NSString*)Month And:(void(^)(NSDictionary *dic))block;
///重打卡
+(void)Clocks_Update_ClockWithuserGuid:(NSString*)userGuid clockTime:(NSString*)clockTime place:(NSString*)place MAC:(NSString*)MAC WIFIName:(NSString*)WIFIName phoneUUID:(NSString*)phoneUUID phoneType:(NSString*)phoneType coordinate:(NSString*)coordinate clockId:(NSString*)clockId And:(void(^)(NSDictionary *dic))block;
///获取当天打卡
+(void)Clocks_Get_ClockWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId date:(NSString*)date  And:(void(^)(NSDictionary *dic))block;
///发起劳动合同
+(void)Contracts_Add_ContractWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId signatory:(NSString*)signatory signDepartId:(NSString*)signDepartId signPostId:(NSString*)signPostId signEntryTime:(NSString*)signEntryTime contractType:(NSString*)contractType contractNature:(NSString*)contractNature signedNumber:(NSString*)signedNumber lastReason:(NSString*)lastReason contractForm:(NSString*)contractForm contractStartTime:(NSString*)contractStartTime  contractEndTime:(NSString*)contractEndTime probation:(NSString*)probation bank:(NSString*)bank ProbationSalary:(NSString*)ProbationSalary And:(void(^)(NSDictionary *dic))block;
///查看发起人的合同列表
+(void)Contracts_Get_Contract_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type  companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///通过id查看合同详情
+(void)Contracts_Get_Contract_ByIdWithcontractId:(NSString*)contractId And:(void(^)(NSDictionary *dic))block;

///查看签订人的合同列表
+(void)Contracts_Get_Contract_BySignatoryWithuserGuid:(NSString*)userGuid type:(NSString*)type  companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看公司领导需要审批的合同 列表
+(void)Contracts_Get_Contract_ByLeaderWithuserGuid:(NSString*)userGuid  type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///签订人确认合同
+(void)Contracts_Set_Contract_BySignatoryWithcontractId:(NSString*)contractId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type bankCard:(NSString*)bankCard openBank:(NSString*)openBank And:(void(^)(NSDictionary *dic))block;
///人事审核合同
+(void)Contracts_Set_Contract_ByCreaterWithcontractId:(NSString*)contractId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 公司领导审批合同
+(void)Contracts_Set_Contract_ByLeaderWithcontractId:(NSString*)contractId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 查看合同的审批记录
+(void)Contracts_Get_CheckWithcontractId:(NSString*)contractId And:(void(^)(NSDictionary *dic))block;
/// 设置通知公告审批人
+(void)SetUp_Set_News_ApproverWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid approver:(NSString*)approver Id:(NSString*)Id type:(NSString*)type And:(void(^)(NSDictionary *dic))block;

///查看通知公告审批人
+(void)SetUp_Get_Approver_ByNWithcompanyId:(NSString*)companyId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///设置请假类型是否有薪
+(void)SetUp_Set_LeaveTypeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId leaveType:(NSString*)leaveType And:(void(^)(NSDictionary *dic))block;
/// 修改休假类型是否有薪
+(void)SetUp_Update_LeaveTypeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId  leaveType:(NSString*)leaveType leaveTypeId:(NSString*)leaveTypeId And:(void(^)(NSDictionary *dic))block;
///查看设置的有薪请假类型
+(void)SetUp_Get_LeaveTypeWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///新建请假/出差，天数的审批等级
+(void)SetUp_Add_LeaveCheckTimeWithuserGuid:(NSString*)userGuid minTime:(NSString*)minTime maxTime:(NSString*)maxTime companyId:(NSString*)companyId approval:(NSString*)approval type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 修改请假/出差，天数的审批等级
+(void)SetUp_Update_LeaveCheckTimeWithuserGuid:(NSString*)userGuid minTime:(NSString*)minTime maxTime:(NSString*)maxTime companyId:(NSString*)companyId approvalLevel:(NSString*)approvalLevel  type:(NSString*)type ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
/// 删除请假/出差，天数的审批等级
+(void)SetUp_Delete_LeaveCheckTimeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///查看请假/出差，天数的审批等级
+(void)SetUp_Get_LeaveCheckTimeWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId type:(NSString*)type And:(void(^)(NSDictionary *dic))block;

///修改工作圈的背景图
+(void)WorkCircles_Update_WorkImageWithuserGuid:(NSString*)userGuid user:(NSString*)user  img:(UIImage*)img And:(void(^)(NSDictionary *dic))block;
///添加公告
+(void)Notices_Add_NoticeWithcompanyId:(NSString*)companyId noticeName:(NSString*)noticeName objectType:(NSString*)objectType objectDepartId:(NSString*)objectDepartId noticeTheme:(NSString*)noticeTheme noticeContent:(NSString*)noticeContent userGuid:(NSString*)userGuid duty:(NSString*)duty noticeCycle:(NSString*)noticeCycle And:(void(^)(NSDictionary *dic))block;
///查看公告详情
+(void)Notices_Get_Notice_ByIdWithnoticeId:(NSString*)noticeId And:(void(^)(NSDictionary *dic))block;
///发布人查看公告列表
+(void)Notices_Get_Notice_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///核准人查看核准公告列表
+(void)Notices_Get_Notice_ByCheckerWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看对全体员工的公告
+(void)Notices_Get_Notice_ByCompanyWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看对部门员工的公告
+(void)Notices_Get_Notice_ByDepartmentWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///核准人核准公告
+(void)Notices_Set_Notice_CheckWithnoticeId:(NSString*)noticeId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///获取所有公告
+(void)Notices_Get_Notice_ByAllWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///发布通知
+(void)Newss_Add_NewsWithcompanyId:(NSString*)companyId newsName:(NSString*)newsName objectType:(NSString*)objectType objectDepartId:(NSString*)objectDepartId newsTheme:(NSString*)newsTheme newsContent:(NSString*)newsContent userGuid:(NSString*)userGuid createDepartId:(NSString*)createDepartId duty:(NSString*)duty newsCycle:(NSString*)newsCycle isAdmin:(NSString*)isAdmin And:(void(^)(NSDictionary *dic))block;

///查看自己发布的通知
+(void)Newss_Get_News_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///通知详情
+(void)Newss_Get_Notice_ByIdWithnewsId:(NSString*)newsId And:(void(^)(NSDictionary *dic))block;
///查看核准人的通知列表
+(void)Newss_Get_News_ByCheckerWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看对公司的审批
+(void)Newss_Get_News_ByCompanyWithcompanyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看部门下的审批
+(void)Newss_Get_Notice_ByDepartmentWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///核准人核准
+(void)Newss_Set_News_CheckWithnewsId:(NSString*)newsId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///获取所有通知
+(void)Newss_Get_News_ByAllWithcompanyId:(NSString*)companyId departId:(NSString*)departId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///新增联络书
+(void)LiaisonBooks_Add_LiaisonBookWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId departId:(NSString*)departId objectCompanyId:(NSString*)objectCompanyId objectDepartId:(NSString*)objectDepartId objecter:(NSString*)objecter liaisonBookName:(NSString*)liaisonBookName liaisonBookTheme:(NSString*)liaisonBookTheme liaisonBookContent:(NSString*)liaisonBookContent timeLimit:(NSString*)timeLimit isReply:(NSString*)isReply isLeader:(NSString*)isLeader And:(void(^)(NSDictionary *dic))block;
///查看自己发布的联络书
+(void)LiaisonBooks_Get_LiaisonBook_ByCreaterWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看联络书详情
+(void)LiaisonBooks_Get_LiaisonBook_ByIdWithId:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///查看核准人联络书
+(void)LiaisonBooks_Get_LiaisonBook_ByCheckerWithuserGuid:(NSString*)userGuid type:(NSString*)type companyId:(NSString*)companyId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///核准人审核联络书
+(void)LiaisonBooks_Set_LiaisonBook_CheckWithliaisonBookId:(NSString*)liaisonBookId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看被联络人的联络书
+(void)LiaisonBooks_Get_LiaisonBook_ByObjecterWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///搜索联络人
+(void)LiaisonBooks_Get_Usre_BySearchWithpara:(NSString*)para And:(void(^)(NSDictionary *dic))block;

///查看公司的最高领导
+(void)Com_Get_TopAdminWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
/// 设置公司的最高领导
+(void)SetUp_Set_TopLeadersWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId  topLeader:(NSString*)topLeader And:(void(^)(NSDictionary *dic))block;
///消迟到早退
+(void)Sickleaves_Add_SickleavesWithuserGuid:(NSString*)userGuid  choseDate:(NSString*)choseDate  ids:(NSString*)ids reason:(NSString*)reason witness:(NSString*)witness imgarr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block;
///查看申请人迟到早退申请列表
+(void)Sickleaves_Get_SickLeaveByUserWithuserGuid:(NSString*)userGuid  page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看迟到早退详情
+(void)Sickleaves_Get_SickleaveByIdWithsickLeaveId:(NSString*)sickLeaveId And:(void(^)(NSDictionary *dic))block;
///审批人查看 迟到早退列表
+(void)Sickleaves_Get_SickleaveByLeaderWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///审批人 审批迟到早退
+(void)Sickleaves_Set_SickleaveWithuserGuid:(NSString*)userGuid sickleaveId:(NSString*)sickleaveId  message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看迟到早退审批信息
+(void)Sickleaves_Get_Sickleave_CheckWithsickleaveId:(NSString*)sickleaveId And:(void(^)(NSDictionary *dic))block;
///人事查看迟到早退审批列表
+(void)Sickleaves_Get_Sickleave_ByHRWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///人事的审批 迟到zaotui
+(void)Sickleaves_Set_Sickleave_ByHRWithsickleaveId:(NSString*)sickleaveId userGuid:(NSString*)userGuid  message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///漏打卡申请
+(void)Sickleaves_Add_MissClockWithuserGuid:(NSString*)userGuid choseDate:(NSString*)choseDate times:(NSString*)times reason:(NSString*)reason witness:(NSString*)witness imgArr:(NSArray*)imgarr And:(void(^)(NSDictionary *dic))block;
///查看自己的漏打卡申请
+(void)Sickleaves_Get_MissClock_ByCreaterWithuserGuid:(NSString*)userGuid page:(NSString*)page  type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///领导查看漏打卡申请
+(void)Sickleaves_Get_MissClock_ByLeaderWithuserGuid:(NSString*)userGuid page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///领导审批漏打卡
+(void)Sickleaves_Set_MissClock_ByLeaderWithmissClockId:(NSString*)missClockId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///查看消漏打卡详情
+(void)Sickleaves_Get_MissClock_ByIdWithmissClockId:(NSString*)missClockId And:(void(^)(NSDictionary *dic))block;
///查看消漏打卡申请审批记录
+(void)Sickleaves_Get_MissClock_CheckWithmissClockId:(NSString*)missClockId And:(void(^)(NSDictionary *dic))block;
///人事查看漏打卡
+(void)Sickleaves_Get_MissClock_ByHRWithuserGuid:(NSString*)userGuid page:(NSString*)page  type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
/// 人事审批漏打卡
+(void)Sickleaves_Set_MissClock_ByHRWithmissClockId:(NSString*)missClockId userGuid:(NSString*)userGuid message:(NSString*)message type:(NSString*)type And:(void(^)(NSDictionary *dic))block;

///添加企业图片
+(void)ComImage_Add_ComImageWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId url:(NSString*)url title:(NSString*)title sort:(NSString*)sort img:(UIImage*)img And:(void(^)(NSDictionary *dic))block;
///查看企业图片
+(void)ComImage_Get_ComImageWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///修改企业图片
+(void)ComImage_Update_ComImageWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId url:(NSString*)url title:(NSString*)title sort:(NSString*)sort imageId:(NSString*)imageId img:(UIImage*)img And:(void(^)(NSDictionary *dic))block;
///删除企业图片
+(void)ComImage_Delete_ComImageWithuserGuid:(NSString*)userGuid imageId:(NSString*)imageId companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///交换图片
+(void)ComImage_Update_ImageSortWithuserGuid:(NSString*)userGuid companyId:(NSString*)companyId  para:(NSString*)para And:(void(^)(NSDictionary *dic))block;
///修改个性签名
+(void)Com_Update_UserSignatureWithuserGuid:(NSString*)userGuid  signature:(NSString*)signature And:(void(^)(NSDictionary *dic))block;
///获取易企点图片信息
+(void)EQDimages_Get_EQDimageAnd:(void(^)(NSDictionary *dic))block;
///添加不重复的备忘录
+(void)memo_AddMemoWithuserGuid:(NSString*)userGuid eventName:(NSString*)eventName startDate:(NSString*)startDate endDate:(NSString*)endDate startTime:(NSString*)startTime endTime:(NSString*)endTime memoInfo:(NSString*)memoInfo eventType:(NSString*)eventType
                   timeToRemind:(NSString*)timeToRemind place:(NSString*)place And:(void(^)(NSDictionary *dic))block;
///查看某天的事件
+(void)memo_SeeMemouserGuid:(NSString*)userGuid seeDate:(NSString*)seeDate And:(void(^)(NSDictionary *dic))block;
///删除事件
+(void)memo_DeleteMemoWithmemoid:(NSString*)memoid And:(void(^)(NSDictionary *dic))block;
///查看某月下的事件
+(void)memo_SeeTheMonthMemoWithuserGuid:(NSString*)userGuid seeDate:(NSString*)seeDate And:(void(^)(NSDictionary *dic))block;
///修改事件
+(void)memo_UpdateMemoWithmemoid:(NSString*)memoid eventName:(NSString*)eventName startDate:(NSString*)startDate endDate:(NSString*)endDate startTime:(NSString*)startTime endTime:(NSString*)endTime memoInfo:(NSString*)memoInfo eventType:(NSString*)eventType timeToRemind:(NSString*)timeToRemind place:(NSString*)place userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///在职员工筛选
+(void)Com_Get_Staff_BySearchWithcompanyId:(NSString*)companyId  departmentId:(NSString*)departmentId joinStartTime:(NSString*)joinStartTime joinEndTime:(NSString*)joinEndTime userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///发送短信验证码
+(void)jsms_JSendMessagesWithtel:(NSString*)tel And:(void(^)(NSDictionary *dic))block;
///验证码验证
+(void)jsms_ValidcodeWithmsgid:(NSString*)msgid code:(NSString*)code And:(void(^)(NSDictionary *dic))block;
///发送单条短信模板
+(void)jsms_JSingleMessageWithtel:(NSString*)tel text:(NSString*)text tempid:(NSString*)tempid And:(void(^)(NSDictionary *dic))block;
///批量发送模板短信
+(void)jsms_JSendBatchMessagesWithrecipients:(NSString*)recipients tempid:(NSString*)tempid text:(NSString*)text And:(void(^)(NSDictionary *dic))block;
///修改易企点号
+(void)userashx_Update_EQDCodeWithuserGuid:(NSString*)userGuid  eqdCodeNew:(NSString*)eqdCodeNew And:(void(^)(NSDictionary *dic))block;

///添加反馈
+(void)feedback_User_addfbWithtitle:(NSString*)title  type:(NSString*)type  contactway:(NSString*)contactway fbcontent:(NSString*)fbcontent  userGuid:(NSString*)userGuid imgArr:(NSArray*)imgs And:(void(^)(NSDictionary *dic))block;
///查看反馈
+(void)feedback_Getfb_userWithuserGuid:(NSString*)userGuid  And:(void(^)(NSDictionary *dic))block;

///添加工作经历
+(void)userashx_Add_workExperienceWithuserGuid:(NSString*)userGuid startTime:(NSString*)startTime endTime:(NSString*)endTime company:(NSString*)company induCategoryCode:(NSString*)induCategoryCode induCategoryName:(NSString*)induCategoryName enterpriseNature:(NSString*)enterpriseNature enterpriseScale:(NSString*)enterpriseScale monthlySalary:(NSString*)monthlySalary  department:(NSString*)department  post:(NSString*)post jobDescri:(NSString*)jobDescri isOvert:(NSString*)isOvert And:(void(^)(NSDictionary *dic))block;

///修改工作经历
+(void)userashx_Update_workExperienceWithuserGuid:(NSString*)userGuid workepid:(NSString*)workepid  startTime:(NSString*)startTime  endTime:(NSString*)endTime company:(NSString*)company induCategoryCode:(NSString*)induCategoryCode induCategoryName:(NSString*)induCategoryName  enterpriseNature:(NSString*)enterpriseNature enterpriseScale:(NSString*)enterpriseScale monthlySalary:(NSString*)monthlySalary  department:(NSString*)department  post:(NSString*)post  jobDescri:(NSString*)jobDescri And:(void(^)(NSDictionary *dic))block;
///查看某人工作经历
+(void)userashx_Get_workExperienceWithuserGuid:(NSString*)userGuid  weuserGuid:(NSString*)weuserGuid  And:(void(^)(NSDictionary *dic))block;
///修改工作经历公开与否
+(void)userashx_Update_weovertWithuserGuid:(NSString*)userGuid workepid:(NSString*)workepid isOvert:(NSString*)isOvert And:(void(^)(NSDictionary *dic))block;
///删除工作经历
+(void)userashx_Del_workExperienceWithuserGuid:(NSString*)userGuid workepid:(NSString*)workepid And:(void(^)(NSDictionary *dic))block;

///添加项目经验
+(void)userashx_Add_projectExperienceWithuserGuid:(NSString*)userGuid  ownedCompany:(NSString*)ownedCompany projectName:(NSString*)projectName  startTime:(NSString*)startTime  endTime:(NSString*)endTime  duty:(NSString*)duty projectDescription:(NSString*)projectDescription  projectURL:(NSString*)projectURL  isOvert:(NSString*)isOvert And:(void(^)(NSDictionary *dic))block;
///修改项目经验
+(void)userashx_Update_projectExperienceWithuserGuid:(NSString*)userGuid projectepid:(NSString*)projectepid  ownedCompany:(NSString*)ownedCompany  projectName:(NSString*)projectName startTime:(NSString*)startTime endTime:(NSString*)endTime  duty:(NSString*)duty  projectDescription:(NSString*)projectDescription projectURL:(NSString*)projectURL And:(void(^)(NSDictionary *dic))block;
///查看个人项目经验
+(void)userashx_Get_projectExperienceWithuserGuid:(NSString*)userGuid  peuserGuid:(NSString*)peuserGuid And:(void(^)(NSDictionary *dic))block;
///修改项目经验公开与否
+(void)userashx_Update_peovertWithuserGuid:(NSString*)userGuid  projectepid:(NSString*)projectepid  isOvert:(NSString*)isOvert  And:(void(^)(NSDictionary *dic))block;
///删除项目经验
+(void)userashx_Del_projectExperienceWithuserGuid:(NSString*)userGuid  projectepid:(NSString*)projectepid And:(void(^)(NSDictionary *dic))block;
///添加客户
+(void)crmModule_Create_customerWithowner:(NSString*)owner  comid:(NSString*)comid cusName:(NSString*)cusName cusType:(NSString*)cusType salesTerritory:(NSString*)salesTerritory  address:(NSString*)address latAndLong:(NSString*)latAndLong cusCall:(NSString*)cusCall url:(NSString*)url remark:(NSString*)remark imgArr:(NSArray*)imgArr salesTerritoryCode:(NSString*)salesTerritoryCode And:(void(^)(NSDictionary *dic))block;
///客户拥有者修改客户信息   data：json格式的要修改的字段信息，如{ "cusName": "龙珠超","salesTerritory": "全国","cusCall":"15137111111","url":"","remark":"传什么字段修改哪个字段，不传的不修改"}
+(void)crmModule_Update_customerWithowner:(NSString*)owner  cusid:(NSString*)cusid data:(NSString*)data  And:(void(^)(NSDictionary *dic))block;
///获取个人客户列表
+(void)crmModule_Owner_getcuslistWithowner:(NSString*)owner page:(NSString*)page  And:(void(^)(NSDictionary *dic))block;
///个人获取单个客户的信息 详情
+(void)crmModule_Owner_getcusWithowner:(NSString*)owner cusid:(NSString*)cusid And:(void(^)(NSDictionary *dic))block;
///删除个人所拥有的单个客户
+(void)crmModule_Del_customerWithowner:(NSString*)owner  cusid:(NSString*)cusid And:(void(^)(NSDictionary *dic))block;
///给“客户”添加联系人
+(void)crmModule_Create_cuscontactsWithname:(NSString*)name dep:(NSString*)dep post:(NSString*)post cellphone:(NSString*)cellphone conqq:(NSString*)conqq conwx:(NSString*)conwx email:(NSString*)email remark:(NSString*)remark cusid:(NSString*)cusid  owner:(NSString*)owner  And:(void(^)(NSDictionary *dic))block;
///修改联系人信息
+(void)crmModule_Update_cuscontactsWithowner:(NSString*)owner  contactsid:(NSString*)contactsid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block;
///获取客户下的联系人列表
+(void)crmModule_Get_cuscontactslistWithgetpeople:(NSString*)getpeople  owner:(NSString*)owner  comid:(NSString*)comid cusid:(NSString*)cusid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///（客户、联系人创建者）获取单个联系人的详细信息
+(void)crmModule_Get_cuscontactsWithowner:(NSString*)owner  contactsid:(NSString*)contactsid And:(void(^)(NSDictionary *dic))block;
///删除客户联系人
+(void)crmModule_Del_cuscontactsWithowner:(NSString*)owner  contactsid:(NSString*)contactsid  And:(void(^)(NSDictionary *dic))block;

///添加（创建）销售机会
+(void)crmModule_Create_saleschanceWithowner:(NSString*)owner comid:(NSString*)comid  chanceName:(NSString*)chanceName chanceClassify:(NSString*)chanceClassify cusid:(NSString*)cusid contacts:(NSString*)contacts interestproducts:(NSString*)interestproducts  createDate:(NSString*)createDate  exdateofcompletion:(NSString*)exdateofcompletion  productsalesmoney:(NSString*)productsalesmoney expectmoney:(NSString*)expectmoney  remark:(NSString*)remark remindTime:(NSString*)remindTime And:(void(^)(NSDictionary *dic))block;
///修改销售机会
+(void)crmModule_Update_saleschanceWithowner:(NSString*)owner  saleschanceid:(NSString*)saleschanceid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block;

///删除销售机会
+(void)crmModule_Del_saleschanceWithowner:(NSString*)owner  saleschanceid:(NSString*)saleschanceid And:(void(^)(NSDictionary *dic))block;
///获取销售机会列表（某客户下）
+(void)crmModule_Get_saleschancelistWithowner:(NSString*)owner  cusid:(NSString*)cusid  page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///添加回访记录
+(void)crmModule_Add_revisitRecordWithowner:(NSString*)owner  comid:(NSString*)comid  revisitTitle:(NSString*)revisitTitle cusid:(NSString*)cusid  cusName:(NSString*)cusName  contactsid:(NSString*)contactsid  contactsName:(NSString*)contactsName  contactsPhone:(NSString*)contactsPhone  revisitDate:(NSString*)revisitDate  revisitType:(NSString*)revisitType  revisitcontent:(NSString*)revisitcontent  remindTime:(NSString*)remindTime imgArr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block;
///获取回访记录列表
+(void)crmModule_Get_revisitRecordWithowner:(NSString*)owner  cusid:(NSString*)cusid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///修改回访记录
+(void)crmModule_Update_revisitRecordWithowner:(NSString*)owner  revisitRecordid:(NSString*)revisitRecordid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block;
////删除回访记录
+(void)crmModule_Del_revisitRecordWithowner:(NSString*)owner  revisitRecordid:(NSString*)revisitRecordid  And:(void(^)(NSDictionary *dic))block;
///添加客户反馈记录
+(void)crmModule_Add_cusfbRecordWithowner:(NSString*)owner comid:(NSString*)comid  fbtitle:(NSString*)fbtitle cusid:(NSString*)cusid  fbcontent:(NSString*)fbcontent  fbtype:(NSString*)fbtype  addr:(NSString*)addr  fberid:(NSString*)fberid fberName:(NSString*)fberName  fberPhone:(NSString*)fberPhone  fbTime:(NSString*)fbTime  remindTime:(NSString*)remindTime imgArr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block;
///查看客户反馈记录列表
+(void)crmModule_Get_cusfbRecordWithowner:(NSString*)owner  cusid:(NSString*)cusid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///修改客户反馈记录
+(void)crmModule_Update_cusfbRecordWithowner:(NSString*)owner  cusfbRecordid:(NSString*)cusfbRecordid  data:(NSString*)data And:(void(^)(NSDictionary *dic))block;
///删除客户反馈记录
+(void)crmModule_Del_cusfbRecordWithowner:(NSString*)owner  cusfbRecordid:(NSString*)cusfbRecordid And:(void(^)(NSDictionary *dic))block;
///搜索客户
+(void)crmModule_Search_customerinfoWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block;
///搜索联系人
+(void)crmModule_Search_cuscontactsInfoWithparam:(NSString*)param owner:(NSString*)owner And:(void(^)(NSDictionary *dic))block;
///搜索销售机会
+(void)crmModule_Search_saleschanceWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block;
///搜索回访记录
+(void)crmModule_Search_revisitRecordWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block;
///搜索客户反馈记录
+(void)crmModule_Search_cusfbRecordWithparam:(NSString*)param And:(void(^)(NSDictionary *dic))block;
///查看单条反馈记录详情
+(void)crmModule_Get_revisitRecordInfoWithowner:(NSString*)owner recordId:(NSString*)recordId And:(void(^)(NSDictionary *dic))block;

///发朋友圈  name 手机号
+(void)FriendCircles_Add_FriendCircleWithuserGuid:(NSString*)userGuid message:(NSString*)message  name:(NSString*)name location:(NSString*)location  imgArr:(NSArray*)imgArr And:(void(^)(NSDictionary *dic))block;
///查看朋友圈
+(void)FriendCircles_Get_FriendCircle_ByCreaterWithuserGuid:(NSString*)userGuid  ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
/// 发表评论
+(void)FriendCircles_Add_FriendCircle_CommentWithuserGuid:(NSString*)userGuid  message:(NSString*)message friendCircleId:(NSString*)friendCircleId  parentId:(NSString*)parentId And:(void(^)(NSDictionary *dic))block;
///朋友圈点赞
+(void)FriendCircles_Add_FriendCircle_ZanWithuserGuid:(NSString*)userGuid friendCircleId:(NSString*)friendCircleId And:(void(^)(NSDictionary *dic))block;
///删除朋友圈评论
+(void)FriendCircles_Delete_FriendCircle_CommentWithuserGuid:(NSString*)userGuid  commentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block;
///查看 朋友圈详情
+(void)FriendCircles_Get_FriendCircle_ByIdWithfriendCircleId:(NSString*)friendCircleId  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///查看朋友圈评论
+(void)FriendCircles_Get_Comment_ByFriendCircleIdWithfriendCircleId:(NSString*)friendCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///通过id查看评论
+(void)FriendCircles_Get_Comment_ByIdWithcommentId:(NSString*)commentId And:(void(^)(NSDictionary *dic))block;
///查看朋友圈点赞
+(void)FriendCircles_Get_FriendCircle_ZanWithfriendCircleId:(NSString*)friendCircleId ID:(NSString*)ID And:(void(^)(NSDictionary *dic))block;
///删除朋友圈
+(void)FriendCircles_Delete_FriendCircleWithfriendCircleId:(NSString*)friendCircleId  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///设置不让他看我朋友圈
+(void)FriendCircles_Set_NotAllowToSeeWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block;
///设置不看他朋友圈
+(void)FriendCircles_Set_NotLookWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block;
///取消不让他看我朋友圈
+(void)FriendCircles_Set_Cancle_NotAllowToSeeWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block;
///取消不看他朋友圈
+(void)FriendCircles_Set_Cancle_NotLookWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block;
///查看对好友设置的朋友圈权限
+(void)FriendCircles_Get_NotLook_PowerWithuserGuid:(NSString*)userGuid friendGuid:(NSString*)friendGuid And:(void(^)(NSDictionary *dic))block;

/// 在收藏里添加图片收藏 type=1
+(void)Collection_Add_collectionWithowner:(NSString*)owner imgArr:(NSArray*)imgArr tel:(NSString*)tel sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block;
///在收藏中添加文字收藏 type=2
+(void)Collection_Add_collectionWithowner:(NSString*)owner title:(NSString*)title ccontent:(NSString*)ccontent tel:(NSString*)tel sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block;
/// 在收藏中添加图文 type=3：一张图片  type=4：多张图片
+(void)Collection_Add_collectionWithowner:(NSString*)owner type:(NSString*)type  title:(NSString*)title ccontent:(NSString*)ccontent imgArr:(NSArray*)imgArr tel:(NSString*)tel  And:(void(^)(NSDictionary *dic))block;
///在收藏中添加语音 type=5
+(void)Collection_Add_collectionWithowner:(NSString*)owner  data:(NSData*)data tel:(NSString*)tel ccontent:(NSString*)ccontent sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block;
///在收藏中添加位置 type =6
+(void)Collection_Add_collectionWithowner:(NSString*)owner  position:(NSString*)position ccontent:(NSString*)ccontent sourceOwner:(NSString*)sourceOwner source:(NSString*)source And:(void(^)(NSDictionary *dic))block;
///收藏url+标题 type=7 连接
+(void)Collection_Add_collectionWithowner:(NSString*)owner  title:(NSString*)title url:(NSString*)url source:(NSString*)source  sourceOwner:(NSString*)sourceOwner And:(void(^)(NSDictionary *dic))block;
///收藏已经存在服务器上的图片 type=8
+(void)Collection_Add_collectionWithowner:(NSString*)owner url:(NSString*)url source:(NSString*)source  sourceOwner:(NSString*)sourceOwner And:(void(^)(NSDictionary *dic))block;
/// 收藏图片已经存在服务器上的图文 type =9
+(void)Collection_Add_collectionWithowner:(NSString*)owner  title:(NSString*)title url:(NSString*)url source:(NSString*)source  sourceOwner:(NSString*)sourceOwner ccontent:(NSString*)ccontent And:(void(^)(NSDictionary *dic))block;
///创建分组
+(void)Collection_Add_collectionGroupWithowner:(NSString*)owner  name:(NSString*)name And:(void(^)(NSDictionary *dic))block;
/// 查看分组
+(void)Collection_Get_collectionGroupsWithowner:(NSString*)owner And:(void(^)(NSDictionary *dic))block;
/// 修改分组名称
+(void)Collection_Update_collectionGroupWithowner:(NSString*)owner groupid:(NSString*)groupid name:(NSString*)name And:(void(^)(NSDictionary *dic))block;
/// 删除分组
+(void)Collection_Del_collectionGroupWithowner:(NSString*)owner groupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block;
///查看收藏
+(void)Collection_Get_collectionsWithowner:(NSString*)owner  group:(NSString*)group page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
/// 删除收藏 多个
+(void)Collection_Del_collectionsWithowner:(NSString*)owner  collections:(NSString*)collections And:(void(^)(NSDictionary *dic))block;
///移动收藏到别的分组
+(void)Collection_Move_collectionGroupWithowner:(NSString*)owner  collections:(NSString*)collections groupid:(NSString*)groupid And:(void(^)(NSDictionary *dic))block;

///修改收藏
+(void)Collection_Update_collectionWithowner:(NSString*)owner collid:(NSString*)collid type:(NSString*)type  title:(NSString*)title ccontent:(NSString*)ccontent And:(void(^)(NSDictionary *dic))block;

///搜索收藏
+(void)Collection_Search_collectionWithowner:(NSString*)owner  ccontent:(NSString*)ccontent  type:(NSString*)type  page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///添加离职单审批人
+(void)SetUp_Add_QuitCheckerWithcompanyId:(NSString*)companyId  userGUid:(NSString*)userGUid  cheker:(NSString*)cheker  departmentIds:(NSString*)departmentIds And:(void(^)(NSDictionary *dic))block;
///查看离职审批人
+(void)SetUp_Get_QuitCheckerWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///修改离职审批人的审批部门
+(void)SetUp_Update_QuitDpartmetnsWithquitchekcId:(NSString*)quitchekcId userGuid:(NSString*)userGuid departmentIds:(NSString*)departmentIds companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///修改离职审批人
+(void)SetUp_Update_QuitUserWithquitchekcId:(NSString*)quitchekcId userGuid:(NSString*)userGuid checker:(NSString*)checker  companyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///删除离职审批人
+(void)SetUp_Delete_QuitCheckerWithcompanyId:(NSString*)companyId userGUid:(NSString*)userGUid quitchekcId:(NSString*)quitchekcId And:(void(^)(NSDictionary *dic))block;
///获取已经设置的部门  离职审批
+(void)SetUp_Get_Department_ByPowerWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
/// 推送的相应code重置为 0
+(void)userashx_ResetCount_MsgCodeWithuserGuid:(NSString*)userGuid code:(NSString*)code And:(void(^)(NSDictionary *dic))block;
///查看各对应code的数值
+(void)userashx_GetCount_MsgCodeWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///获取公司的管理员
+(void)SetUp_Get_Company_AdminWithcompanyId:(NSString*)companyId And:(void(^)(NSDictionary *dic))block;
///最高领导人设置管理员
+(void)SetUp_Set_Admin_ByCompanyWithcompanyId:(NSString*)companyId  userGuid:(NSString*)userGuid  objecter:(NSString*)objecter And:(void(^)(NSDictionary *dic))block;
///查看版本号
+(void)Extended_Get_VersionInfoWithtype:(NSString*)type  version:(NSString*)version And:(void(^)(NSDictionary *dic))block;
///查看一张广告图片
+(void)Extended_Get_adImageAnd:(void(^)(NSDictionary *dic))block;
///获取某职位下现有的人数
+(void)Com_Get_post_XYrenshuWithpostid:(NSString*)postid And:(void(^)(NSDictionary *dic))block;
/// 获取某职位下30天内将要离职的人数
+(void)Com_Get_post_DLZrenshuWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid  postid:(NSString*)postid nday:(NSString*)nday And:(void(^)(NSDictionary *dic))block;
///添加人力需求申请
+(void)manPowerNeed_Add_mpnWithuserGuid:(NSString*)userGuid  depid:(NSString*)depid postid:(NSString*)postid XYrenshu:(NSString*)XYrenshu DLZrenshu:(NSString*)DLZrenshu recruitRenShu:(NSString*)recruitRenShu recruitReason:(NSString*)recruitReason demandAtWorkTime:(NSString*)demandAtWorkTime  remark:(NSString*)remark recruitType:(NSString*)recruitType comid:(NSString*)comid createrName:(NSString*)createrName And:(void(^)(NSDictionary *dic))block;
///审批“人力需求申请”
+(void)manPowerNeed_Check_mpnWithuserGuid:(NSString*)userGuid mpnId:(NSString*)mpnId isapproved:(NSString*)isapproved remark:(NSString*)remark And:(void(^)(NSDictionary *dic))block;
///审批人员查看需要审批的人力需求申请申请（列表）
+(void)manPowerNeed_Get_uncheckmpnl_admWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///审批人员查看自己审批过的人力需求申请申请列表
+(void)manPowerNeed_Get_checked_mpnl_admWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看自己的人力资源申请的列表 0 待审批 1 已通过 2 已拒绝
+(void)manPowerNeed_Get_mpns_createrWithuserGuid:(NSString*)userGuid status:(NSString*)status page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///根据id查看申请的人力资源申请详细信息
+(void)manPowerNeed_Get_mpn_detailInfoWithuserGuid:(NSString*)userGuid mpnId:(NSString*)mpnId And:(void(^)(NSDictionary *dic))block;
///关闭人力资源申请
+(void)manPowerNeed_Close_mpnWithuserGuid:(NSString*)userGuid mpnId:(NSString*)mpnId And:(void(^)(NSDictionary *dic))block;

///设置车辆管理人员
+(void)Com_Vehicle_Set_vehicleAdminWithuserGuid:(NSString*)userGuid comid:(NSString*)comid adminGuid:(NSString*)adminGuid  adminName:(NSString*)adminName type:(NSString*)type And:(void(^)(NSDictionary *dic))block;

/// 管理员添加新的车辆
+(void)Com_Vehicle_Add_newVehicleInfoWithcomid:(NSString*)comid userGuid:(NSString*)userGuid plateNumber:(NSString*)plateNumber VIN:(NSString*)VIN engineCode:(NSString*)engineCode vehicleType:(NSString*)vehicleType color:(NSString*)color seats:(NSString*)seats purchaseDate:(NSString*)purchaseDate annInspectDate:(NSString*)annInspectDate insuranceEndDate:(NSString*)insuranceEndDate  purchasePrice:(NSString*)purchasePrice remark:(NSString*)remark arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block;

/// 查看车辆信息表
+(void)Com_Vehicle_Get_vehicleListWithuserGuid:(NSString*)userGuid comid:(NSString*)comid  page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
/// 修改车辆信息
+(void)Com_Vehicle_Update_vehicleInfoWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId data:(NSString*)data And:(void(^)(NSDictionary *dic))block;
///删除车辆信息
+(void)Com_Vehicle_Del_vehicleInfoWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;
///查看车辆详细信息
+(void)Com_Vehicle_Get_vehicleDetailInfoWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;
///获取某辆车已被申请使用的时间（只显示结束时间在今天凌晨之后的）
+(void)Com_Vehicle_Get_vehicleApplyTimesWithvehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;

///根据时间筛选可用车辆
+(void)Com_Vehicle_GetAvaVehiclesByTimeWithcomid:(NSString*)comid startTime:(NSString*)startTime endTime:(NSString*)endTime And:(void(^)(NSDictionary *dic))block;
///添加用车申请
+(void)Com_Vehicle_Add_vehicleApplyWithcomid:(NSString*)comid vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber applyer:(NSString*)applyer applyerName:(NSString*)applyerName applyerDepId:(NSString*)applyerDepId applyerDepName:(NSString*)applyerDepName startTime:(NSString*)startTime endTime:(NSString*)endTime origin:(NSString*)origin destination:(NSString*)destination theDriverName:(NSString*)theDriverName personCount:(NSString*)personCount  theReason:(NSString*)theReason theCustomer:(NSString*)theCustomer theProject:(NSString*)theProject And:(void(^)(NSDictionary *dic))block;

///申请用车审批记录
+(void)Com_Vehicle_Check_vehicleApplyWithuserGuid:(NSString*)userGuid applyId:(NSString*)applyId option:(NSString*)option And:(void(^)(NSDictionary *dic))block;
///归还用车
+(void)Com_Vehicle_GiveBack_vehicleWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId givebackTime:(NSString*)givebackTime startingMileage:(NSString*)startingMileage endingMileage:(NSString*)endingMileage fuelBills:(NSString*)fuelBills roadToll:(NSString*)roadToll sendee:(NSString*)sendee And:(void(^)(NSDictionary *dic))block;

///添加车辆维修、保养记录
+(void)Com_Vehicle_Add_repairedRecordVWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber type:(NSString*)type agent:(NSString*)agent when:(NSString*)when cost:(NSString*)cost where:(NSString*)where remark:(NSString*)remark arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block;
///查看车辆维修、保养记录
+(void)Com_Vehicle_Get_vehicleRepairVWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;
/// 添加违章记录
+(void)Com_Vehicle_Add_vehiclelllegalWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber personLiableName:(NSString*)personLiableName theFine:(NSString*)theFine theDate:(NSString*)theDate theReason:(NSString*)theReason  isdone:(NSString*)isdone arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block;

/// 查看违章记录
+(void)Com_Vehicle_Get_vehiclelllegalWithuserGuid:(NSString*)userGuid comid:(NSString*)comid  page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;

///添加车辆事故记录
+(void)Com_Vehicle_Add_vehicleAccidentWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber personLiableName:(NSString*)personLiableName theTime:(NSString*)theTime thePlace:(NSString*)thePlace dutyRatio:(NSString*)dutyRatio cost:(NSString*)cost remark:(NSString*)remark arr_imgs:(NSArray*)arr_imgs And:(void(^)(NSDictionary *dic))block;

///查看事故记录
+(void)Com_Vehicle_Get_vehicleAccidentWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;

///添加车辆保险记录
+(void)Com_Vehicle_Add_vehicleInsuranceWithuserGuid:(NSString*)userGuid comid:(NSString*)comid createrName:(NSString*)createrName vehicleId:(NSString*)vehicleId plateNumber:(NSString*)plateNumber InsuranceCompany:(NSString*)InsuranceCompany InsuranceType:(NSString*)InsuranceType money:(NSString*)money theDate:(NSString*)theDate mileageThen:(NSString*)mileageThen agent:(NSString*)agent remark:(NSString*)remark And:(void(^)(NSDictionary *dic))block;

///查看保险记录
+(void)Com_Vehicle_Get_vehicleInsuranceWithuserGuid:(NSString*)userGuid comid:(NSString*)comid page:(NSString*)page vehicleId:(NSString*)vehicleId And:(void(^)(NSDictionary *dic))block;

/// 部门负责人查看待审批/已审批的车辆
+(void)Com_Vehicle_Get_vehicleCListByLeaderWithuserGuid:(NSString*)userGuid comid:(NSString*)comid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///车辆管理员查看待审批/已审批的车辆
+(void)Com_Vehicle_Get_vehicleCListByVAdminWithuserGuid:(NSString*)userGuid comid:(NSString*)comid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///申请人查看车辆
+(void)Com_Vehicle_Get_VApplyList_applientWithuserGuid:(NSString*)userGuid comid:(NSString*)comid type:(NSString*)type page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
/// 查看车辆申请详情
+(void)Com_Vehicle_Get_vehiApplyDetailWithuserGuid:(NSString*)userGuid comid:(NSString*)comid applicationId:(NSString*)applicationId And:(void(^)(NSDictionary *dic))block;

///查看车辆使用记录（集合)
+(void)Com_Vehicle_Get_vehicleUsedListWithuserGuid:(NSString*)userGuid comid:(NSString*)comid vehicleId:(NSString*)vehicleId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看车辆使用记录详情
+(void)Com_Vehicle_Get_vehicleUsedDetailWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid recordId:(NSString*)recordId And:(void(^)(NSDictionary *dic))block;

///创建岗位职责描述
+(void)Com_Create_postdetailinfoWithcompanyid:(NSString*)companyid postid:(NSString*)postid postName:(NSString*)postName depName:(NSString*)depName jobNature:(NSString*)jobNature salaryRange:(NSString*)salaryRange workdesc:(NSString*)workdesc educationcla:(NSString*)educationcla workexpecla:(NSString*)workexpecla agecla:(NSString*)agecla sexcla:(NSString*)sexcla pfskills:(NSString*)pfskills postgenre:(NSString*)postgenre creater:(NSString*)creater numOfStaff:(NSString*)numOfStaff And:(void(^)(NSDictionary *dic))block;
///修改职位的详细信息
+(void)Com_Update_postdetailinfoWithuserGuid:(NSString*)userGuid recordid:(NSString*)recordid data:(NSString*)data And:(void(^)(NSDictionary *dic))block;

///删除职位信息
+(void)Com_Del_postdetailinfoWithuserGuid:(NSString*)userGuid recordid:(NSString*)recordid And:(void(^)(NSDictionary *dic))block;
///管理员查看职位详细信息
+(void)Com_Adminget_postdetailinfoWithpostid:(NSString*)postid And:(void(^)(NSDictionary *dic))block;
/// 获取部门编制人数、现有人数、待离职人数
+(void)Com_Get_postRenShu_AllTypeWithuserGuid:(NSString*)userGuid  comid:(NSString*)comid postid:(NSString*)postid And:(void(^)(NSDictionary *dic))block;

///新建文章
+(void)Articles_Add_ArticleWithmenuId:(NSString*)menuId userGuid:(NSString*)userGuid title:(NSString*)title content:(NSString*)content homeImage:(NSString*)homeImage label:(NSString*)label source:(NSString*)source companyId:(NSString*)companyId textContent:(NSString*)textContent  And:(void(^)(NSDictionary *dic))block;
///新建文章菜单
+(void)Articles_Add_ArticleMenuWIthuserGuid:(NSString*)userGuid menuName:(NSString*)menuName And:(void(^)(NSDictionary *dic))block;
///查看文章菜单
+(void)Articles_Get_ArticleMenuWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
/// 修改文章菜单名称
+(void)Articles_Update_ArticleMenuWithuserGuid:(NSString*)userGuid articleMenuId:(NSString*)articleMenuId articleMenuName:(NSString*)articleMenuName And:(void(^)(NSDictionary *dic))block;
/// 删除文章菜单名称
+(void)Articles_Delete_ArticleMenuWithuserGuid:(NSString*)userGuid articleMenuId:(NSString*)articleMenuId And:(void(^)(NSDictionary *dic))block;
///获取回收站的文章
+(void)Articles_Get_Article_RecycleWithuserGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///删除回收站的文章
+(void)Articles_Delete_ArticleRecycleWithuserGuid:(NSString*)userGuid  articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block;
/// 恢复回收站的文章
+(void)Articles_Article_RecoveryWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block;

///保存草稿
+(void)Articles_Add_Article_DraftWithuserGuid:(NSString*)userGuid title:(NSString*)title content:(NSString*)content menuId:(NSString*)menuId textContent:(NSString*)textContent And:(void(^)(NSDictionary *dic))block;
///获取菜单下的文章
+(void)Articles_Get_Article_ByMenuWithuserGuid:(NSString*)userGuid menuId:(NSString*)menuId And:(void(^)(NSDictionary *dic))block;
///删除文章（放入回收站）
+(void)Articles_Delete_ArticleWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block;
///更新文章
+(void)Articles_Update_ArticleWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId articleTitle:(NSString*)articleTitle articleContent:(NSString*)articleContent textContent:(NSString*)textContent And:(void(^)(NSDictionary *dic))block;
///草稿发表文章
+(void)Articles_Add_Article_ByDraftWithmenuId:(NSString*)menuId userGuid:(NSString*)userGuid title:(NSString*)title content:(NSString*)content homeImage:(NSString*)homeImage label:(NSString*)label source:(NSString*)source companyId:(NSString*)companyId textContent:(NSString*)textContent draftId:(NSString*)draftId And:(void(^)(NSDictionary *dic))block;
///搜索文章  type =app : html
+(void)Articles_Get_Article_BySearchWithpara:(NSString*)para  page:(NSString*)page type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///发表文章评论
+(void)Articles_Add_ArtcielCommentWithuserGuid:(NSString*)userGuid  articleId:(NSString*)articleId parentid:(NSString*)parentid content:(NSString*)content parentUserGuid:(NSString*)parentUserGuid firstCommentId:(NSString*)firstCommentId And:(void(^)(NSDictionary *dic))block;
///查看文章评论
+(void)Articles_Get_ArticleCommentWitharticleId:(NSString*)articleId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///删除评论
+(void)Articles_Delete_ArticleCommentWithuserGuid:(NSString*)userGuid articleCommentId:(NSString*)articleCommentId articleId:(NSString*)articleId type:(NSString*)type And:(void(^)(NSDictionary *dic))block;
///评论点赞
+(void)Articles_Add_ArticleComment_ZanWithuserGuid:(NSString*)userGuid articleCommentId:(NSString*)articleCommentId And:(void(^)(NSDictionary *dic))block;
///查看文章详情
+(void)Articles_Get_Article_ByIdWitharticleId:(NSString*)articleId userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
/// 上传图片(单张) 返回绝对路径
+(void)Articles_CommitImageWithimg:(UIImage*)img And:(void(^)(NSDictionary *dic))block;
/// 查看最热文章
+(void)Articles_Get_ArticleWithpage:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///平台管理员设置精品文章
+(void)Articles_Set_Article_BoutiqueWithuserGuid:(NSString*)userGuid  articleId:(NSString*)articleId And:(void(^)(NSDictionary *dic))block;
///查看精品文章
+(void)Articles_Get_Article_ByBoutiqueWithpage:(NSString*)page And:(void(^)(NSDictionary *dic))block;
/// 查看企业文章
+(void)Articles_Get_ArticleByCompanyWithpage:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///关注用户
+(void)Articles_Add_Article_AttentionWithuserGuid:(NSString*)userGuid attention:(NSString*)attention And:(void(^)(NSDictionary *dic))block;
///取消关注
+(void)Articles_Cancle_ArticleAttentionWithuserGuid:(NSString*)userGuid  author:(NSString*)author And:(void(^)(NSDictionary *dic))block;
///获取关注列表
+(void)Articles_Get_Article_AttentionWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///查看我的粉丝（被关注的）
+(void)Articles_Get_Article_MyFansWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///获取我关注的人的文章
+(void)Articles_Get_Article_ByAttentionWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;

///获取最近几天的文章
+(void)Articles_Get_Article_ByTimeWithpage:(NSString*)page time:(NSString*)time And:(void(^)(NSDictionary *dic))block;
///通过标签获取文章
+(void)Articles_Get_Article_ByLableWithlable:(NSString*)lable page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///文章点赞
+(void)Articles_Add_Article_ZanWitharticleId:(NSString*)articleId  userGuid:(NSString*)userGuid And:(void(^)(NSDictionary *dic))block;
///查看点赞的文章
+(void)Articles_Get_Article_ByZanWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///举报文章
+(void)Articles_Add_Article_ReportWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId reason:(NSString*)reason reportType:(NSString*)reportType And:(void(^)(NSDictionary *dic))block;
///查看评论下的评论
+(void)Articles_Get_ChildCommentWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId firstCommentId:(NSString*)firstCommentId page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///查看单条父级评论下的评论
+(void)Articles_Get_ArticleCommentsWithuserGuid:(NSString*)userGuid articleCommentId:(NSString*)articleCommentId And:(void(^)(NSDictionary *dic))block;
//查看自己发布的文章
+(void)Articles_Get_MyArticleWithuserGuid:(NSString*)userGuid page:(NSString*)page And:(void(^)(NSDictionary *dic))block;
///对文章评论进行举报
+(void)Articles_Add_Article_Comment_ReportWithuserGuid:(NSString*)userGuid articleId:(NSString*)articleId articleCommentId:(NSString*)articleCommentId reason:(NSString*)reason reportType:(NSString*)reportType And:(void(^)(NSDictionary *dic))block;
@end
