//
//  MDCalloutAnnotationView.m
//  MapDemo
//
//  Created by guopu on 26/8/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "MDCalloutAnnotationView.h"
#import <Masonry.h>

@implementation MDAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end

@implementation MDCalloutAnnotation

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

@end


#define CalloutView_Width 189
#define CalloutView_Height 40

@interface MDCalloutAnnotationView()

@property (nonatomic, strong) UIImageView *imgBgView;

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imgViewLeft;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) UILabel *lbAddress;
@property (nonatomic, strong) UIImageView *imgViewRight;

@end


@implementation MDCalloutAnnotationView

-(instancetype)init{
    if(self=[super init]){
        [self layoutUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutUI];
    }
    return self;
}

- (void)layoutUI{
    
    __weak __typeof(&*self)weakSelf = self;
    // 背景圖
    self.imgBgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CalloutView_Width, CalloutView_Height)];
    self.imgBgView.contentMode=UIViewContentModeScaleAspectFill;
    [self addSubview:self.imgBgView];
    
    //內容VIEW 包含彈出內容
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.imgBgView addSubview:self.contentView];
    __block CGFloat space = 5.0;
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(weakSelf.imgBgView);
        make.bottom.equalTo(weakSelf.imgBgView.mas_bottom).offset(-6);
    }];
    
    //左邊icon
    self.imgViewLeft=[[UIImageView alloc] init];
    self.imgViewLeft.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imgViewLeft];
    [self.imgViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView.mas_left).offset(8.0);
        make.width.equalTo(@11);
        make.height.equalTo(@14);
    }];
    
    //分割線
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.imgViewLeft.mas_right).offset(space);
        make.width.equalTo(@0.5);
        make.top.equalTo(weakSelf.contentView.mas_top).offset(6.0);
        make.bottom.equalTo(weakSelf.contentView.mas_bottom).offset(-6.0);
    }];
    
    //地址
    self.lbAddress = [[UILabel alloc] init];
    self.lbAddress.textColor=[UIColor blackColor];
    self.lbAddress.font=[UIFont systemFontOfSize:13];
    [self.contentView addSubview:self.lbAddress];
    [self.lbAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.line.mas_right).offset(space);
    }];
    
    //右邊icon
    self.imgViewRight = [[UIImageView alloc] init];
    self.imgViewLeft.layer.masksToBounds=YES;
    self.imgViewLeft.contentMode=UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imgViewRight];
    [self.imgViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.lbAddress.mas_right).offset(space);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-8.0);
        make.width.equalTo(@7);
        make.height.equalTo(@13);
    }];
    
    self.centerOffset = CGPointMake(-CalloutView_Width/2.0, -50);
}

+ (instancetype)calloutViewWithMapView:(MKMapView *)mapView :(NSString *)key{
    MDCalloutAnnotationView *calloutView=(MDCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:key];
    if (!calloutView) {
        calloutView=[[MDCalloutAnnotationView alloc] init];
        //        calloutView.backgroundColor=[UIColor greenColor];
        //        calloutView.alpha = 0.5;
    }
    return calloutView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    [super setSelected:selected animated:animated];
}

#pragma mark 当给大头针视图设置大头针模型时可以在此处根据模型设置视图内容
-(void)setAnnotation:(MDCalloutAnnotation *)annotation{
    [super setAnnotation:annotation];

    self.imgBgView.image = annotation.imgBg;
    self.imgViewLeft.image = annotation.iconLeft;
    self.imgViewRight.image = annotation.iconRight;
    self.lbAddress.text = annotation.address;
}
@end
