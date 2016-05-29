//
//  PhoneInfoViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "PhoneInfoViewController.h"
#import "SystemServices.h"
#import "SSAccelerometerInfo.h"
#import "NSObject+PerformBlockAfterDelay.h"
#import "CommData.h"

#define SystemSharedServices [SystemServices sharedServices]

#define LAB_VIEW_BG_COLOR  [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]//[UIColor grayColor]

#ifndef APP_HD
@import GoogleMobileAds;
#endif
@interface PhoneInfoViewController ()
@property (weak, nonatomic) IBOutlet UIView *advBgView;
@end

@implementation PhoneInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    
        self.title = @"System Message";
        
        self.view.backgroundColor = [UIColor whiteColor];
        
        NSArray * itemArray = @[@"     Phone Name:  ",@"     Phone Type:  ",@"     System Version:  ",@"     Used Hours:  ",@"     Screen Size:  ",@"     Screen Brightness:  ",@"     Remained Battery:  ",@"     Current Status:  ",@"     Language:  ",@"     Time-Zone:  "];
        
        UIScrollView * scrView = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self.view addSubview:scrView];
        
        
        
        CGFloat yPos = 0;
        int index = 0;
        int const VIEW_HEIGHT = 35;
        UIFont * font = [UIFont systemFontOfSize:15];
    
        {
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices deviceName]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices systemDeviceTypeFormatted]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices systemsVersion]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            NSArray *uptimeFormat = [[SystemSharedServices systemsUptime] componentsSeparatedByString:@" "];
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@d%@h%@m",itemArray[index++],[uptimeFormat objectAtIndex:0], [uptimeFormat objectAtIndex:1], [uptimeFormat objectAtIndex:2]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%ldX%ld",itemArray[index++],(long)[SystemSharedServices screenWidth],(long)[SystemSharedServices screenHeight]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%.0f%%",itemArray[index++],[SystemSharedServices screenBrightness]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%.0f%%",itemArray[index++],[SystemSharedServices batteryLevel]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices country]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices language]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
        
        {
            yPos += VIEW_HEIGHT+1;
            
            UILabel * lab = [[UILabel alloc]initWithFrame:CGRectMake(0, yPos, scrView.frame.size.width, VIEW_HEIGHT)];
            lab.text = [NSString stringWithFormat:@"%@%@",itemArray[index++],[SystemSharedServices timeZoneSS]];
            lab.backgroundColor = LAB_VIEW_BG_COLOR;
            lab.font = font;
            
            [scrView addSubview:lab];
        }
    
    [self layoutADV];
}




- (NSString *)publisherId
{
    return  BAIDU_APP_ID;
}


-(void)layoutADV
{
    #ifndef APP_HD
    CGPoint pt ;
    
    pt = CGPointMake(0, 0);
    GADBannerView * _bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner origin:pt];
    
    _bannerView.adUnitID = ADMOB_ADV_ID;
    _bannerView.rootViewController = self;
    GADRequest*request=[GADRequest request];
    request.testDevices = @[ @"1467727316ae1a43096208c0ecac2d3c" ];
    [_bannerView loadRequest:request];
    
    [_advBgView addSubview:_bannerView];
#endif
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
