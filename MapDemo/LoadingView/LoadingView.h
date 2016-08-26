//
//  LoadingView.h
//  LoadingTest
//
//  Created by canduo on 12/8/2015.
//  Copyright (c) 2015年 zxd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView

- (instancetype)initFullScreen:(NSString *) title;
-(void) setTitle:(NSString *)title;

- (instancetype)initWithFrame:(CGRect)frame :(NSString *) title;

-(void) dismiss;



@end
