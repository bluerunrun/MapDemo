//
//  clsOtherFun.m
//  EasyMeter
//
//  Created by canduo on 21/7/2016.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import "clsOtherFun.h"
#import "AppDelegate.h"
#import "LoadingView.h"

@implementation clsOtherFun

#pragma mark loadingView
static LoadingView *_newLoadingView = nil;
+ (void)showLoadingView:(NSString *)title {
    if (!_newLoadingView) {
        _newLoadingView =[[LoadingView alloc] initFullScreen:title];
    } else {
        [_newLoadingView setTitle:title];
    }
}

+ (void)hideLoadingView {
    if (_newLoadingView) {
        [_newLoadingView dismiss];
        _newLoadingView = nil;
    }
}
@end
