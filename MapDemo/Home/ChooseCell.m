//
//  ChooseCell.m
//  EasyMeter
//
//  Created by huweidong on 1/8/16.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import "ChooseCell.h"

@interface ChooseCell()

@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;

@end

@implementation ChooseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.imageSelect.hidden=NO;
    }else{
        self.imageSelect.hidden=YES;
    }
    // Configure the view for the selected state
}

-(void)loadData{
    self.lbTitle.text=self.titleStr;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    
}
@end
