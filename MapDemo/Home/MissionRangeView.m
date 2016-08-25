//
//  MissionRangeView.m
//  EasyMeter
//
//  Created by huweidong on 29/7/16.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import "MissionRangeView.h"
#import "MissionRangeCell.h"
#import "AppDelegate.h"

@interface MissionRangeView()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *rangeView;
@property (weak, nonatomic) IBOutlet UITableView *rangeTableView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (strong, nonatomic) NSMutableArray *rangeList;

@property (strong, nonatomic) PaymentCallBack compite;

@end

@implementation MissionRangeView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame AndDataList:(NSArray *)list{
    self=[super initWithFrame:frame];
    self=[[[NSBundle mainBundle] loadNibNamed:@"MissionRangeView" owner:self options:nil] lastObject];
    if (self) {
        self.frame=frame;
    }
    UITapGestureRecognizer * singal=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
    [self.bgView addGestureRecognizer:singal];
    self.rangeTableView.bounces=NO;
    self.rangeTableView.tableFooterView = [[UIView alloc] init];
    self.rangeList = [NSMutableArray arrayWithArray:list];
    [self seleceCell:0];
    
    return self;
}

- (void)show:(PaymentCallBack)compite{
    AppDelegate * delegate=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.compite=compite;
    self.frame=delegate.window.bounds;
    self.rangeView.transform= CGAffineTransformScale(self.rangeView.transform, 1.3, 1.3);
    [delegate.window addSubview:self];
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.rangeView.transform = CGAffineTransformScale(self.rangeView.transform, 1/1.3, 1/1.3);
                     }
                     completion:^(BOOL finished){}];
}

-(void)dismiss{
    [UIView animateWithDuration:0.15
                          delay:0
                        options:UIViewAnimationCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         self.rangeView.transform = CGAffineTransformScale(self.rangeView.transform, 0.5, 0.5);
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

-(void)seleceCell :(int)row{
    NSIndexPath *indexPath =[NSIndexPath indexPathForRow:row inSection:0];
    [self.rangeTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MissionRangeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MissionRangeCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MissionRangeCell" owner:self options:nil] lastObject];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            if(indexPath.row==3){
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
            }else{
                [cell setLayoutMargins:UIEdgeInsetsZero];
            }
        }
    }
    cell.titleStr=self.rangeList[indexPath.row];
    [cell loadData];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 41;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.compite) {
        self.compite((int)indexPath.row);
    }
    [self dismiss];
}

@end
