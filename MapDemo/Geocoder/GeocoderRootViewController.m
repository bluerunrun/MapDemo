//
//  GeocoderRootViewController.m
//  MapDemo
//
//  Created by guopu on 2/9/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "GeocoderRootViewController.h"
#import "GeocoderViewController.h"

@interface GeocoderRootViewController ()

@end

@implementation GeocoderRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    GeocoderViewController * vc=[[GeocoderViewController alloc] initWithNibName:@"GeocoderViewController" bundle:nil];
    UINavigationController * nav=[[UINavigationController alloc] initWithRootViewController:vc];
    nav.navigationBarHidden=YES;
    nav.view.frame=CGRectMake(0, 60, self.view.bounds.size.width, self.view.bounds.size.height-60);
    [self addChildViewController:nav];
    [self.view addSubview:nav.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ResponseMethods

- (IBAction)menuAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowMenu" object:nil];
}

@end
