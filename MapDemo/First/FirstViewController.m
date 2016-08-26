//
//  FirstViewController.m
//  MenuDemo
//
//  Created by guopu on 22/6/16.
//  Copyright © 2016年 blue. All rights reserved.
//

#import "FirstViewController.h"
#import "MPCalloutAnnotationView.h"
#import "MDCalloutAnnotationView.h"
#import "ChooseView.h"
#import "clsOtherFun.h"

@interface FirstViewController ()<MKMapViewDelegate,CLLocationManagerDelegate,CalloutViewClickDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapKitView;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) NSMutableArray * annotions;

@property (nonatomic, assign) int selectIndex;

@end

@implementation FirstViewController

-(void)dealloc{
    if (self.mapKitView) {
        self.mapKitView.showsUserLocation = NO;
        self.mapKitView.userTrackingMode  = MKUserTrackingModeFollow;
        [self.mapKitView.layer removeAllAnimations];
        [self.mapKitView removeAnnotations:self.mapKitView.annotations];
        self.mapKitView.delegate = nil;
        self.mapKitView = nil;
    }
    if(self.annotions){
        [self.annotions removeAllObjects];
        self.annotions=nil;
    }
    self.userLocation=nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initMap];
    
    self.selectIndex = 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -PrivateMethods
- (void)initMap{
    //设置MKMapView
    self.mapKitView.delegate=self;
    self.mapKitView.showsUserLocation=YES;
    self.mapKitView.userTrackingMode = MKUserTrackingModeFollow;
    self.mapKitView.mapType=MKMapTypeStandard;
    
}

- (void)addMPAnnotations{
    CLLocationDegrees lat = self.userLocation?self.userLocation.coordinate.latitude:DefaultCoordinate.latitude;
    CLLocationDegrees lon = self.userLocation?self.userLocation.coordinate.longitude:DefaultCoordinate.longitude;
    NSMutableArray *dataList = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        lat = (i%2==0)?(lat+0.0003*i):(lat-0.0005*i);
        lon = (i%2==0)?(lon+0.0008*i):(lon-0.0004*i);
        CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(lat,lon);
        MPAnnotation *annotation= [[MPAnnotation alloc] init];
        annotation.coordinate=coord;
        [dataList addObject:annotation];
    }
    
    double minLat = 360.0f, maxLat = -360.0f;
    double minLon = 360.0f, maxLon = -360.0f;
    self.annotions=[NSMutableArray array];
    if (dataList.count > 0) {
        for (MPAnnotation *obj in dataList) {
            if ( obj.coordinate.latitude < minLat ) minLat = obj.coordinate.latitude;
            if ( obj.coordinate.latitude  > maxLat ) maxLat = obj.coordinate.latitude;
            if ( obj.coordinate.longitude < minLon ) minLon = obj.coordinate.longitude;
            if ( obj.coordinate.longitude > maxLon ) maxLon = obj.coordinate.longitude;
            [self.annotions addObject:obj];
        }
        
        CLLocationDegrees latitudeDelta,longitudeDelta;
        latitudeDelta = (maxLat - minLat)*1.8;
        longitudeDelta =  (maxLon - minLon)*1.8;
        if(dataList.count==1){
            latitudeDelta = 0.03;
            longitudeDelta = 0.03;
        }
        if (latitudeDelta<0||latitudeDelta>180) {
            latitudeDelta = 180;
        }
        if (longitudeDelta<0||longitudeDelta>360) {
            longitudeDelta = 360;
        }
        [self.mapKitView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0), MKCoordinateSpanMake(latitudeDelta, longitudeDelta)) animated:YES];
    }
    
    [self removeAllAnnotation];
    [self.mapKitView addAnnotations:self.annotions];
}

