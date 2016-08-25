//
//  ChooseCell.h
//  EasyMeter
//
//  Created by huweidong on 1/8/16.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseCell : UITableViewCell

@property (nonatomic, assign) BOOL imageIsHidden;
@property (nonatomic, copy) NSString *titleStr;

-(void)loadData;

@end
