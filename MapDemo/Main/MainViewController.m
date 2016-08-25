//
//  MainViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "HomeViewController.h"
#import "clsMenu.h"
#import "CustomNavigationController.h"

@interface MainViewController ()<UIGestureRecognizerDelegate>

@end

@implementation MainViewController

#pragma mark -LifeCycle

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    UIPanGestureRecognizer *reg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(revealGesture:)];
    reg.delegate=self;
    [self.view addGestureRecognizer:reg];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ShowMenu) name:@"ShowMenu" object:nil];
    
    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    menuVC.currentIndex=MenuID_Home;
    
    HomeViewController * homeVC=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    CustomNavigationController * nav=[[CustomNavigationController alloc] initWithRootViewController:homeVC];
    nav.navigationBarHidden=YES;
    
    self.contentViewController = nav;
    self.sidebarViewController = menuVC;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -PublicMethods
-(void) showContentView{
    [super toggleSidebar:!self.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}

#pragma mark -CustomDelegate

- (void)revealGesture:(UIPanGestureRecognizer *)recognizer {
    UINavigationController *navVC = (UINavigationController *)self.contentViewController;
    if (navVC.viewControllers.count<=1) {
        [super dragContentView:recognizer];
    }
}

-(void)ShowMenu{
    [self.view endEditing:YES];
    [super toggleSidebar:!self.sidebarShowing duration:kGHRevealSidebarDefaultAnimationDuration];
}

#pragma mark -UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    [self.view endEditing:YES];
    return YES;
}

@end
