//
//  MenuCell.h
//  DrugStore
//
//  Created by canduo on 21/9/2015.
//  Copyright © 2015年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class clsMenu;

@interface MenuCell : UITableViewCell

@property (strong, nonatomic) clsMenu * cls;

-(void) loadData;

@end
