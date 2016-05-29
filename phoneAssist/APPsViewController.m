//
//  APPsViewController.m
//  phoneAssist
//
//  Created by zhuang chaoxiao on 15/10/11.
//  Copyright (c) 2015年 zhuang chaoxiao. All rights reserved.
//

#import "APPsViewController.h"

@interface APPsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *view_1;
@property (weak, nonatomic) IBOutlet UILabel *view_2;
@property (weak, nonatomic) IBOutlet UILabel *view_3;
@property (weak, nonatomic) IBOutlet UILabel *view_4;
@property (weak, nonatomic) IBOutlet UILabel *view_5;
@property (weak, nonatomic) IBOutlet UILabel *view_6;
#define APP_URL1 @""
#define APP_URL2 @""
#define APP_URL3 @""
#define APP_URL4 @""
#define APP_URL5 @""
@end

@implementation APPsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem * leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStyleDone target:self action:@selector(leftClicked)];
    [self.navigationItem setLeftBarButtonItem:leftBtn];
    
//    self.title = @"应用推荐";
    self.title = @"Recommended Apps";
}

-(void)leftClicked
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch * t = [touches anyObject];
    
    CGPoint pt;
    
    pt = [t locationInView:_view_1];
    
    if( CGRectContainsPoint(_view_1.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL1]];
        
        return;
    }
    
    //
    pt = [t locationInView:_view_2];
    
    if( CGRectContainsPoint(_view_2.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL1]];
        
        return;
    }

    pt = [t locationInView:_view_3];
    
    if( CGRectContainsPoint(_view_3.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL3]];
        
        return;
    }
    
    pt = [t locationInView:_view_4];
    
    if( CGRectContainsPoint(_view_4.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL4]];
        
        return;
    }
    
    pt = [t locationInView:_view_4];
    
    if( CGRectContainsPoint(_view_4.bounds, pt) )
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL5]];
        
        return;
    }
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