- (void)addMDAnnotations{
    CLLocationDegrees lat = self.userLocation?self.userLocation.coordinate.latitude:DefaultCoordinate.latitude;
    CLLocationDegrees lon = self.userLocation?self.userLocation.coordinate.longitude:DefaultCoordinate.longitude;
    NSMutableArray *dataList = [NSMutableArray array];
    for (int i=0; i<4; i++) {
        lat = (i%2==0)?(lat+0.0003*i):(lat-0.0005*i);
        lon = (i%2==0)?(lon+0.0008*i):(lon-0.0004*i);
        CLLocationCoordinate2D coord=CLLocationCoordinate2DMake(lat,lon);
        MDAnnotation *annotation= [[MDAnnotation alloc] init];
        annotation.coordinate=coord;
        annotation.image = [UIImage imageNamed:@"main_icon_Parking-Metre"];
        annotation.imgBg=[UIImage imageNamed:@"pop_map_BG"];
        annotation.iconLeft=[UIImage imageNamed:@"mian_icon_location"];
        annotation.iconRight=[UIImage imageNamed:@"pop_icon_forward"];
        annotation.address=[NSString stringWithFormat:@"澳門特別行政區花王堂荔湾大道"];
        [dataList addObject:annotation];
    }
    
    double minLat = 360.0f, maxLat = -360.0f;
    double minLon = 360.0f, maxLon = -360.0f;
    self.annotions=[NSMutableArray array];
    if (dataList.count > 0) {
        for (MDAnnotation *obj in dataList) {
            if ( obj.coordinate.latitude < minLat ) minLat = obj.coordinate.latitude;
            if ( obj.coordinate.latitude  > maxLat ) maxLat = obj.coordinate.latitude;
            if ( obj.coordinate.longitude < minLon ) minLon = obj.coordinate.longitude;
            if ( obj.coordinate.longitude > maxLon ) maxLon = obj.coordinate.longitude;
            [self.annotions addObject:obj];
        }
        
        CLLocationDegrees latitudeDelta,longitudeDelta;
        latitudeDelta = (maxLat - minLat)*1.8;
        longitudeDelta =  (maxLon - minLon)*1.8;
        if(dataList.count==1){
            latitudeDelta = 0.03;
            longitudeDelta = 0.03;
        }
        if (latitudeDelta<0||latitudeDelta>180) {
            latitudeDelta = 180;
        }
        if (longitudeDelta<0||longitudeDelta>360) {
            longitudeDelta = 360;
        }
        [self.mapKitView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake((minLat+maxLat)/2.0, (minLon+maxLon)/2.0), MKCoordinateSpanMake(latitudeDelta, longitudeDelta)) animated:YES];
    }
    
    [self removeAllAnnotation];
    [self.mapKitView addAnnotations:self.annotions];
}

- (void)goToPosition:(CLLocationCoordinate2D)coordinate{
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, MKCoordinateSpanMake(0.01, 0.01));
    [self.mapKitView setRegion:region animated:YES];
}

#pragma mark -ResponseMethods

- (IBAction)menuAction:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowMenu" object:nil];
}

- (IBAction)locateAction:(UIButton *)sender {
    
    if (self.userLocation) {
        //NSLog(@"根據放大level定位到用戶位置");
        [self.mapKitView setCenterCoordinate:self.userLocation.coordinate animated:YES];
    }else{
        //NSLog(@"定位失败 显示澳门地区");
        [self.mapKitView setCenterCoordinate:DefaultCoordinate animated:YES];
    }
}

- (IBAction)chooseAction:(id)sender {
    __weak __typeof(self)weakSelf = self;
    NSMutableArray *list = [NSMutableArray arrayWithObjects:@"同一模型",@"不同模型",@"下雨动画", nil];
    ChooseView *chooseView=[[ChooseView alloc] initWithFrame:self.view.bounds AndDataList:list];
    [chooseView seleceCell:self.selectIndex];
    [chooseView show:^(int selectIndex) {
        
        [self removeAllAnnotation];
        [clsOtherFun showLoadingView:@"Loading..."];
        weakSelf.selectIndex = selectIndex;
        [weakSelf performSelector:@selector(chooseViewFinish) withObject:nil afterDelay:1.0];
    }];
}

