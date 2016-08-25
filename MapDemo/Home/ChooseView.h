//
//  ChooseView.h
//  EasyMeter
//
//  Created by huweidong on 29/7/16.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^PaymentCallBack)(int rangeIndex);

@interface ChooseView : UIView

- (instancetype)initWithFrame:(CGRect)frame AndDataList:(NSArray *)list;
- (void)show:(PaymentCallBack) compite;
-(void)seleceCell :(int)row;

@end
