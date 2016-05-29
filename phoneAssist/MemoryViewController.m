//
//  MemoryViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/10.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "MemoryViewController.h"
#import "SystemServices.h"
#import "PCPieChart.h"
#import "CommData.h"

#ifndef APP_HD
@import GoogleMobileAds;
#endif
#define SystemSharedServices [SystemServices sharedServices]

#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568)?TRUE:FALSE

@interface MemoryViewController ()
{
    PCPieChart *pieChart;
    NSMutableArray *components;
}
@property (weak, nonatomic) IBOutlet UILabel *allMem;
@property (weak, nonatomic) IBOutlet UILabel *usedMem;
@property (weak, nonatomic) IBOutlet UILabel *wiredMem;
@property (weak, nonatomic) IBOutlet UILabel *actMem;
@property (weak, nonatomic) IBOutlet UILabel *inActMem;
@property (weak, nonatomic) IBOutlet UILabel *freeMem;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIView *advBgView;

@end

@implementation MemoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Get all the memory info
    [self performSelector:@selector(getAllMemoryInformation)];
    
    // Get all the data
    components = [[NSMutableArray alloc] init];
    
    // Make the piechart view
    int yPosition = (isiPhone5) ? 150 : 150;
    int height = [[UIScreen mainScreen] bounds].size.width/3*2.; // 220;
    int width = [[UIScreen mainScreen] bounds].size.width - 7; //320;
    pieChart = [[PCPieChart alloc] initWithFrame:CGRectMake(0,yPosition,width,height)];
    [pieChart setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [pieChart setDiameter:width/2];
    [pieChart setSameColorLabel:YES];
    
    // Add the piechart to the view
    [_contentView addSubview:pieChart];
    
    // Set up for iPad and iPhone
    if ([[UIDevice currentDevice] userInterfaceIdiom]==UIUserInterfaceIdiomPad)
    {
        pieChart.titleFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:30];
        pieChart.percentageFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:50];
    }
    
    // Make all the components
    PCPieComponent *component1 = [PCPieComponent pieComponentWithTitle:@"Used Memory" value:[SystemSharedServices usedMemoryinPercent]];
    [component1 setColour:PCColorYellow];
    [components addObject:component1];
    
    PCPieComponent *component2 = [PCPieComponent pieComponentWithTitle:@"Wired Memory" value:[SystemSharedServices wiredMemoryinPercent]];
    [component2 setColour:PCColorGreen];
    [components addObject:component2];
    
    PCPieComponent *component3 = [PCPieComponent pieComponentWithTitle:@"Active Memory" value:[SystemSharedServices activeMemoryinPercent]];
    [component3 setColour:PCColorOrange];
    [components addObject:component3];
    
    PCPieComponent *component4 = [PCPieComponent pieComponentWithTitle:@"Inactive Memory" value:[SystemSharedServices inactiveMemoryinPercent]];
    [component4 setColour:PCColorRed];
    [components addObject:component4];
    
    PCPieComponent *component5 = [PCPieComponent pieComponentWithTitle:@"Free Memory" value:[SystemSharedServices freeMemoryinPercent]];
    [component5 setColour:PCColorBlue];
    [components addObject:component5];
    
    
    // Set all the componenets
    [pieChart setComponents:components];
    
    self.title = @"Memory Information";
    
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
    //
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
    
    pt = CGPointMake(0, 3);
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

// Get all the memory information and put it on the labels
- (void)getAllMemoryInformation
{
    
     // Amount of Memory (RAM)
     self.allMem.text = [NSString stringWithFormat:@"Total   : %.2f MB",[SystemSharedServices totalMemory]];
     
     // Used Memory
     self.usedMem.text = [NSString stringWithFormat:@"Used    : %.2f MB %.0f%%", [SystemSharedServices usedMemoryinRaw], [SystemSharedServices usedMemoryinPercent]];
     //[self.lblUsedMemory setTextColor:PCColorYellow];
     
     // Wired Memory
     self.wiredMem.text = [NSString stringWithFormat:@"Wired   : %.2f MB %.0f%%", [SystemSharedServices wiredMemoryinRaw], [SystemSharedServices wiredMemoryinPercent]];
     //[self.lblWiredMemory setTextColor:PCColorGreen];
     
     // Active Memory
     self.actMem.text = [NSString stringWithFormat:@"Active  : %.2f MB %.0f%%", [SystemSharedServices activeMemoryinRaw], [SystemSharedServices activeMemoryinPercent]];
     //[self.lblActiveMemory setTextColor:PCColorOrange];
     
     // Inactive Memory
     self.inActMem.text = [NSString stringWithFormat:@"Inactive: %.2f MB %.0f%%", [SystemSharedServices inactiveMemoryinRaw], [SystemSharedServices inactiveMemoryinPercent]];
     //[self.lblInactiveMemory setTextColor:PCColorRed];
     
     // Free Memory
     self.freeMem.text = [NSString stringWithFormat:@"Free    : %.2f MB %.0f%%", [SystemSharedServices freeMemoryinRaw], [SystemSharedServices freeMemoryinPercent]];
     //[self.lblFreeMemory setTextColor:PCColorBlue];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)orientation
                                duration:(NSTimeInterval)duration{
    NSLog(@"Frame: %f, %f, %f, %f", pieChart.frame.origin.x, pieChart.frame.origin.y, pieChart.frame.size.width, pieChart.frame.size.height);
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
