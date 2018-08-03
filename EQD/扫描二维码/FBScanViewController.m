//
//  FBScanViewController.m
//  wenhua
//
//  Created by 梁新帅 on 2017/1/5.
//  Copyright © 2017年 FitBoy. All rights reserved.
//

#import "FBScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "SGScanningQRCodeView.h"
#import "WebRequest.h"
#import "EWMModel.h"
#import "FBWebUrlViewController.h"
#import "FBWifiManager.h"
#import "MyUUIDManager.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface FBScanViewController ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    UserModel *user;
    AMapLocationManager *locationManager;
    NSString *address;
    NSString *coodinate;
}

/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) SGScanningQRCodeView *scanningView;
@property (nonatomic, strong) UIButton *right_Button;
@property (nonatomic, assign) BOOL first_push;

@end

@implementation FBScanViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
   
    [self dingwei];
    address =[USERDEFAULTS objectForKey:Y_AMAP_address];
    coodinate =[USERDEFAULTS objectForKey:Y_AMAP_coordation];
 [self setupScanningQRCode];
    self.scanningView = [[SGScanningQRCodeView alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    
    [self.view addSubview:self.scanningView];

}
//高德地图定位
-(void)dingwei{
    
    [locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        //地址   regeocode.formattedAddress  经纬度 location.coordinate
        NSString* jinwei =[NSString stringWithFormat:@"%f,%f",location.coordinate.latitude,location.coordinate.longitude];
        NSString*  address =regeocode.formattedAddress;
        if(address.length==0)
        {
            [self dingwei];
        }else
        {
            NSArray  *tarr = @[regeocode.province,regeocode.city];
            [USERDEFAULTS setObject:jinwei forKey:Y_AMAP_coordation];
            [USERDEFAULTS setObject:address forKey:Y_AMAP_address];
            [USERDEFAULTS setObject:tarr forKey:Y_AMAP_cityProvince];
            [USERDEFAULTS synchronize];
        }
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden=NO;
    user =[WebRequest GetUserInfo];
    self.navigationItem.title = @"扫一扫添加好友";
    
    // 二维码扫描
//    [self setupScanningQRCode];
    self.first_push = YES;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    //    高德地图定位
    locationManager =[[AMapLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    locationManager.locationTimeout =10;
    //   逆地理请求超时时间，最低2s，此处设置为10s
    locationManager.reGeocodeTimeout = 10;
    
    
    if (self.image) {
        [self scanQRCodeFromPhotosInTheAlbum:self.image];
    }
    
}

#pragma mark - - - rightBarButtonItenAction 的点击事件
- (void)rightBarButtonItenAction {
    [self readImageFromAlbum];
}

#pragma mark - - - 从相册中读取照片
- (void)readImageFromAlbum {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
    imagePicker.delegate = self; // 指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册
    });
}

#pragma mark - - - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:image];
    }];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
//   NSLog(@"info - - - %@", info);
//}

