//
//  MDCalloutAnnotationView.h
//  MapDemo
//
//  Created by guopu on 26/8/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import <MapKit/MapKit.h>

//大头针模型 MDAnnotation
@interface MDAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


//自定义一个图片属性在创建大头针视图时使用
@property (nonatomic,strong) UIImage *image;

//背景图
@property (nonatomic,strong) UIImage *imgBg;
//左侧图标
@property (nonatomic,strong) UIImage *iconLeft;
//右侧图标
@property (nonatomic,strong) UIImage *iconRight;
//地址
@property (nonatomic,copy) NSString *address;

@end


//弹出详情大头针模型：MDCalloutAnnotation
@interface MDCalloutAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy,readonly) NSString *title;
@property (nonatomic, copy,readonly) NSString *subtitle;

//背景图
@property (nonatomic,strong) UIImage *imgBg;
//左侧图标
@property (nonatomic,strong) UIImage *iconLeft;
//右侧图标
@property (nonatomic,strong) UIImage *iconRight;
//地址
@property (nonatomic,copy) NSString *address;

@end


//弹出详情大头针视图：MDCalloutAnnotationView
@interface MDCalloutAnnotationView : MKAnnotationView

@property (nonatomic ,strong) MDCalloutAnnotation *annotation;

#pragma mark 从缓存取出标注视图
+(instancetype)calloutViewWithMapView:(MKMapView *)mapView :(NSString *)key;

@end







