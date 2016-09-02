//
//  GeocoderViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "GeocoderViewController.h"
#import "ForwardViewController.h"
#import "ReverseViewController.h"
#import "DistanceViewController.h"

@interface GeocoderViewController ()<UITabBarControllerDelegate>

@end

@implementation GeocoderViewController

#pragma mark -LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadViewControllerData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ResponseMethods

#pragma mark -PrivateMethods

-(void) loadViewControllerData{
    
    self.delegate=self;
    
    ForwardViewController* MyTabBar1=[[ForwardViewController alloc]initWithNibName:@"ForwardViewController" bundle:nil];
    MyTabBar1.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"編碼" image:nil selectedImage:nil];
    
    ReverseViewController* MyTabBar2=[[ReverseViewController alloc] initWithNibName:@"ReverseViewController" bundle:nil];
    MyTabBar2.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"反編碼" image:nil selectedImage:nil];
    
    DistanceViewController* MyTabBar3=[[DistanceViewController alloc]initWithNibName:@"DistanceViewController" bundle:nil];
    MyTabBar3.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"距離" image:nil selectedImage:nil];
   
    [self setViewControllers:@[MyTabBar1,MyTabBar2,MyTabBar3]];
    self.tabBar.tintColor=[UIColor blueColor];
}

#pragma mark -UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

@end
