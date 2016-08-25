//
//  clsMenu.h
//  AWC
//
//  Created by Ruin on 16/10/14.
//  Copyright (c) 2014年 sanvio. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MenuID_Home,
    MenuID_Menu1,
    MenuID_Menu2,
    MenuID_Menu3,
    MenuID_Menu4,
    MenuID_Menu5,
    MenuID_Menu6
} MenuIDEnum;


@interface clsMenu : NSObject

@property (nonatomic, assign) NSInteger MenuID;
@property (nonatomic, copy) NSString *MenuName;
@property (nonatomic, copy) NSString *MenuIcon;

+ (NSMutableArray *)getMenus;

@end
