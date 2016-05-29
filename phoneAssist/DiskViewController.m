//
//  DiskViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "DiskViewController.h"
#import "VWWWaterView.h"
#import "CommData.h"
#import "SystemServices.h"
#ifndef APP_HD
@import GoogleMobileAds;
#endif
#define SystemSharedServices [SystemServices sharedServices]

@interface DiskViewController ()<WaterViewDelegate>

@property (weak, nonatomic) IBOutlet VWWWaterView *diskView;
@property (weak, nonatomic) IBOutlet UILabel *totalLab;
@property (weak, nonatomic) IBOutlet UILabel *usedLab;
@property (weak, nonatomic) IBOutlet UILabel *freeLab;
@property (weak, nonatomic) IBOutlet UIView *advBgView;
@end

@implementation DiskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    self.title = @"存储容量";
    self.title = @"Storage";
    
    _diskView.waterDelegate = self;
    
    _totalLab.text = [SystemSharedServices diskSpace];
    _usedLab.text = [SystemSharedServices usedDiskSpaceinRaw];
    _freeLab.text = [SystemSharedServices freeDiskSpaceinRaw];
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    [self layoutADV];
    
    //
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma arguments
-(CGFloat)getPercent
{
    return [[SystemSharedServices usedDiskSpaceinPercent] floatValue]/100.0;
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
@end
