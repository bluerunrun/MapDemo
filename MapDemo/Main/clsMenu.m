
//
//  clsMenu.m
//  AWC
//
//  Created by Ruin on 16/10/14.
//  Copyright (c) 2014年 sanvio. All rights reserved.
//

#import "clsMenu.h"

@implementation clsMenu

@synthesize MenuID;
@synthesize MenuName;
@synthesize MenuIcon;

- (id)init {
    self = [super init];
    if (self) {
        MenuID = 0;
        MenuName = @"";
        MenuIcon=@"";
    }
    return self;
}


+ (NSMutableArray *)getMenus {
    NSMutableArray *list = [NSMutableArray array];
    clsMenu *Menu = nil;
    
    Menu = [[clsMenu alloc] init];
    Menu.MenuID = MenuID_Home;
    Menu.MenuName = @"主頁";
    Menu.MenuIcon=@"icon_home";
    [list addObject:Menu];
    
    Menu = [[clsMenu alloc] init];
    Menu.MenuID = MenuID_Menu1;
    Menu.MenuName = @"Menu1";
    Menu.MenuIcon=@"icon_search_medicine";
    [list addObject:Menu];
    
    return list;
}



@end
