//
//  MenuCell.m
//  DrugStore
//
//  Created by canduo on 21/9/2015.
//  Copyright © 2015年 zxd. All rights reserved.
//

#import "MenuCell.h"
#import "clsMenu.h"

@interface MenuCell()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;

@end

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) loadData{
    self.iconImageView.image=[UIImage imageNamed:self.cls.MenuIcon];
    self.lbTitle.text=self.cls.MenuName;
}

@end
