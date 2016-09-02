//
//  GeocoderViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "GeocoderViewController.h"

@interface GeocoderViewController ()<UITabBarControllerDelegate>

@property (assign,nonatomic) NSInteger currentIndex;
@property (assign, nonatomic) NSInteger shouldSelectIndex;

@end

@implementation GeocoderViewController

#pragma mark -LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -ResponseMethods

- (IBAction)menuAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowMenu" object:nil];
}

#pragma mark -PrivateMethods

-(void) loadViewControllerData{
    
    self.delegate=self;
//    
//    MissionViewController* MyTabBar1=[[MissionViewController alloc]initWithNibName:@"MissionViewController" bundle:nil];
//    MyTabBar1.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"任務" image:ImageNamed(@"menu_icon_task_nor") selectedImage:ImageNamed(@"menu_icon_task_sel")];
//    //[MyTabBar1.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    
//    ActivitiesViewController* MyTabBar2=[[ActivitiesViewController alloc]initWithNibName:@"ActivitiesViewController" bundle:nil];
//    MyTabBar2.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"活動" image:ImageNamed(@"menu_icon_activity_nor") selectedImage:ImageNamed(@"menu_icon_activity_sel")];
//    //[MyTabBar2.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
//    
//    AddMissionViewController* MyTabBar3=[[AddMissionViewController alloc]initWithNibName:@"AddMissionViewController" bundle:nil];
//    MyTabBar3.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"" image:ImageNamed(@"menu_icon_release") selectedImage:ImageNamed(@"menu_icon_release")];
//    [MyTabBar3.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
//    
//    
//    ComplaintCenterVC* MyTabBar4=[[ComplaintCenterVC alloc]initWithNibName:@"ComplaintCenterVC" bundle:nil];
//    MyTabBar4.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"投訴" image:ImageNamed(@"menu_icon_Complaint_nor") selectedImage:ImageNamed(@"menu_icon_Complaint_sel")];
//    //[MyTabBar4.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
//    
//    PersonalViewController* MyTabBar5=[[PersonalViewController alloc]initWithNibName:@"PersonalViewController" bundle:nil];
//    MyTabBar5.tabBarItem=[[UITabBarItem alloc] initWithTitle:@"我的" image:ImageNamed(@"menu_icon_my_nor") selectedImage:ImageNamed(@"menu_icon_my_sel")];
//    //[MyTabBar5.tabBarItem setImageInsets:UIEdgeInsetsMake(6, 0, -6, 0)];
//    
//    [self setViewControllers:@[MyTabBar1,MyTabBar2,MyTabBar3,MyTabBar4,MyTabBar5]];
//    self.tabBar.tintColor=TabText;
}

#pragma mark -UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    return YES;
}

@end
