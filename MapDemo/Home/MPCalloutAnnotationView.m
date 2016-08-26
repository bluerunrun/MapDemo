//
//  MPCalloutAnnotationView.m
//  EasyMeter
//
//  Created by guopu on 26/7/16.
//  Copyright © 2016年 zxd. All rights reserved.
//

#import "MPCalloutAnnotationView.h"
#import <Masonry.h>

@implementation UMKAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end


@implementation MPAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end

#define CalloutView_Width 189
#define CalloutView_Height 40

@interface MPCalloutAnnotationView()

@property (nonatomic, strong) UIImageView *imgPin;

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UIImageView *imgBgView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imgIcon;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UIImageView *imgExpand;

@end

@implementation MPCalloutAnnotationView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.imgPin=[[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imgPin];
    }
    return self;
}

+(instancetype)calloutViewWithMapView:(MKMapView *)mapView :(NSString *)key{
    MPCalloutAnnotationView *calloutView=(MPCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:key];
    if (!calloutView) {
        calloutView=[[MPCalloutAnnotationView alloc] initWithFrame:CGRectMake(0, 0, 30, 37)];
//        calloutView.backgroundColor=[UIColor greenColor];
//        calloutView.alpha = 0.5;
    }
    return calloutView;
}

-(void)setImage:(UIImage *)pimage{
    self.imgPin.image=pimage;
//    MPAnnotation * dcannotation = self.annotation;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
    if (self.selected == selected){
        return;
    }
    
    if (selected)
    {
        if (self.baseView == nil)
        {
            self.baseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, CalloutView_Width, CalloutView_Height)];
            self.baseView.backgroundColor=[UIColor clearColor];
            [self addSubview:self.baseView];
//            self.baseView.alpha = 0.5;
            
            // 背景圖
            self.imgBgView=[[UIImageView alloc] initWithFrame:self.baseView.bounds];
            self.imgBgView.image=[UIImage imageNamed:@"pop_map_BG"];
            self.imgBgView.contentMode=UIViewContentModeScaleAspectFill;
            [self.baseView addSubview:self.imgBgView];
            
            //內容VIEW 包含彈出內容
            self.contentView = [[UIView alloc] init];
            self.contentView.backgroundColor = [UIColor clearColor];
            [self.imgBgView addSubview:self.contentView];
            
            //左邊icon
            self.imgIcon=[[UIImageView alloc] init];
            self.imgIcon.image = [UIImage imageNamed:@"mian_icon_location"];
            self.imgIcon.contentMode=UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:self.imgIcon];
            
            //分割線
            self.line = [[UIView alloc] init];
            self.line.backgroundColor = [UIColor lightGrayColor];
            [self.contentView addSubview:self.line];
            
            //地址
            self.lbAddress = [[UILabel alloc] init];
            self.lbAddress.textColor=[UIColor blackColor];
            self.lbAddress.font=[UIFont systemFontOfSize:13];
            self.lbAddress.text=[NSString stringWithFormat:@"澳門特別行政區花王堂荔湾大道"];
            [self.contentView addSubview:self.lbAddress];
            
            //右邊icon
            self.imgExpand = [[UIImageView alloc] init];
            self.imgExpand.image = [UIImage imageNamed:@"pop_icon_forward"];
            self.imgIcon.layer.masksToBounds=YES;
            self.imgIcon.contentMode=UIViewContentModeScaleAspectFill;
            [self.contentView addSubview:self.imgExpand];
            
            ////    以下為約束
            //內容view 包含彈出內容
            __weak __typeof(&*self)weakSelf = self;
            __block CGFloat space = 5.0;
            [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.right.equalTo(weakSelf.imgBgView);
                make.bottom.equalTo(weakSelf.imgBgView.mas_bottom).offset(-6);
            }];
            //左邊icon
            [self.imgIcon mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.contentView);
                make.left.equalTo(weakSelf.contentView.mas_left).offset(8.0);
                make.width.equalTo(@11);
                make.height.equalTo(@14);
            }];
            //分割線
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(weakSelf.imgIcon.mas_right).offset(space);
                make.width.equalTo(@0.5);
                make.top.equalTo(weakSelf.contentView.mas_top).offset(6.0);
                make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-6.0);
            }];
            //地址
            [self.lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.contentView);
                make.left.equalTo(weakSelf.line.mas_right).offset(space);
                make.right.equalTo(weakSelf.imgExpand.mas_left).offset(-space);
            }];
            //右邊icon
            [self.imgExpand mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.contentView);
                make.left.equalTo(weakSelf.lbAddress.mas_right).offset(space);
                make.right.equalTo(weakSelf.contentView.mas_right).offset(-8.0);
                make.width.equalTo(@7);
                make.height.equalTo(@13);
            }];
            
        }
        self.bounds=CGRectMake(0, 0, CalloutView_Width, self.imgPin.bounds.size.height+CalloutView_Height-9);
        self.centerOffset=CGPointMake(0, -(self.bounds.size.height-self.imgPin.bounds.size.height)/2.0);
        self.imgPin.center=CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height-(self.imgPin.bounds.size.height/2.0));
        [self addSubview:self.baseView];
    }else{
        
        [self.baseView removeFromSuperview];
        self.bounds = CGRectMake(0, 0, self.imgPin.bounds.size.width, self.imgPin.bounds.size.height);
        self.centerOffset=CGPointMake(0, 0);
        self.imgPin.center=CGPointMake(self.bounds.size.width/2.0, self.bounds.size.height/2.0);
    }
    
    UITapGestureRecognizer * singal=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapAction)];
    [self.baseView addGestureRecognizer:singal];
    
    [super setSelected:selected animated:animated];
}


-(void)TapAction{
    MPAnnotation * dcannotation = self.annotation;
    if(self.delegate && [self.delegate respondsToSelector:@selector(clickPinWithObj:)]){
        [self.delegate clickPinWithObj:dcannotation.obj];
    }
}
@end
