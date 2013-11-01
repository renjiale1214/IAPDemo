//
//  ViewController.m
//  IAPpurchaseDemo
//
//  Created by shangxiaonan on 13-11-1.
//  Copyright (c) 2013年 Renjiale. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    purchaseDelegate = [[InAppPurchaseManager alloc] init];
    // Do any additional setup after loading the view from its nib.
    UIButton *buy = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buy.frame = CGRectMake(100, 320, 120, 27);
    [buy setTitle:@"购买6元图文咨询" forState:UIControlStateNormal];
    [buy addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buy];
}
-(void) buttonPressed:(UIButton *) button //go to buy
{
    [purchaseDelegate buy:mami100Twelve];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
