//
//  VersionViewController.m
//  KOC
//
//  Created by 高锐强 on 22/8/2015.
//  Copyright (c) 2015年 zxd. All rights reserved.
//

#import "VersionViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

#define _iPhone5     ([UIScreen mainScreen].bounds.size.height==568.0)
#define _iPhone6     ([UIScreen mainScreen].bounds.size.width==375.0)
#define _iPhone6Plus ([UIScreen mainScreen].bounds.size.width==414.0)

@interface VersionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;
@property (copy, nonatomic) NSString *strURL;
@property (assign, nonatomic) BOOL isChecking;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation VersionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image;
    if (_iPhone5) {
        image=[UIImage imageNamed:@"LaunchImage-700-568h"];
    }else if (_iPhone6){
        image=[UIImage imageNamed:@"LaunchImage-800-667h"];
    }else if (_iPhone6Plus){
        image=[UIImage imageNamed:@"LaunchImage-800-Portrait-736h"];
    }else{
        image=[UIImage imageNamed:@"LaunchImage-700"];
    }
    self.mainImageView.image=image;

    // Do any additional setup after loading the view from its nib.
    [self loadMain];
}


- (void)loadMain{
    AppDelegate * delegate=[UIApplication sharedApplication].delegate;
    UINavigationController * nav=(UINavigationController *)delegate.window.rootViewController;
    UIViewController *vc=[[MainViewController alloc] init];
    delegate.rootViewController=vc;
    [nav setViewControllers:@[vc] animated:NO];
}


@end