- (void)chooseViewFinish{
    [clsOtherFun hideLoadingView];
    switch (self.selectIndex) {
        case 0:
        {
            [self addMPAnnotations];
        }
            break;
        case 1:
        {
            [self addMDAnnotations];
        }
            break;
        case 2:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark -MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    
    if([annotation isKindOfClass:[MPAnnotation class]]){
        MPCalloutAnnotationView *annotationView=[MPCalloutAnnotationView calloutViewWithMapView:mapView :@"MPAnnotationCalloutView"];
        annotationView.annotation=annotation;
        annotationView.image=[UIImage imageNamed:@"main_icon_Parking-Metre"];
        annotationView.delegate=self;
        return annotationView;
    }else if ([annotation isKindOfClass:[MDAnnotation class]]) {
        static NSString *key=@"MKAnnotationViewKey";
        MKAnnotationView *annotationView=[self.mapKitView dequeueReusableAnnotationViewWithIdentifier:key];
        //如果缓存池中不存在则新建
        if (!annotationView) {
            annotationView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:key];
        }
        //重新设置此类大头针视图的大头针模型(因为有可能是从缓存池中取出来的，位置是放到缓存池时的位置)
        annotationView.annotation=annotation;
        annotationView.image=((MDAnnotation *)annotation).image;//设置大头针视图的图片
//        annotationView.backgroundColor = [UIColor greenColor];
//        annotationView.alpha = 0.5;
        return annotationView;
    }else if([annotation isKindOfClass:[MDCalloutAnnotation class]]){
        //对于作为弹出详情视图的自定义大头针视图无弹出交互功能（canShowCallout=false，这是默认值），在其中可以自由添加其他视图（因为它本身继承于UIView）
        MDCalloutAnnotationView *annotationView=[MDCalloutAnnotationView calloutViewWithMapView:mapView :@"MDCalloutAnnotationView"];
        annotationView.annotation = (MDCalloutAnnotation*)annotation;
//        annotationView.backgroundColor = [UIColor redColor];
//        annotationView.alpha = 0.5;
        return annotationView;
    }
    
    return nil;
}
#pragma mark --选中大头针时触发
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self.mapKitView setCenterCoordinate:view.annotation.coordinate animated:YES];
    if ([view.annotation isKindOfClass:[MDAnnotation class]]) {
        MDAnnotation *annotation=view.annotation;
        
        //添加详情大头针，渲染此大头针视图时将此模型对象赋值给自定义大头针视图完成自动布局
        MDCalloutAnnotation *calloutAnnotation=[[MDCalloutAnnotation alloc] init];
        calloutAnnotation.imgBg=annotation.imgBg;
        calloutAnnotation.iconLeft=annotation.iconLeft;
        calloutAnnotation.iconRight=annotation.iconRight;
        calloutAnnotation.address=annotation.address;
        calloutAnnotation.coordinate=view.annotation.coordinate;
        [mapView addAnnotation:calloutAnnotation];
    }
}

#pragma mark -- 取消选中时触发
-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view{
    [self removeMDCalloutAnnotation];
}

//当定位自身时调用
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    CLLocationCoordinate2D coordinate = [userLocation coordinate];
    //    NSLog(@"更新用戶位置");
    self.mapKitView.showsUserLocation = NO;
    self.userLocation = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self addMPAnnotations];
}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(nonnull NSError *)error{
    [self addMPAnnotations];
}


#pragma mark - CalloutViewClickDelegate
-(void)clickPinWithObj:(NSObject *)obj{
    NSLog(@"点击: %@",obj);
}

#pragma mark --移除自定义大头针

-(void)removeAllAnnotation{
    [self.mapKitView removeAnnotations:self.mapKitView.annotations];
}

-(void)removeMDCalloutAnnotation{
    [self.mapKitView.annotations enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[MDCalloutAnnotation class]]) {
            [self.mapKitView removeAnnotation:obj];
        }
    }];
}

@end