/** 从相册中识别二维码, 并进行界面跳转 */
- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image {
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *scannedResult = feature.messageString;
        NSLog(@"scan=扫描结果=%@",scannedResult);
        if (self.first_push) {
            NSData *data = [scannedResult dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            EWMModel *model = [EWMModel mj_objectWithKeyValues:dic];
            if ([model.type integerValue]==2) {
                //加好友
                
                
                UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"添加好友" message:[NSString stringWithFormat:@"您将要发送添加%@为好友邀请",model.name] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action_queding =[UIAlertAction actionWithTitle:@"确定发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"添加好友");
                    NSString *mess =  alert.textFields[0].text;
                  
                    [WebRequest User_AddFriendWithuserid:user.Guid friendid:model.ugid content:mess  And:^(NSDictionary *dic) {
                        NSString *msg = dic[Y_MSG];
                        MBFadeAlertView  *alert = [[MBFadeAlertView alloc]init];
                        [alert showAlertWith:msg];
                            [self.navigationController popViewControllerAnimated:NO];
    
                    }];
                    
                    
                    
                }];
                UIAlertAction *action_cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:NO];
                }];
                
                [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                    textField.placeholder = @"我是……（验证消息）";
                }];
                [alert addAction:action_queding];
                [alert addAction:action_cancel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];
                });
                
            }
            else if([model.type integerValue]==1)
            {
                //加群
                
                UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"加群" message:[NSString stringWithFormat:@"您将要加入%@群",model.name] preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *action_queding =[UIAlertAction actionWithTitle:@"确定发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSString *userGuid = [NSString stringWithFormat:@";%@",user.Guid];
                  [WebRequest User_AddgroupWithuserGuid:userGuid Groupid:model.ugid GroupName:model.name And:^(NSDictionary *dic) {
                      MBFadeAlertView  *alertV = [[MBFadeAlertView  alloc]init];
                      [alertV showAlertWith:dic[Y_MSG]];
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          [self.navigationController popViewControllerAnimated:NO];
                      });
                  }];
       
                }];
                UIAlertAction *action_cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    [self.navigationController popViewControllerAnimated:NO];
                }];
                
                [alert addAction:action_queding];
                [alert addAction:action_cancel];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self presentViewController:alert animated:NO completion:nil];
                });

                
            }else if ([model.type integerValue]==3)
            {
                ///培训签到
                [self setQianDaoWithModel:model];
                
            }else if([model.type integerValue]==4)
            {
                ///会议签到
                [self setHuiYiWithModel:model];
            }
            else
            {
                //url连接
                FBWebUrlViewController *WUvc =[[FBWebUrlViewController alloc]init];
                WUvc.url =scannedResult;
                [self.navigationController pushViewController:WUvc animated:NO];
               
            }
           
            self.first_push = NO;
        }
    }
}
///会议考勤签到
-(void)setHuiYiWithModel:(EWMModel*)tmodel{
    
   NSString  *phone_name =[[UIDevice currentDevice] name];
    NSArray *tarr =[FBWifiManager getWifiName];
    NSString *wifiname=nil;
    NSString *macadress = nil;
    if (tarr.count==2) {
        wifiname =tarr[0];
        macadress =tarr[1];
    }else
    {
        wifiname =@"未知";
        macadress =@"未知";
    }
    
   NSString *UUID=[MyUUIDManager getUUID];
    if (address.length==0) {
        address =@"地址未知";
        coodinate=@"0.000000,0.000000";
    }
    [WebRequest Meeting_Meeting_signInWithuserGuid:user.Guid noticeId:tmodel.data.Id signInPosition:address macAddress:macadress wifiName:wifiname phoneModel:phone_name uuid:UUID And:^(NSDictionary *dic) {
        
        if ([dic[Y_STATUS] integerValue]==200) {
            
            NSString *meesage= [NSString stringWithFormat:@"地点:%@\n时间:%@~%@\n",tmodel.data.place,tmodel.data.startTime,tmodel.data.endTime];
            UIAlertController  *alert = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"[%@]会议签到",tmodel.data.type] message:meesage preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:NO];
            }]];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
        }else
        {
            MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
            [alert showAlertWith:dic[Y_MSG]];
        }
        
    }];
    
}

