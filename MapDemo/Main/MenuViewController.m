//
//  MenuViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuCell.h"
#import "clsMenu.h"
#import "AppDelegate.h"
#import "MainViewController.h"
#import "HomeViewController.h"
#import "FirstViewController.h"


static NSString *identifier = @"MenuCell";
@interface MenuViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray * dataList;

@end

@implementation MenuViewController

#pragma mark -LifeCycle
- (void) dealloc{
    if(self.dataList){
        [self.dataList removeAllObjects];
        self.dataList=nil;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *foot = [[UIView alloc] init];
    [self.tableView setTableFooterView:foot];
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    if([self.tableView respondsToSelector:@selector(setLayoutMargins:)])
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
    self.dataList = [clsMenu getMenus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:identifier owner:self options:nil] lastObject];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if([cell respondsToSelector:@selector(setLayoutMargins:)])
            [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    clsMenu *ocls = self.dataList[indexPath.row];
    cell.cls = ocls;
    [cell loadData];
    
    return cell;
}

#pragma mark -UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    MainViewController * mainVC= (MainViewController *)appdelegate.rootViewController;
    UINavigationController * navigationVC=(UINavigationController *)mainVC.contentViewController;
    UIViewController * rootVC=navigationVC.viewControllers[0];
    
    if(self.currentIndex==indexPath.row){
        [mainVC showContentView];
        return;
    }
    self.currentIndex=indexPath.row;
    switch (self.currentIndex) {
        case MenuID_Home:
            rootVC=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
            break;
            
        case MenuID_Menu1:
            rootVC=[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
            break;

        default:
            break;
    }
    [navigationVC setViewControllers:@[rootVC]];
    
    [mainVC showContentView];
    
}


@end
