//
//  SignViewController.m
//  NewiPhoneADV
//
//  Created by zhuang chaoxiao on 15/8/13.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

//签到

#import "SignViewController.h"
#import "commData.h"
#import "CommInfo.h"
#import "AppDelegate.h"
#ifndef APP_HD
@import GoogleMobileAds;
#endif


#define SIGN_PER_SCORE    2

@interface SignViewController ()<UIAlertViewDelegate>
{
    SignInfo * signInfo;
}
- (IBAction)signClicked;
- (IBAction)ReChargeClicked;
@property (weak, nonatomic) IBOutlet UIView *advBgView;

@property (weak, nonatomic) IBOutlet UILabel *moneyLab;
@property (weak, nonatomic) IBOutlet UIButton *signBtn;
@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Sign To Make Calls";
    
    [self getSignInfo];
    
    if( [self dateSame:[NSDate date] date2:signInfo.lastDate] )
    {
        _signBtn.enabled = NO;
        [_signBtn setTitle:@"Last Checked" forState:UIControlStateNormal];
    }
    else
    {
        _signBtn.enabled = YES;
        [_signBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    }
    
    //搞个初始化随机数
    if( signInfo.score == 0 )
    {
        //
        int rand = arc4random() % 5;
        if( rand == 0 )
        {
            signInfo.score = 48;
        }
        else if( rand == 1 )
        {
            signInfo.score = 58;
        }
        else if( rand == 2 )
        {
            signInfo.score = 38;
        }
        else
        {
            signInfo.score = 68;
        }
    }
    
    _moneyLab.text = [NSString stringWithFormat:@"%ldScore",signInfo.score];
    
    //
    [self layoutADV];
    //
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSString *)publisherId
{
    return  BAIDU_APP_ID;
}


-(void)layoutADV
{
    //顶部
//    BaiduMobAdView * _baiduView = [[BaiduMobAdView alloc]init];
//    _baiduView.AdUnitTag = BAIDU_ADV_ID;
//    _baiduView.AdType = BaiduMobAdViewTypeBanner;
//    _baiduView.frame = CGRectMake(0, 0, kBaiduAdViewBanner468x60.width, kBaiduAdViewBanner468x60.height);
//    _baiduView.delegate = self;
//    [_advBgView addSubview:_baiduView];
//    [_baiduView start];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSignInfo
{
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [def objectForKey:STORE_SIGN_INFO];
    
    signInfo = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if( ! signInfo )
    {
        signInfo = [SignInfo new];
    }
}

-(void)setSignInfo
{
    signInfo.lastDate = [NSDate date];
    signInfo.score += SIGN_PER_SCORE;
    
    NSUserDefaults * def = [NSUserDefaults standardUserDefaults];
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:signInfo];
    [def setObject:data forKey:STORE_SIGN_INFO];
    [def synchronize];
    
    //
    _signBtn.enabled = NO;
    [_signBtn setTitle:@"今日已签到" forState:UIControlStateNormal];
    
    //
    _moneyLab.text = [NSString stringWithFormat:@"%ld元",signInfo.score];
}

-(BOOL)dateSame:(NSDate*)date1 date2:(NSDate*)date2
{
    double timezoneFix = [NSTimeZone localTimeZone].secondsFromGMT;
    
    if ((int)(([date1 timeIntervalSince1970] + timezoneFix)/(24*3600)) - (int)(([date2 timeIntervalSince1970] + timezoneFix)/(24*3600)) == 0)
    {
        return YES;
    }
    
    return NO;
}


- (IBAction)signClicked
{
    [self setSignInfo];
}

- (IBAction)ReChargeClicked
{
    if( signInfo.score < 100)
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您的余额不足，充值最少需要100元" delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"充值前请先给5星+好评吧~~" delegate:self cancelButtonTitle:@"现在就去" otherButtonTitles:@"不了", nil];
        alert.tag = 10086;
        [alert show];

    }
    
}

#pragma UIAlertView
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( (alertView.tag == 10086) && (buttonIndex == 0) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kAppStoreAddress]];
    }
}
@end