/// 培训考勤签到
-(void)setQianDaoWithModel:(EWMModel*)model{
    //考勤签到
    
   
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc]init];
    [dateFromatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *signStart  = [dateFromatter dateFromString:model.data.signStartTime];
    NSDate *endDate = [dateFromatter dateFromString:model.data.courseEndTime];
    if ([[endDate laterDate:[NSDate date]] isEqualToDate:endDate] && [[signStart earlierDate:[NSDate date]] isEqualToDate:signStart]) {
        //可以签到
        NSString*  phone_name =[[UIDevice currentDevice] name];
        NSString *wifiname=nil;
        NSString *macadress=nil;
        NSArray *tarr =[FBWifiManager getWifiName];
        if (tarr.count==2) {
            wifiname =tarr[0];
            macadress =tarr[1];
        }else
        {
            wifiname =@"未知";
            macadress =@"未知";
        }
        NSString* UUID=[MyUUIDManager getUUID];
        NSString *address =[USERDEFAULTS objectForKey:Y_AMAP_address];
        [WebRequest Training_Training_signInWithuserGuid:user.Guid userName:user.username siInfoId:model.data.Id depid:user.departId depName:user.department postid:user.postId postName:user.post signInPosition:address macAddress:macadress wifiName:wifiname phoneModel:phone_name uuid:UUID And:^(NSDictionary *dic) {
             if ([dic[Y_STATUS] integerValue]==200 ||[dic[Y_STATUS] integerValue]==208) {
                    NSString  *message  =[NSString stringWithFormat:@"当前课程:%@\n 讲师:%@\n 受训对象:%@\n 培训地点:%@\n 培训时间:%@\n",model.data.theTheme,model.data.teacherName,model.data.trainees,model.data.theplace,model.data.theTrainTime];
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"课程信息" message:message preferredStyle:UIAlertControllerStyleAlert];
                    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [self.navigationController popViewControllerAnimated:NO];
                    }]];
                 dispatch_async(dispatch_get_main_queue(), ^{
                     [self presentViewController:alert animated:NO completion:^{
                     }];
                 });
                 
                    
                }else
                {
                    MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
                    [alert showAlertWith:dic[Y_MSG]];
                }
       
            
        }];
        
    }else
    {
        MBFadeAlertView *alert = [[MBFadeAlertView alloc]init];
        [alert showAlertWith:@"不在签到的时间内"];
    }
    
    
  
}
#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕，这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    // 5、初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    // 5.1 添加会话输入
    [_session addInput:input];
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypePDF417Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    
    // 0、扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];
    
    // 1、如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2、删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3、设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
        NSLog(@"metadataObjects = %@", metadataObjects);
        NSLog(@"obj==%@+++%ld",obj.stringValue,(unsigned long)metadataObjects.count);
        
        
        NSData *data = [obj.stringValue dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        EWMModel *model = [EWMModel mj_objectWithKeyValues:dic];
        if ([model.type integerValue]==2) {
            //加好友
            
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"添加好友" message:[NSString stringWithFormat:@"您将要发送添加%@为好友邀请",model.name] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action_queding =[UIAlertAction actionWithTitle:@"确定发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"添加好友");
                //输入的验证消息
                NSString *mess =  alert.textFields[0].text;
            
                [WebRequest User_AddFriendWithuserid:user.Guid friendid:model.ugid content:mess And:^(NSDictionary *dic) {
                    NSString *msg = dic[Y_MSG];
                    MBFadeAlertView  *alertV = [[MBFadeAlertView  alloc]init];
                    [alertV showAlertWith:msg];
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self.navigationController popViewControllerAnimated:NO];
                        });
                    }];
                
                
            }];
            UIAlertAction *action_cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:NO];
            }];
            
            [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
                textField.placeholder = @"我是……（验证消息）";
            }];
            [alert addAction:action_queding];
            [alert addAction:action_cancel];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
        }
        else if([model.type integerValue]==1)
        {
            //加群
            
            UIAlertController *alert =[UIAlertController alertControllerWithTitle:@"加群" message:[NSString stringWithFormat:@"您将要加入%@群",model.name] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action_queding =[UIAlertAction actionWithTitle:@"确定发送" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                NSString *userGuid = [NSString stringWithFormat:@";%@",user.Guid];
                [WebRequest User_AddgroupWithuserGuid:userGuid Groupid:model.ugid GroupName:model.name And:^(NSDictionary *dic) {
                    
                    MBFadeAlertView  *alertV = [[MBFadeAlertView  alloc]init];
                    [alertV showAlertWith:dic[Y_MSG]];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:NO];
                    });
                   
                }];
                
            }];
            UIAlertAction *action_cancel =[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:NO];
            }];
            
         
            [alert addAction:action_queding];
            [alert addAction:action_cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self presentViewController:alert animated:NO completion:nil];
            });
            
            
        }else if ([model.type integerValue]==3)
        {
            [self setQianDaoWithModel:model];
        }else if ([model.type integerValue] ==4)
        {
            [self setHuiYiWithModel:model];
        }
        else
        {
            //url连接
            FBWebUrlViewController *WUvc =[[FBWebUrlViewController alloc]init];
            WUvc.url =obj.stringValue;
            [self.navigationController pushViewController:WUvc animated:NO];
            
        }
    }
}

// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
    //    NSLog(@" - - -- viewDidAppear");
}

#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
    NSLog(@"播放完成...");
}
/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1、获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    // 2、播放音频
    AudioServicesPlaySystemSound(soundID); // 播放音效
}




@end
